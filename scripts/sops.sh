#!/usr/bin/env sh

sops_create_or_update_public_age_key() {
  anchor="$1"
  key="$2"

  if yq ".keys[] | select(anchor == \"${anchor}\")"; then
    if [ "$VERBOSE" -eq 1 ]; then
      echo "Age key ${key} for ${anchor} was added before. Updating."
    fi

    yq -i "(.keys[] | select(anchor == \"${anchor}\")) |= \"${key}\")" .sops.yaml
    return
  fi

  if [ "$VERBOSE" -eq 1 ]; then
    echo "Adding new age key ${key} for ${anchor}."
  fi

  yq -i ".keys += \"&${anchor} ${key}\"" .sops.yaml
}

sops_add_host_creation_rules() {
  path="$1"

  if yq ".creation_rules[].path_regex | select(. == \"${path}\")"; then
    if [ "$VERBOSE" -eq 1 ]; then
      echo "creation rules for host ${HOST} were already added before. Skipping."
    fi

    return
  fi

  # hosts/shared/secrets/.*
  yq -i ".creation_rules[] | select(.path_regex == \"hosts/shared/secrets/.*\").key_groups[0].age += [\"*host_${HOST}\"]" .sops.yaml

  # hosts/${HOST}/secrets/.*
  yq -i ".creation_rules += [{\"path_regex\": \"${path}\", \"key_groups\": [{\"age\": [\"*master\", \"*host_${HOST}\"]}]}]" .sops.yaml
}

sops_add_user_creation_rules() {
  # users/${user}/secrets/.*
  find ./users -maxdepth 1 -type d ! -name ".*" >tmp

  while IFS= read -r user; do
    if yq ".creation_rules[] | select(.path_regex == \"users/${user}/secrets/.*\").key_groups[0].age[] | select(alias == \"host_${HOST}\")"; then
      if [ "$VERBOSE" -eq 1 ]; then
        echo "creation rules for user ${user} were already added before. Skipping."
      fi

      continue
    fi

    yq -i ".creation_rules[] | select(.path_regex == \"users/${user}/secrets/.*\").key_groups[0].age += [\"*host_${HOST}\"]" .sops.yaml
  done <tmp

  rm tmp
}

sops_rekey() {
  find . -type f -path "*/secrets/*" -exec sops updatekeys {} \;
}
