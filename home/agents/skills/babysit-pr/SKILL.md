---
name: babysit-pr
description: >
  Watch the current pull request, or every PR in the current gh-stack stack, until it merges:
  triage new review comments, review threads, bot findings, and CI failures as they arrive, fix
  what is worth fixing, push, draft terse replies for approval, and merge once all feedback is
  handled, checks are green, and the PR is approved. Use when asked to babysit, shepherd, watch,
  monitor, or land a PR or a stack, or to "handle the feedback and merge". Never posts a comment,
  reply, or thread resolution without the user's approval.
argument-hint: "[<PR number>|<url>|<branch>|stack]"
---

# Babysit a PR

Drive one PR, or one stack of PRs, to merged. Scripts live next to this file in `scripts/`; call
them by absolute path.

**Mode.** If `$ARGUMENTS` is `stack`, or is empty and `gh stack view --json` succeeds on the
current branch, babysit the whole stack: load the gh-stack skill and follow its non-interactive
rules, then apply **Stacks** below on top of everything else here. Otherwise babysit the single PR
for the current branch, or the one `$ARGUMENTS` names.

## Permissions

Allowed without asking:

- Edit code, run local checks, commit, and push to the PR branch (every branch in the stack, in
  stack mode).
- Rebase onto the base branch, resolve merge conflicts (keeping the intent of both sides), and
  force-push the PR branch with `git push --force-with-lease`. In stack mode, `gh stack rebase`,
  `gh stack sync`, and `gh stack push`. Never force-push a branch outside the PR or stack.
- Rerun a failed CI job once when the log shows a flake unrelated to the diff.
- Merge, once every condition under **Merge** holds.

Ask first:

- Posting anything: replies, top-level comments, reviews, reactions, thread resolutions. Draft
  them, show them, post only what the user approves (approval may come with edits).
- Any change you are unsure the reviewer wants, any design disagreement, any scope expansion.
- Marking a draft PR ready, requesting reviewers, editing the PR title or body, restructuring a
  stack (adding, removing, or reordering layers).

Asking the user is always acceptable. Prefer one batched question over several small ones.

## Setup

1. Read state. Single PR: `scripts/pr-state.sh $ARGUMENTS` prints the PR, unresolved threads,
   reviews with bodies, conversation comments, approvals, and a check rollup as JSON. Stack:
   `scripts/stack-state.sh` prints the layers (bottom first) and the same object for every open
   PR in `prs`. If there is no PR, stop and say so. If nothing is `OPEN`, report it and stop.
