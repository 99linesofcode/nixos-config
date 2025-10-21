#!/usr/bin/env sh

cmd_git() {
  main_branch="${remote_branch##*/}"
  current_branch="$(git branch --show-current)"
  remote_branch="$(git symbolic-ref refs/remotes/"${remote:-origin}"/HEAD)"
  stash_label="$(od -An -N20 -tx1 /dev/urandom | tr -d ' \n')"

  git stash -m "$stash_label"

  "$@"

  git add .
  git commit -m "chore(sops): generated and rekeyed secrets for host_${HOST}"
  git stash list | grep "${stash_label}" && git stash pop --index
}
