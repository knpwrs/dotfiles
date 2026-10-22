---
name: test-plan-minimal
description: >
  Write the smallest hands-on walkthrough that exercises every behavior a change introduces at
  least once: one shared setup, then numbered steps a person runs in the real app, each with the
  observable result to check. Use when asked for a minimal, manual, release-verification, QA, or
  "how do I completely test this" plan for a branch, PR, set of uncommitted changes, or described
  feature. Produces a plan, not tests. For a list of cases to automate, use test-plan.
argument-hint: "[all|committed|uncommitted|<PR number>|<branch>|<path>|<feature description>]"
---

# Minimal test plan

Produce the shortest script a person can run in the real app, in one sitting, that touches every
behavior the change adds or alters. Concision comes from making each step cover as many changed
branches as it can, never from skipping a branch. The plan is the deliverable. Do not run it or
write tests unless the user asks.

Scope comes from `$ARGUMENTS`:

- empty or `all`: committed changes on this branch against the base branch, plus uncommitted changes
- `committed`: `git diff <base>...HEAD` only
- `uncommitted`: `git diff` plus `git diff --cached`
- a PR number or URL: `gh pr view <n>` and `gh pr diff <n>`. If it is merged, read the code at
  its merge commit or on the base branch.
- a branch name: `git diff <base>...<branch>`
- a path: changes under that path, or the code there if it is unchanged
- anything else: treat it as a description of the feature and find the code that implements it

Find the base branch with `git symbolic-ref refs/remotes/origin/HEAD` (fall back to `main`, then
`master`). If the scope turns up nothing, say so and ask what to plan for.

## Research

1. **Read the diff, its callers, and the tests it adds.** Collect intent from the PR body, commit
   messages, linked tickets, and what the user said. The PR's own "steps to verify" are a starting
   point, not the plan.
2. **List every changed branch privately**: each new condition, message, disabled state, persisted
   field, import/export path, layout fix, and each unchanged caller of modified code. This list is
   what the steps must cover. It does not go in the plan.
3. **Trace the paths a person can't see from the diff.** Follow serializers, parsers, converters,
   and load/save round trips far enough to state what actually comes back, not what a comment
   claims.
4. **Find states the UI can't produce**: data written by older clients, importers, or the API, and
   flags or roles. These go in the setup, with how to create them.

## Build the steps

- **One setup, shared by every step.** Name the concrete fixture: field names, types, row counts,
  flags, role. Stored data the UI can't create goes here too, with how to create it (API call,
  older export, a table from before the release).
- **Cover the branch list with as few steps as possible.** Each step is one starting state plus a
  short sequence of actions, and a step can check several results. Merge two steps whenever one
  starting state serves both. Drop a step when every branch it covers is already covered by
  another.
- **Each result is something a person can observe**: exact UI text, a control enabled or disabled,
  the tooltip reason, focus or scroll position, a network payload. Never "works" or "behaves
  correctly".
- **Prove persistence on the wire.** For anything saved, compare the outgoing request with what was
  loaded (for example "the PUT's condition equals the GET's"), then reopen.
- **Use a table for parallel variants**: same action on different inputs, one row each with its
  expected result.
- **End with one regression step** on existing, realistic data: no new warnings, and saving it
  unchanged produces an identical payload.
- **Mark disputed intent inline.** Where the code's behavior may not be what product wants, state
  what the code does and flag the question in that step.
- Order the steps so each builds on the previous state where it can. Cheapest and most central
  first, setup-heavy steps last.

## Template

````markdown
<One sentence: what the plan covers and how long it is (N steps plus the unit run).>

**Setup:** <the fixture>. <Stored states the UI can't create, and how to create them.>

## Steps

1. **<Behavior>.** <Action.>
   - <Observable result.>
   - <Next action>: <result>.
2. **<Behavior with variants>.**

   | Input | Expected |
   | --- | --- |
   | ... | ... |

...
N. **Regression.** Open <existing realistic data>.
   - No new <errors/warnings> appear.
   - Save with no edits: the request payload equals the loaded one.

## Unit tests
`<command that runs the tests for the touched area>`

Steps <list> already have unit coverage. The manual-only value is in:
- **Step <n>, <what>:** <why automation can't or doesn't cover it>.
````

Omit the unit tests section when the change has no tests to run.

## Before you finish

- Every changed branch from the private list is exercised by some step.
- No step can be removed without leaving a branch uncovered, and no two steps share a starting
  state that would let them merge.
- Every stored or imported state a step needs is in the setup, with how to create it.
- Every saved change has a payload or reopen check.
- Every expected result names exact text, state, or data.
- The manual-only list names the gaps automation leaves: real network payloads, untested branches,
  layout, real data.

Print the plan in the conversation. If the user asks for a file, write it where they say.
