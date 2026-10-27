---
name: work-ticket
description: >
  Take a ticket from description to draft pull request: read the ticket and its context, check
  the current branch (or branch off the latest base), implement the change with tests, review it
  and fix what is worth fixing in a loop (review-loop: /code-review, plus /security-review when
  sensitive), then push and open a draft PR. Use when asked to work on, pick up, implement, or
  "do" a ticket or issue from any tracker (e.g. ABC-123, a GitHub issue, or a ticket URL). For a
  parent ticket whose children should each become a PR in a stack, use work-stack. For work
  described in prose with no ticket, use work-feature.
argument-hint: "[ticket id or URL] [extra instructions]"
---

# Work a ticket

Take the ticket in `$ARGUMENTS` to a draft PR. Anything after the ticket reference is extra
instruction from the user and overrides the ticket where they conflict.

If `$ARGUMENTS` has no ticket reference, infer it from the current branch name: a tracker key
anywhere in it, matched case-insensitively (`kp/abc-123-add-search` is `ABC-123`), else a
GitHub issue number (`123-add-search`, `issue-123`, `gh-123`). If the branch has a PR, its
title and body can confirm the ticket. Say which ticket you inferred. If you are on the base
branch, or the name holds no reference or more than one, ask for the ticket.

## Permissions

Allowed without asking: creating a branch, editing code, running builds and tests, committing,
pushing the working branch, and opening the PR **as a draft**.

Ask first: changing the ticket (status, assignee, comments), marking the PR ready, requesting
reviewers, force-pushing a branch you did not create, and anything outside the ticket's scope.

Asking the user is always acceptable. Batch questions into one message, each with your
recommended answer, and ask them as early as possible: before writing code, not after.

## 1. Read the ticket

Work out which tracker the reference belongs to from its shape (a key like `ABC-123`, a URL, an
issue number), then use whatever tools are available to read it: an MCP connector for that
tracker, its CLI (`gh issue view <ref> --comments` for GitHub), or a URL fetch. If no available
tool can read it, ask the user to paste the ticket. If the reference is plain prose, treat it as
the description of the work.

Read the ticket's comments, parent, linked issues, and attached documents that bear on the work,
and note any suggested branch name. Follow links it gives (chat threads, docs, related PRs) when a
tool can read them. Write down, privately, what done looks like: the acceptance criteria, explicit
or inferred.

If the ticket is ambiguous, contradicts itself or the code, or you cannot tell which repo it
belongs to, ask now.

## 2. Check the branch

Usually the user is already on a branch for this ticket. Start by reading where things stand:

1. Find the repo. Usually it is the current one; otherwise the ticket names it.
2. Find the base: `git symbolic-ref refs/remotes/origin/HEAD` (fall back to `main`, then
   `master`), and `git fetch origin`.
3. Read the current state: the branch name, `git status`, `git log origin/<base>..HEAD`, whether
   the branch is behind its base, whether it is part of a stack (`gh stack view --json`), and
   whether it already has a PR (`gh pr view`).

Then:

- **On a feature branch** (anything but the base): work there. Existing commits and uncommitted
  changes are earlier work on this ticket; read them, build on them, and never discard them. If
  they look unrelated to the ticket, or the branch name points at a different ticket, ask before
  going further. Do not rebase onto the base unless conflicts or a needed upstream change require
  it.
- **In a stack**: work on the current layer, following the gh-stack skill's rules for which layer
  owns each change.
- **On the base branch**: if there are uncommitted changes, ask before touching them. Otherwise
  branch from `origin/<base>`, named with the tracker's suggested branch name when there is one,
  or after the repo's recent branch names. If that branch already exists, inspect it and ask
  whether to continue on it.

If the work splits into dependent parts that would each deserve their own review, propose a stack
(gh-stack skill) with the layers, and ask before creating it.

## 3. Do the work

1. Read the repo's agent instructions (`CLAUDE.md`, `AGENTS.md`, contributing docs) and the code
   the ticket touches, its callers, and its tests, before changing anything.
2. For non-trivial work, write a short plan. If the plan makes a design choice the ticket does
   not settle, ask about that choice; otherwise go ahead.
3. Implement the smallest change that meets every acceptance criterion. Match the surrounding
   code. Do not refactor or fix unrelated things; note them for the PR body instead.
4. Add or update tests for each new behavior and each bug fixed. Write the failing test first when
   the ticket is a bug.
5. Run the repo's own checks for what you touched: build, type check, lint, format, and the
   relevant tests. Fix every failure your change caused. Report failures that exist on the base
   branch too, without fixing them.
6. Commit in the repo's commit message style, including the ticket id if recent commits do.
   Several focused commits are fine.

## 4. Review and fix

Write the ticket's acceptance criteria to a file in the scratchpad, then invoke the
review-loop skill (Skill tool: `review-loop`, args
`--from origin/<base> --to HEAD -B <criteria file> --commit-rounds`). It reviews the branch with
`/code-review` (plus `/security-review` when the change is security-sensitive), fixes what is
worth fixing, reruns the checks from step 3.5, commits each round, and stops when a round has
nothing new worth fixing, at most five rounds.
Answer or pass on the questions it collects, and carry its fixed, skipped, and open findings
into the report.

## 5. Open the draft PR

If the branch already has a PR, push to it and do not open another; leave its draft state alone,
and if its title or body no longer describes the change, draft the update and ask before applying
it. Otherwise:

1. Push the branch: `git push -u origin <branch>`.
2. Title: follow recent merged PRs in the repo (for example `ABC-123: Short imperative summary`).
3. Body: if the repo has a PR template (`.github/pull_request_template.md`,
   `.github/PULL_REQUEST_TEMPLATE/`, or `docs/pull_request_template.md`), fill in every section;
   CI may lint it. Otherwise write: what changed and why, how it was tested, and anything a
   reviewer should look at closely. Link the ticket the way recent PRs in the repo do (a tracker
   URL, a ticket key, or `Fixes #<n>`). Keep it short and specific; no filler.
4. `gh pr create --draft --base <base> --title ... --body-file <file>`. In a stack, use
   `gh stack submit --auto` instead (it opens drafts).

## 6. Report

In a few lines: the PR URL, what was done, how it was tested, review findings fixed and skipped
(with reasons), anything left open, and any questions.

End with one offer: mark the PR ready for review, draft messages to its reviewers
(`/notify-reviewers`), and hand it to `/babysit-pr`. The user may accept all of it or part, and
may name reviewers. For what they accept, in order: run `gh pr ready <number>` (in a stack, for
every PR in the stack); invoke the notify-reviewers skill with the PR (or `stack`) and any
reviewers they named; then invoke the babysit-pr skill. If any questions are still open, say they
should be answered first.

Auto-assignment requests reviewers a little after `gh pr ready`, so a check right after it shows
none. When reporting who will review, read them with the notify-reviewers skill's
`scripts/reviewers.sh --wait 60 <pr>...`, never a bare `gh pr view`.
