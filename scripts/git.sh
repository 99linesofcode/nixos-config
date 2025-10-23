#!/usr/bin/env sh

cmd_git() {
  remote="$(git symbolic-ref refs/remotes/origin/HEAD)"
  stash_label="$(od -An -N8 -tx1 /dev/urandom | tr -d ' \n')"

  main_branch="${remote##*/}"
  current_branch="$(git branch --show-current)"

  git stash -m "$stash_label"
  git checkout "$main_branch"

  "$@"

  git add .
  git commit -m "chore(sops): generated and rekeyed secrets for host_${HOST}"
  git push

  git checkout "$current_branch"
  git stash list | grep "${stash_label}" && git stash pop --index
}
