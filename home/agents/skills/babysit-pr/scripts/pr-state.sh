#!/usr/bin/env bash
# Print the current PR's state, open feedback, and checks as one JSON object.
# Usage: pr-state.sh [pr-number|url|branch]
set -euo pipefail

pr_arg=${1:-}
num=$(gh pr view ${pr_arg:+"$pr_arg"} --json number -q .number)
repo=$(gh repo view --json owner,name -q '.owner.login + "/" + .name')
me=$(gh api user -q .login)

raw=$(gh api graphql -F owner="${repo%/*}" -F name="${repo#*/}" -F num="$num" -f query='
query($owner: String!, $name: String!, $num: Int!) {
  repository(owner: $owner, name: $name) {
    pullRequest(number: $num) {
      number url title state isDraft reviewDecision mergeStateStatus mergeable
      headRefName baseRefName headRefOid
      author { login }
      reviewRequests(first: 20) {
        nodes { requestedReviewer { ... on User { login } ... on Team { slug } } }
      }
      reviewThreads(first: 100) {
        nodes {
          id isResolved isOutdated path line
          comments(first: 50) { nodes { databaseId author { login } body createdAt url } }
        }
      }
      reviews(last: 50) { nodes { databaseId author { login } state body submittedAt url } }
      comments(last: 100) { nodes { databaseId author { login } body createdAt url } }
    }
  }
}')

# gh pr checks exits non-zero while checks fail or are pending; the JSON is still valid.
checks=$(gh pr checks "$num" --json name,state,bucket,link,workflow 2>/dev/null || true)
[ -n "$checks" ] || checks='[]'

jq -n --arg me "$me" --arg repo "$repo" --argjson raw "$raw" --argjson checks "$checks" '
  $raw.data.repository.pullRequest as $p
  | def who: .author.login // "ghost";
  {
    repo: $repo,
    me: $me,
    pr: ($p | {number, url, title, state, isDraft, reviewDecision, mergeStateStatus, mergeable,
                headRefName, baseRefName, headRefOid, author: .author.login,
                pendingReviewers: [.reviewRequests.nodes[].requestedReviewer | .login // .slug]}),
    approvedBy: [$p.reviews.nodes
      | map(select(.state == "APPROVED" or .state == "CHANGES_REQUESTED" or .state == "DISMISSED"))
      | group_by(who)[] | last | select(.state == "APPROVED") | who],
    threads: [$p.reviewThreads.nodes[] | select(.isResolved | not)
      | {id, path, line, isOutdated,
         lastBy: (.comments.nodes | last | who),
         comments: [.comments.nodes[] | {id: .databaseId, by: who, body, createdAt, url}]}],
    reviews: [$p.reviews.nodes[] | select(who != $me)
      | select((.body // "") != "" or .state == "CHANGES_REQUESTED")
      | {id: .databaseId, by: who, state, body, submittedAt, url}],
    comments: [$p.comments.nodes[] | select(who != $me)
      | {id: .databaseId, by: who, body, createdAt, url}],
    checks: {
      rollup: (if any($checks[]; .bucket == "fail" or .bucket == "cancel") then "fail"
               elif any($checks[]; .bucket == "pending") then "pending"
               elif ($checks | length) == 0 then "none"
               else "pass" end),
      failing: [$checks[] | select(.bucket == "fail" or .bucket == "cancel")],
      pending: [$checks[] | select(.bucket == "pending") | .name]
    }
  }'
