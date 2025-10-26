#!/usr/bin/env sh

. ./scripts/sops.sh
. ./scripts/ssh.sh

HOST=$(uname -n)
USERNAME=$(id -un)
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
  "-h" | "-?" | "--help")
    show_help
    exit 0
    ;;
  "-v" | "--VERBOSE")
    VERBOSE=1
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

nixos_install() {
  nix run github:nix-community/nixos-anywhere -- \
    --generate-hardware-config nixos-generate-config "./hosts/${HOST}/hardware-configuration.nix" \
    --extra-files "$WORKDIR" \
    --flake ".#${HOST}" \
    "root@${HOST_IP}"
}

# ---

case "$1" in
"deploy")
  menu_install

  ssh_generate_host_ssh_key

  sops_add_or_update_public_age_key "$(ssh-to-age <"/etc/ssh/ssh_host_ed25519_key.pub")" "host_${HOST}"

  sops_add_host_creation_rules "hosts/${HOST}/secrets/.*"

  # TODO: figure out how to add anchors and anchor content using yq instead
  sed -E -i "s/'([&\*].*)'/\1/" .sops.yaml

  sops_rekey

  nixos_install

  exit 0
  ;;
esac
