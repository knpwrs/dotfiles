---
name: work-feature
description: >
  Take a feature or fix described in prose to a draft pull request, for projects without an issue
  tracker: pin down what done looks like, check the current branch (or branch off the latest
  base), implement the change with tests, review it and fix what is worth fixing in a loop
  (review-loop: /code-review, plus /security-review when sensitive), then push and open a
  draft PR. Use when asked to build, add, implement, or fix something with no ticket to read.
  For work that has a ticket, use work-ticket.
argument-hint: "<description of the feature or fix>"
---

# Work a feature

Take the feature or fix described in `$ARGUMENTS` to a draft PR. There is no ticket: the
description, and the user's answers to your questions, are the whole spec.

This skill builds on work-ticket. Read `../work-ticket/SKILL.md` (next to this skill's
directory) before starting: steps 2 to 6 apply here as written, with the changes below, and so
do its permissions.

## 1. Pin down the work

1. If `$ARGUMENTS` is empty, ask what to build.
2. Read the repo's agent instructions and the code the description points at, enough to know
   what the change touches.
3. Write down what done looks like: the acceptance criteria, each one specific enough to test.
   Fill gaps from the code and the repo's conventions, not from guesses about intent.
4. If the description leaves the behavior, the scope, or the place in the code open, ask now,
   in one message with your recommended answer for each question. Otherwise go ahead; for
   anything larger than a small change, state the criteria in one line each as you start, so
   the user can correct them early.

## 2. Do the work

Follow work-ticket steps 2 to 6, with the acceptance criteria from step 1 in place of the
ticket's. Where those steps mention a ticket:

- **Branch name**: follow the repo's recent branch names, with a short slug of the feature
  (for example `add-csv-export`).
- **Commits and PR title**: follow the repo's style, without a ticket id.
- **PR body**: state the problem or goal in a sentence or two where a ticket link would go, so
  the PR stands on its own.
- **Review background**: pass the acceptance criteria, as work-ticket does with the ticket's.
- **Report**: there is no ticket to update; leave out anything about one.
