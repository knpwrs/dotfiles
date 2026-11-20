---
name: review-pr
description: >
  Review someone's pull request, verify every finding against the code at the PR's head, and draft
  inline review comments for the ones that hold up. A fresh subagent runs /code-review and only
  reports; you check each finding (is it real, reachable, introduced by this PR, and is any
  suggested fix correct), drop the rest with a reason, and draft short comments. Posts nothing
  until the user approves the drafts, then posts them as one review. Use when asked to review,
  verify, and comment on a PR, to "draft inline comments", or to turn /code-review findings into
  PR comments.
argument-hint: "<PR number>|<url> [low|medium|high|xhigh] [focus note]"
---

# Review a PR and draft inline comments

Review the PR in `$ARGUMENTS`, verify each finding yourself, and draft inline comments for the
ones that survive. A review effort level in the arguments goes to `/code-review` (default
`high`). Any other words are a focus note for the reviewer.

Unverified `/code-review` findings are often wrong in the same ways: the scenario can't be
reached, the behavior already existed on the base branch, the flagged line was only moved, or
the suggested fix doesn't compile. The verify step exists to catch these before they reach
someone else's PR.

## Permissions

Allowed without asking: reading the PR with `gh`, fetching its head into a local ref, reading
files, spawning the review subagent, and writing to the scratchpad. Ask first: posting anything.
Never approve, request changes, resolve threads, or check out the PR over the user's working
tree.

## 1. Load the PR

- `gh pr view <n> --json title,body,author,headRefOid,baseRefName,files` for the head SHA, the
  stated intent, and the PR's own file list.
- `git fetch origin pull/<n>/head:pr-<n>`. Read files at the head with
  `git show pr-<n>:<path>`, never from the working tree, which may be on another branch.
- Get the PR's own diff with `gh pr diff <n>`. `git diff <base>...pr-<n>` can include commits
  merged in from the base and show files the PR doesn't touch.

## 2. Review

Spawn one `general-purpose` subagent and wait for it. Don't review the same diff yourself
meanwhile.

> Review PR #<n> and report findings only. Do not edit files, commit, or post anything.
> Invoke the `code-review` skill with args `<level> --max-findings default <n>`, without
> `--comment` or `--fix`. The PR's stated intent: `<title and a line or two from the body>`.
> `<Focus note, if any.>` If the skill reports findings through a tool, also include them in
> your final message. Return each finding as `path:start_line[-end_line]` (at the PR head),
> category, what is wrong, and the concrete failure it causes.

If the user already ran `/code-review` on this PR in the conversation, use those findings and
skip the subagent.

## 3. Verify each finding

Read the code at the head for each finding, plus whatever it depends on (callers, effect deps,
the module a test mocks). Give each finding one verdict: **Post** or **Drop**, with a reason.

- **Real?** Trace the failure scenario through the code. Drop it if an earlier step makes it
  impossible (state cleared before the trigger can happen, an element that doesn't exist, a
  guard upstream).
- **Introduced here?** Check the line is added in `gh pr diff`. A line the PR only moved, or
  behavior already on the base branch, is a Drop. The exception: the PR touched that code and
  its new comment, docstring, or description claims the opposite. Post that and say it's
  pre-existing.
- **Intended?** Drop it if a nearby comment or the PR description says the behavior is
  deliberate, unless the design itself is worth questioning. Then post a question, not a bug
  report.
- **Rule violations** (AGENTS.md, CLAUDE.md) count only on lines the PR adds. Cite the rule.
- **Suggested fix correct?** Before you propose code, check that it type-checks against the
  real types and keeps every path the original covered. A cast that looks unnecessary may be
  forced by a mock. A one-line simplification may break a case only the original handled.
- **Anchorable?** The line must fall inside a hunk of the PR's diff, or GitHub rejects the
  comment. If it doesn't, attach the comment to the nearest added line and name the real one.

## 4. Draft

Write each Post finding as one inline comment, following the `no-slop` skill and the repo's
writing rules:

- Lead with the failure: what the user or caller sees, and when.
- Write a few sentences at most. No preamble, no "great work", no restating the diff.
- Use a ```` ```suggestion ```` block only for a fix you verified that replaces exactly the
  anchored lines. Otherwise describe the fix in a sentence.
- Phrase questions about intent or scope as questions.
- Prefix style and convention items with `nit:`.
- Fold several sightings of the same issue into one comment and name the other locations.

Write the review to `<scratchpad>/review-<n>.json` for `POST /repos/{owner}/{repo}/pulls/<n>/reviews`:
`commit_id` set to the head SHA, `event: "COMMENT"`, an empty `body` unless a summary adds
something, and `comments[]` of `{path, line, side: "RIGHT", body}` (add `start_line` for a
range).

## 5. Show, then post

Show the user:

- the dropped findings, one line each with the reason;
- each draft comment with its `path:line`, quoted in full;
- what will be posted: one review with the "Comment" status, how many comments, and on whose PR.

Ask before posting. If the user edits a draft, update the JSON. On an explicit go, first
re-run `gh pr view <n> --json headRefOid`. If the head moved since step 1, fetch it again,
re-verify each draft against the new head (the line may have changed or left the diff), update
`commit_id` and the anchors, and show the drafts again before posting. Otherwise, post with
`gh api -X POST repos/{owner}/{repo}/pulls/<n>/reviews --input <file>`, then report the review
URL. Approval covers this set of drafts only. Show anything added later again before posting it.
