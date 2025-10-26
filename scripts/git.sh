#!/usr/bin/env sh

cmd_git() {
  stash_label="$(od -An -N8 -tx1 /dev/urandom | tr -d ' \n')"

  git stash -m "$stash_label"

  "$@"

  git add .
  git commit -m "chore(sops): generated and rekeyed secrets for host_${HOST}"

  git stash list | grep "${stash_label}" && git stash pop --index
}
