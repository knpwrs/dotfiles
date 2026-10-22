#!/usr/bin/env bash
# Print a bare-bones review request for one or more PR URLs, phrasing picked at random from
# ../messages/{single,stack,multi}.txt.
# Usage: pick-message.sh [--stack] <url>...
set -euo pipefail

messages=$(cd "$(dirname "$0")/../messages" && pwd)
stack=0
if [ "${1:-}" = "--stack" ]; then stack=1; shift; fi
[ $# -gt 0 ] || { echo "usage: pick-message.sh [--stack] <url>..." >&2; exit 5; }

pick() {
  local lines=() line
  while IFS= read -r line; do
    case $line in ''|'#'*) ;; *) lines+=("$line") ;; esac
  done <"$messages/$1.txt"
  echo "${lines[RANDOM % ${#lines[@]}]}"
}

if [ $# -eq 1 ]; then
  msg=$(pick single)
  echo "${msg//\{url\}/$1}"
  exit 0
fi

if [ $stack -eq 1 ]; then pick stack; else pick multi; fi
printf '%s\n' "$@"
