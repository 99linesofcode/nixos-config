#!/usr/bin/env sh

sops_create_or_update_public_age_key() {
  anchor="$1"
  key="$2"
  file="${3:-$PWD/.sops.yaml}"

  if [ -n "$(yq ".keys[] | select(anchor == \"${anchor}\")" "$file")" ]; then
    if [ "$VERBOSE" -eq 1 ]; then
      echo "Age key '${key}' for '${anchor}' was added before. Updating."
    fi

    yq -i "(.keys[] | select(anchor == \"${anchor}\")) |= \"${key}\"" "$file"
  else
    if [ "$VERBOSE" -eq 1 ]; then
      echo "Adding new age key '${key}' for '${anchor}'."
    fi

    yq -i ".keys += (\"${key}\" | . anchor = \"${anchor}\")" "$file"
  fi
}

sops_create_or_update_creation_rules() {
  path="$1"
  anchor="${2:-host_$(echo "$1" | awk -F'/' '{print $2}')}"
  file="${3:-$PWD/.sops.yaml}"

  if [ -n "$(yq ".creation_rules[].path_regex | select(. == \"${path}\")" "$file")" ]; then
    if [ "$VERBOSE" -eq 1 ]; then
      echo "creation_rules for path_regex '${path}' were already added before. Updating."
    fi

    # TODO: add or update

    yq -i "(.creation_rules[] | select(.path_regex == \"${path}\").key_groups[0].age) += (\"${anchor}\" | . alias |= .)" "$file"
  else
    if [ "$VERBOSE" -eq 1 ]; then
      echo "Adding new creation_rules for path_regex '${path}'."
    fi

    yq -i ".creation_rules += [{\"path_regex\": \"${path}\", \"key_groups\": [{\"age\": [(\"master\" | . alias |= .), (\"${anchor}\" | . alias |= .)]}]}]" "$file"
  fi
}

sops_rekey() {
  file="${1:-$PWD/.sops.yaml}"
  dir=${file%/*}

  find "$dir" -type f -path "*/secrets/*" -exec sops --config "${dir}/.sops.yaml" updatekeys -y {} \;
}
