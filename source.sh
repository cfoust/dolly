#!/usr/bin/env bash
#
# Source this to use dolly.

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function dolly_usage {
    echo "usage: dolly [--clean]"
    echo "  --clean Remove all caches of repo lists and run dolly."
    exit 1
}

dolly() {
  if [ "$1" == "--clean" ]; then
    clear_all_caches
  fi

  if [ -z "$DOLLY_REPO_DIR" ]; then
    echo 'You must define $DOLLY_REPO_DIR to use dolly.'
  fi

  if [ ! github_can_auth ]; then
    echo 'Please define variables for at least one hosted Git service.'
    return 1
  fi

  choice=$(bash "$SCRIPT_DIR/bin/dolly")

  if [ -z "$choice" ]; then
    return 0
  fi

  repo=$(echo "$choice" | awk '{ print $1; }')
  repo_dir="$DEV_DIRECTORY/$repo"
  clone_url=$(echo "$choice" | awk '{ print $3; }')

  if [ ! -d "$repo_dir" ]; then
    git clone "$clone_url" "$repo_dir"
  fi

  cd "$repo_dir"
}
