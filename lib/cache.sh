#!/usr/bin/env bash
#
# Caching of request responses.

CACHE_DIR="$HOME/.dolly/cache"

# Ensure the caching directory exists.
ensure_cache() {
  mkdir -p "$CACHE_DIR"
}

# Clear a single cache.
clear_cache() {
  if [ -f "$CACHE_DIR/$1" ]; then
    rm "$CACHE_DIR/$1"
  fi
}

# Clear all of the caches.
clear_all_caches() {
  rm "$CACHE_DIR/*"
}

# Save a cache.
dump_cache() {
  ensure_cache
  echo "$2" > "$CACHE_DIR/$1"
}

# Get the cache for a file.
get_cache() {
  ensure_cache
  cat "$CACHE_DIR/$1"
}

# Check whether we have a cache for a string.
have_cache() {
  ensure_cache
  loc="$CACHE_DIR/$1"

  if [ ! -f "$loc" ]; then
    return 1
  fi

  if [[ $(find "$CACHE_DIR/$1" -mtime +1 -print > /dev/null 2>&1) ]]; then
    return 1
  fi

  return 0
}
