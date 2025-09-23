#!/usr/bin/env sh

set -eu

VERBOSE=0

show_help() {
  cat <<EOF
Usage: $0 [OPTION] [ARGUMENT]

Options:
  -h, -?, --help  Show this help message
  -v, --verbose   Enable verbose mode

Commands:
  install         Remotely install a new NixOS system using nixos-anywhere

Examples:
  $0 --help
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
  "-v" | "--VERBOSE")
    VERBOSE=1
    ;;
  "-h" | "-?" | "--help")
    show_help
    exit 0
    ;;
  --)
    shift
    break
    ;;
  *) break ;;
  esac
  shift
done

# ---

WORKDIR=$(mktemp -d)

menu_install() {
  echo "Enter target host IP address: "
  read HOST_IP
  echo "Enter hostname: "
  read HOST
  echo "Enter username: "
  read USERNAME
}

task_pre_install() {
  # generate SSH keys
  install -d -m755 "${WORKDIR}/etc/ssh"
  ssh-keygen -t ed25519 -f "${WORKDIR}/etc/ssh/ssh_host_ed25519_key" -C "${USERNAME}@${HOST}" -N ""
  chmod 600 "${WORKDIR}/etc/ssh/ssh_host_ed25519_key"

  public_age_key=$(ssh-to-age <"${WORKDIR}/etc/ssh/ssh_host_ed25519_key.pub")

  # generate sops configurations
  for dir in nixos-config home-manager; do
    path="/home/${USERNAME}/.config/${dir}"
    filepath="${path}/.sops.yaml"
    branch=$(git -C "$path" branch --show-current)

    # skip
    if grep -q "${HOST}_${USERNAME}" "$filepath"; then
      if [ "$VERBOSE" -eq 1 ]; then
        echo "${HOST}_${USERNAME} secrets were already generated for ${dir}. Skipped."
      fi
      continue
    fi

    # stash
    git -C "$path" stash push
    git -C "$path" checkout main
    git -C "$path" pull

    # generate
    touch "$filepath"
    yq -i ".keys += \"&${HOST}_${USERNAME} ${public_age_key}\"" "$filepath"
    yq -i ".creation_rules[0].key_groups[0].age += [\"*${HOST}_${USERNAME}\"]" "$filepath"
    yq -i ".creation_rules += [{\"path_regex\": \"hosts/${HOST}/secrets/.*\", \"key_groups\": [{\"age\": [\"*master\", \"*luna_shorty\", \"*${HOST}_${USERNAME}\"]}]}]" "$filepath"
    yq -i ".creation_rules += [{\"path_regex\": \"hosts/${HOST}/users/${USERNAME}/secrets/.*\", \"key_groups\": [{\"age\": [\"*master\", \"*luna_shorty\", \"*${HOST}_${USERNAME}\"]}]}]" "$filepath"
    sed -E -i "s/'([&\*].*)'/\1/" "$filepath"

    # commit
    git -C "$path" add ".sops.yaml"
    git -C "$path" commit -m "chore: add secrets for ${HOST}_${USERNAME} to .sops.yaml"
    git -C "$path" push

    # pop
    git -C "$path" checkout "$branch"
    git -C "$path" stash pop
  done
}

task_install() {
  nix run github:nix-community/nixos-anywhere -- \
    --generate-hardware-config nixos-generate-config "./hosts/${HOST}/hardware-configuration.nix" \
    --extra-files "$WORKDIR" \
    --flake ".#${HOST}" \
    "root@${HOST_IP}"
}

cmd_ssh() {
  ssh \
    -o ControlPath=none \
    -o ForwardAgent=yes \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    "${USERNAME}@${HOST_IP}" \
    "$@"
}

# ---

case "$1" in
"install")
  menu_install
  task_pre_install
  task_install
  cmd_ssh "./scripts/post_install.sh"
  exit 0
  ;;
esac
