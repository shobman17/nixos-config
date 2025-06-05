#!/usr/bin/env bash
# nix-view-source-enhanced: Works with packages and NixOS options
# Usage: nix-view-source-enhanced <package-name|option-path>

check_deps() {
  local missing=()
  for cmd in bat nix-search-tv nixos-option; do
    if ! command -v "$cmd" &>/dev/null; then
      missing+=("$cmd")
    fi
  done

  if [ ${#missing[@]} -gt 0 ]; then
    echo "Missing dependencies: ${missing[*]}" >&2
    exit 1
  fi
}

check_deps

# Check if input is an option (contains dot)
if [[ "$1" == *.* ]]; then

  # Get option declaration locations
  FILES_LINES=$(nixos-option "$1" 2>/dev/null |
    grep -m1 '^Declared by:' |
    awk '{print $3}' |
    sed "s/'//g")

  # Extract first occurrence (most relevant)
  FILE_PATH=$(echo "$FILES_LINES" | head -n1 | cut -d: -f1)
  # LINE_NUMBER=$(echo "$FILES_LINES" | head -n1 | cut -d: -f2)
else
  # Handle regular packages
  DERIVATION=$(nix eval "nixpkgs#$1.meta.position" 2>/dev/null | sed 's/"//g')
  FILE_PATH=$(echo "$DERIVATION" | cut -d: -f1)
  LINE_NUMBER=$(echo "$DERIVATION" | cut -d: -f2)
fi

# Display with syntax highlighting
if [ -f "$FILE_PATH" ]; then
  # bat --style=plain --color=always --line-range "$LINE_NUMBER:" "$FILE_PATH" 2>/dev/null ||
  bat --style=plain --color=always "$FILE_PATH" 2>/dev/null ||
    echo "Source not found. Install bat: nix-shell -p bat"
else
  echo "No source location found for: $1"
  exit 1
fi
