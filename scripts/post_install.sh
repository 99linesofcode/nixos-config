#!/usr/bin/env sh

HOST=$(uname -n)
USERNAME=$(id -un)

# generate host age key
DIR="$HOME/.config/sops/age"

mkdir -p "$DIR"
chmod 700 "$DIR"
sudo ssh-to-age -private-key -i /etc/ssh/ssh_host_ed25519_key >"${DIR}/keys.txt"

# clone repositories
for repo in nixos-config home-manager; do
  git clone "git@github.com:99linesofcode/${repo}" "$HOME/.config/${repo}"
done

# install home-manager configuration
cd "$HOME/.config/home-manager" || exit
home-manager switch --flake ".#${HOST}.${USERNAME}"