2. Check out the PR head (or the stack's top) locally if you are not on it, and make sure the
   working tree is clean. If it is not clean, ask before touching it.
3. Keep a ledger per PR at `$(git rev-parse --git-dir)/babysit-pr/<number>.json`, keyed by comment
   or review id, recording what you did: `fixed <sha>`, `drafted`, `posted`, `asked`, `skipped
   <reason>`, `none <reason>`. Read it on start so a restart does not redo work. An item is new when
   its id is not in the ledger. A thread whose latest comment id is not in the ledger is new again.
4. Read each PR's description and diff once so you know the intent before judging feedback.

## Loop

Repeat until everything is merged or closed, or the user stops you:

1. **Triage** every new item from the state script (threads, reviews, comments, failing checks).
2. **Act** on it (below).
3. **Report** in a few lines: what changed, what was pushed, drafts awaiting approval, questions.
   Put drafts and questions in one message so the user can answer them together. In stack mode,
   group by PR.
4. **Wait.** Run `scripts/wait-for-change.sh <number>` (or `scripts/wait-for-change.sh --stack`)
   in the background (`run_in_background` in Claude Code). It polls every 60s and exits when
   there is new feedback, a new head commit, a review decision or merge-state change, the check
   rollup settles, or a stack layer merges or needs a rebase; it prints `CHANGED` or `TIMEOUT`
   followed by fresh state. On `TIMEOUT`, start it again. While it runs, respond to the user
   normally; their approvals take effect immediately.

Do not poll in the foreground or sleep in a loop yourself.

## Triage

Read every item in full, whoever wrote it. Bot reviews and bot summaries (Copilot, CodeRabbit,
Radar, Sonar, security scanners, and the like) get the same scrutiny as human comments: a finding
buried in a bot's summary, a "nitpick" section, or a collapsed "additional comments" block is
still a finding. Judge the claim, not the author. Verify every claim against the code before
acting, since bots are often wrong; when a bot and a human disagree, weigh the human's context
more heavily, and ask if it matters.

Sort each item, or each separate finding inside one item, into one bucket:

- **Fix**: a real bug, a correctness or security issue, a missing test for changed behavior, a
  convention violation, a cheap improvement that is clearly better (naming, a missed edge case,
  dead code, a clearer error), or a request the author would obviously accept. Make the change.
- **Ask**: a design question, a trade-off, conflicting reviewers, scope creep, or anything you
  would be guessing about. Ask the user with your recommendation.
- **Reply only**: a question with a factual answer, or a suggestion that is wrong or already
  handled. Draft a reply that says why. For bots, drafting is optional; skip it unless the thread
  blocks merging or a human will read it.
- **Skip**: a suggestion that contradicts repo conventions, is wrong on inspection, or costs more
  than it is worth; an outdated thread already fixed by a later commit; a duplicate. Record the
  reason and list skipped items in the report so the user can overrule you.
- **Nothing to do**: only items with no actionable content at all: pure status posts (deploy
  previews, coverage numbers with no regression, "review started"), your own comments, and the PR
  author's notes to themself. Ledger as `none <reason>`.

## Act

**Code changes.** Read the code the comment points at before changing it. Keep each fix to what
was asked. Run the narrowest relevant tests, linters, and type checks locally. Group related fixes
into one commit, matching the repo's commit message style; mention the reviewer's point, not
"address feedback". Push after each batch so CI and reviewers see it. Record the sha in the ledger.

**CI failures.** Read the failing log (`gh run view <run-id> --log-failed`, or the check `link`).
If the diff caused it, fix it. If it is flaky and unrelated, rerun the failed jobs once
(`gh run rerun <run-id> --failed`). If it fails the same way twice, or it is a non-code check
(PR description lint, labels, required sign-offs), tell the user what it needs.

**Drafts.** As few words as possible. No greeting, no thanks, no praise, no restating the
comment, no hedging. Reference commits by short sha. Examples:

- `Fixed in a1b2c3d.`
- `Done.`
- `Kept as is: the caller already validates this (Foo.java, validateInput).`
- `Out of scope; filed AGNT-123.` (only if the ticket exists)

Show each draft with where it goes (PR, thread path:line, or top-level) and whether you propose
resolving the thread. After approval, post:

- thread reply: `gh api repos/<repo>/pulls/<number>/comments/<comment-id>/replies -f body=...`
  using the id of the thread's first comment
- top-level: `gh pr comment <number> --body ...`
- resolve: `gh api graphql -f query='mutation($id:ID!){resolveReviewThread(input:{threadId:$id}){thread{id}}}' -F id=<thread-id>`

## Stacks

In stack mode the rules above apply to each open PR, plus these:

- **Fix on the owning layer.** A comment on PR N may need a change in a lower layer: put each fix
  in the lowest layer whose diff introduced the code, never on top for convenience. Check out
  that layer (`gh stack checkout <branch>` or `gh stack down`), commit, `gh stack rebase
  --upstack`, `gh stack top`, then `gh stack push`. Batch fixes per layer, lowest layer first, so
  each layer rebases once.
- **CI failures** on an upper PR can come from a lower layer. Fix where the cause is, and expect
  every layer above it to rerun.
- **Conflicts.** On `gh stack rebase` or `gh stack sync` exit 3, follow the gh-stack skill's exit 3
  recovery and resolve them yourself.
- **Out of sync.** If any layer has `needsRebase`, or a lower PR merged outside this loop, run
  `gh stack sync`. If it reports `Sync aborted` (local and remote diverged), read the gh-stack
  troubleshooting reference and fix it; ask only if the remote has commits you did not make.
- **Merge bottom-up.** Find the highest PR such that it and every unmerged PR below it pass every
  condition under **Merge**. If there is one, merge that prefix with `gh stack merge <that PR>
  --yes --<method>`; it is all-or-nothing. Do not wait for the whole stack to be ready, and never
  merge a PR whose lower layers are not ready. Right before merging, re-read state and confirm
  each head still matches what you checked, since `gh stack merge` has no head pin.
- **After a merge**, run `gh stack sync --prune` to retarget and rebase the remaining layers onto
  trunk, wait for their CI again, and keep going until the top PR merges.

## Merge

Merge a PR only when all of these hold on a fresh state read:

- Every item in its ledger is `fixed`, `posted`, `skipped`, or `none`; nothing is `asked` or
  `drafted` without an answer. No unresolved human thread is left without a fix or reply.
- No unpushed local commits; `pr.headRefOid` equals the local branch head.
- `checks.rollup` is `pass` (`none` is not enough unless the repo has no CI).
- `pr.reviewDecision` is `APPROVED`, or it is null and `approvedBy` is non-empty. A
  `CHANGES_REQUESTED` review still standing blocks the merge, even if someone else approved.
- `pr.mergeStateStatus` is `CLEAN`, and `pr.isDraft` is false.

If `mergeStateStatus` is `BEHIND` or `DIRTY`, fetch, rebase onto `origin/<baseRefName>` (in stack
mode, `gh stack sync`), resolve any conflicts, rerun the relevant local checks, and force-push with
lease. Then wait for CI again. A rebase can dismiss stale approvals; if it does, the merge waits
for re-approval. If it is `BLOCKED` with everything else green, find out why (missing required
review, code owner, etc.) and tell the user.

Use the merge method the repo allows (`gh repo view --json
squashMergeAllowed,mergeCommitAllowed,rebaseMergeAllowed`); if more than one is allowed, follow
what recent merged PRs used, or ask. For a single PR, pin the head so nothing slips in between the
check and the merge:

```
gh pr merge <number> --<method> --match-head-commit <pr.headRefOid> --delete-branch
```

Stacks merge as described under **Stacks**. When the last PR is merged, report each merged PR's
URL, delete the ledger files, and stop.
