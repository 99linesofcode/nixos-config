#!/usr/bin/env sh

sops_create_or_update_public_age_key() {
  anchor="$1"
  key="$2"

  if [ -n "$(yq ".keys[] | select(anchor == \"${anchor}\")" .sops.yaml)" ]; then
    if [ "$VERBOSE" -eq 1 ]; then
      echo "Age key '${key}' for '${anchor}' was added before. Updating."
    fi

    yq -i "(.keys[] | select(anchor == \"${anchor}\")) |= \"${key}\"" .sops.yaml
    return
  fi

  if [ "$VERBOSE" -eq 1 ]; then
    echo "Adding new age key '${key}' for '${anchor}'."
  fi

  yq -i ".keys += (\"${key}\" | . anchor = \"${anchor}\")" .sops.yaml
}

sops_add_host_creation_rules() {
  path="$1"
  host="host_$(echo "$1" | awk -F'/' '{print $2}')"

  if [ -n "$(yq ".creation_rules[].path_regex | select(. == \"${path}\")" .sops.yaml)" ]; then
    if [ "$VERBOSE" -eq 1 ]; then
      echo "creation_rules for '${host}' were already added before. Skipping."
    fi

    return
  fi

  if [ "$VERBOSE" -eq 1 ]; then
    echo "Adding new creation_rules for '${host}'."
  fi

  # hosts/shared/secrets/.*
  yq -i "(.creation_rules[] | select(.path_regex == \"hosts/shared/secrets/.*\").key_groups[0].age) += (\"${host}\" | . alias |= .)" .sops.yaml

  # hosts/${HOST}/secrets/.*
  yq -i ".creation_rules += [{\"path_regex\": \"${path}\", \"key_groups\": [{\"age\": [(\"master\" | . alias |= .), (\"${host}\" | . alias |= .)]}]}]" .sops.yaml
}

sops_add_user_creation_rules() {
  host="$1"

  # users/${user}/secrets/.*
  find ./users -mindepth 1 -maxdepth 1 -type d ! -name ".*" -printf '%f\n' >tmp

  while IFS= read -r user; do
    if [ -n "$(yq ".creation_rules[] | select(.path_regex == \"users/${user}/secrets/.*\").key_groups[0].age[] | select(alias == \"${host}\")" .sops.yaml)" ]; then
      if [ "$VERBOSE" -eq 1 ]; then
        echo "creation_rules for '${host}' for 'user_${user}' were already added before. Skipping."
      fi

      continue
    fi

    if [ "$VERBOSE" -eq 1 ]; then
      echo "Adding new creation_rules for '${host}' to 'user_${user}.'"
    fi

    yq -i "(.creation_rules[] | select(.path_regex == \"users/${user}/secrets/.*\").key_groups[0].age) += (\"${host}\" | . alias |= .)" .sops.yaml
  done <tmp

  rm tmp
}

sops_rekey() {
  find . -type f -path "*/secrets/*" -exec sops updatekeys -y {} \;
}
