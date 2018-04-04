#!/usr/bin/env bash
#
# Interface for GitHub.

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$SCRIPT_DIR/cache.sh"

API_URL="https://api.github.com"

# Check whether we have the environment variables for GitHub.
github_can_auth() {
  [ ! -z "$DOLLY_GITHUB_USERNAME" ] || [ ! -z "$DOLLY_GITHUB_TOKEN" ]
}

# Get all of the repositories we can.
# Results are in the format "[org or username]/[project name] [ssh url]"
github_get_repos() {
  cache_name="github.user.repos"

  if have_cache "$cache_name"; then
    repos=$(get_cache "$cache_name")
  else
    repos=$(curl -s -u "$DOLLY_GITHUB_USERNAME":"$DOLLY_GITHUB_TOKEN" "$API_URL/user/repos?per_page=100")
    dump_cache "$cache_name" "$repos"
  fi

  read -d '' pycode <<"EOF"
import sys, json

data = json.load(sys.stdin)
repos = map(lambda x: x['full_name'] + ' ' + x['ssh_url'], data)
print('\\n'.join(repos))
EOF

  repos=$(echo "$repos" | python -c "$pycode")

  echo "$repos"
}
