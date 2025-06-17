# shellcheck shell=bash

declare -gA args

validate_is_attribute() {
  IMPURE=${args[--impure]:-0}

  NIX_FLAGS=()
  if [ "$IMPURE" -eq 1 ]; then
    NIX_FLAGS=(--impure)
  fi

  if ! nix eval ".#$1" "${NIX_FLAGS[@]}" &>/dev/null; then
    echo "Attribute '$1' does not exist."
  fi
}
