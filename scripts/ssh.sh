#!/usr/bin/env sh

cmd_ssh() {
  uri="${1:-${USERNAME}@${HOST}}"

  shift

  ssh \
    -o ControlPath=none \
    -o ForwardAgent=yes \
    -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    "$uri" \
    "$@"
}

ssh_generate_host_ssh_key() {
  # TODO: persistence
  install -d -m755 "${WORKDIR}/etc/ssh"
  ssh-keygen -t ed25519 -f "${WORKDIR}/etc/ssh/ssh_host_ed25519_key" -C "${USERNAME}@${HOST}" -N ""
  chmod 600 "${WORKDIR}/etc/ssh/ssh_host_ed25519_key"
}
