#!/usr/bin/env bash
# Block until a PR (or every PR in the current stack) changes in a way worth acting on, then
# print the new state. Ignores per-check churn; wakes on new feedback, a new head commit, a
# review decision, a merge-state change, a PR state change, the check rollup settling, or a
# stack layer merging, queueing, or needing a rebase.
# Usage: wait-for-change.sh [<pr>|--stack] [interval-seconds=60] [max-seconds=1800]
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
target=${1:-}
interval=${2:-60}
max=${3:-1800}

read_state() {
  if [ "$target" = "--stack" ]; then "$here/stack-state.sh"; else "$here/pr-state.sh" $target; fi
}

fingerprint() {
  jq -c '
    def pr: {n: .pr.number, s: .pr.state, d: .pr.isDraft, h: .pr.headRefOid,
             r: .pr.reviewDecision, m: .pr.mergeStateStatus, a: .approvedBy, c: .checks.rollup,
             f: [.checks.failing[].name],
             t: [.threads[] | {id, n: (.comments | length)}],
             v: [.reviews[].id], k: [.comments[].id]};
    if has("layers") then {l: [.layers[] | {name, isMerged, isQueued, needsRebase}], p: [.prs[] | pr]}
    else pr end' <<<"$1"
}

state=$(read_state)
start=$(fingerprint "$state")
deadline=$(( $(date +%s) + max ))

while [ "$(date +%s)" -lt "$deadline" ]; do
  sleep "$interval"
  state=$(read_state) || continue
  if [ "$(fingerprint "$state")" != "$start" ]; then
    echo "CHANGED"
    echo "$state"
    exit 0
  fi
done
echo "TIMEOUT"
echo "$state"
