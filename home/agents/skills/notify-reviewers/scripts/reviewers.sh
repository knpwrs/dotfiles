#!/usr/bin/env bash
# Print the requested reviewers of each PR as JSON, with each user's name and public email.
# Code-owner and team auto-assignment happens when a PR is marked ready, and can lag a few
# seconds, so with --wait it polls until every ready PR has a reviewer or the time runs out.
# Usage: reviewers.sh [--wait <seconds>] <pr>...
set -euo pipefail

wait=0
if [ "${1:-}" = "--wait" ]; then wait=$2; shift 2; fi
[ $# -gt 0 ] || { echo "usage: reviewers.sh [--wait <seconds>] <pr>..." >&2; exit 5; }

read_pr() {
  gh pr view "$1" --json number,url,title,isDraft,author,reviewRequests,latestReviews \
    -q '{number, url, title, isDraft, author: .author.login,
         users: [.reviewRequests[] | select(.__typename == "User") | .login],
         teams: [.reviewRequests[] | select(.__typename == "Team") | .slug // .name],
         reviewed: [.latestReviews[].author.login]}'
}

read_all() {
  for pr in "$@"; do read_pr "$pr"; done | jq -s .
}

prs=$(read_all "$@")
deadline=$(( $(date +%s) + wait ))
while jq -e 'any(.[]; (.isDraft | not) and (.users | length) == 0 and (.teams | length) == 0)' \
      <<<"$prs" >/dev/null && [ "$(date +%s)" -lt "$deadline" ]; do
  sleep 5
  prs=$(read_all "$@")
done

people='{}'
for login in $(jq -r '[.[].users[]] | unique[]' <<<"$prs"); do
  person=$(gh api "users/$login" -q '{login, name, email}' 2>/dev/null || echo "{\"login\":\"$login\"}")
  people=$(jq --argjson p "$person" '. + {($p.login): $p}' <<<"$people")
done

jq -n --argjson prs "$prs" --argjson people "$people" '{prs: $prs, people: $people}'
