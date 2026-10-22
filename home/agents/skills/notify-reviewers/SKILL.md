---
name: notify-reviewers
description: >
  Draft a bare-bones direct message to each reviewer of one or more ready pull requests, in
  whatever messaging connector is available (Slack, Teams, and so on), one message per reviewer
  covering all of their PRs. Reviewers come from GitHub's review requests (code owners,
  auto-assignment) or from the user. Creates drafts only and never sends. Use when asked to
  notify, ping, nudge, or message reviewers about a PR or stack, or after marking PRs ready.
argument-hint: "[<PR number>|<url>|stack]... [reviewer...]"
---

# Notify reviewers

Draft one short message per reviewer for the PRs in `$ARGUMENTS`: the current branch's PR if none
are named, every open PR in the current stack for `stack`. Other words in `$ARGUMENTS` (GitHub
logins, names) are reviewers the user wants. Scripts live next to this file in `scripts/`; call
them by absolute path.

## Never send

Only create drafts. Never call a tool that sends, posts, or schedules a message, even if the user
seems to expect it; tell them the drafts are waiting and let them send. If the messaging connector
has no draft tool, print each message and its recipient for the user to send themselves.

## 1. Check the PRs are ready

Draft PRs have no reviewers yet: code owners and auto-assignment only request reviews once a PR is
marked ready. If any PR is a draft, say so and stop, unless the user already asked for it to be
marked ready in this conversation (as `/work-ticket` and `/work-stack` offer), in which case run
`gh pr ready <number>` for it first.

## 2. Find the reviewers

1. `scripts/reviewers.sh --wait 60 <pr>...` prints each PR's requested users and teams, who has
   already reviewed, and each user's GitHub name and public email. `--wait` gives auto-assignment
   time to land after a PR is marked ready.
2. Reviewers the user named: if one is not already requested on a PR, request them with
   `gh pr edit <number> --add-reviewer <login>` (the user asked for them). If the user named
   reviewers, they replace the GitHub list for messaging, unless the user said "also".
3. Leave out the PR author and anyone who has already reviewed the latest changes, unless the user
   named them.
4. A team request with no individual behind it: ask the user who to message, or whether to post
   in a team channel instead (still as a draft).
5. If no PR has a reviewer after waiting, say so and ask who should review.

Reviewers are per PR. In a stack, different layers often have different reviewers (code owners
follow the files each layer touches), and one person can be on several layers. Build the map from
each PR's own reviewers, then invert it: each person gets exactly one message listing only the
PRs they are on, which may be one layer, several, or non-adjacent layers. A reviewer the user
named applies to every PR in scope unless the user said which ones.

## 3. Find each reviewer in the messaging app

1. Look at the available tools for messaging connectors (Slack, Microsoft Teams, Google Chat,
   Discord, and so on) and use one that can create drafts. If several can, ask once which to use.
   If none is connected, print the messages instead.
2. Check the repository's own context first: its agent instructions (`CLAUDE.md`, `AGENTS.md`,
   and the like, including any already loaded into the conversation) and nearby docs may map
   GitHub logins to messaging user ids, or name a channel for review requests. A mapping there
   wins over everything below. A repo-named channel is where messages go only if the repo says
   review requests should be posted there instead of sent as DMs.
3. Then the people file: `${XDG_STATE_HOME:-$HOME/.local/state}/notify-reviewers/people.json`,
   a map from GitHub login to `{connector: user id}`.
4. Otherwise search the connector's user directory by GitHub name, then public email, then the
   parts of the login (`jdoe-acme` → `jdoe`, `doe`). Accept a match only when it is unambiguous;
   otherwise ask the user, listing the candidates. Batch these questions.
5. Save every match you confirmed by search or by asking to the people file so later runs skip
   the lookup. Do not copy repo mappings into it; the repo stays the source for those.

## 4. Draft

1. Build each message with `scripts/pick-message.sh <url>...`, which picks a phrasing at random
   from `messages/single.txt`, `stack.txt`, or `multi.txt` (one phrasing per line; add more there).
   For a reviewer's PRs from one stack, pass `--stack` and their URLs in stack order, bottom
   first; with a single URL it falls back to a one-PR message. Use its output as is:
   no greeting, no PR summary, no extra words.
2. Create the draft in a direct message to that reviewer (in Slack, `slack_send_message_draft`
   with the user id as the channel). If a draft already exists in that conversation, do not
   overwrite it; tell the user and show the message instead.
3. Report each draft: reviewer, the PRs it covers, the message text, and a link to the
   conversation when the tool returns one. Remind the user the drafts are unsent.
