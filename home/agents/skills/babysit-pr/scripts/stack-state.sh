#!/usr/bin/env bash
# Print the current stack's layers plus pr-state.sh output for every open PR in it.
# Run from a branch in the stack.
set -euo pipefail

here=$(cd "$(dirname "$0")" && pwd)
stack=$(gh stack view --json)

prs='[]'
for n in $(jq -r '.branches[] | select(.isMerged | not) | .pr | select(.state == "OPEN") | .number' <<<"$stack"); do
  prs=$(jq --argjson s "$("$here/pr-state.sh" "$n")" '. + [$s]' <<<"$prs")
done

jq -n --argjson stack "$stack" --argjson prs "$prs" '{
  trunk: $stack.trunk,
  currentBranch: $stack.currentBranch,
  layers: [$stack.branches[] | {name, isMerged, isQueued, needsRebase, pr: (.pr // null)}],
  prs: $prs
}'
