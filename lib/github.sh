#!/usr/bin/env bash
#
# Interface for GitHub.

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$SCRIPT_DIR/cache.sh"

# Get all of the repositories we can.
# Results are in the format "[org or username]/[project name] [ssh url]"
github_get_repos() {
  cache_name="github.user.repos"

  if have_cache "$cache_name"; then
    repos=$(get_cache "$cache_name")
  else
    repos=$(gh repo list -L 100 --json nameWithOwner,sshUrl -t '{{range .}}{{.nameWithOwner}} {{.sshUrl}}{{printf "\n"}}{{end}}')
    dump_cache "$cache_name" "$repos"
  fi

  echo "$repos"
}
