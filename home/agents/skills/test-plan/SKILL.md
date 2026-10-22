---
name: test-plan
description: >
  Write a short test plan for the feature currently being worked on that still covers every
  behavior and every edge case that matters, grounded in the actual diff, its callers, and the
  existing tests. Use when asked for a test plan, QA checklist, "what should I test", "what could
  break", or "what tests am I missing" for a branch, PR, set of uncommitted changes, or described
  feature. Produces a plan of cases to automate, not tests. For a short manual walkthrough that
  exercises the whole change once, use test-plan-minimal.
argument-hint: "[all|committed|uncommitted|<PR number>|<branch>|<path>|<feature description>]"
---

# Test plan

Produce a test plan someone could execute without asking questions, that would catch the defects
most likely to ship, and that fits on one screen for a typical feature. Concision comes from
merging and cutting words, never from cutting coverage. The plan is the deliverable. Do not write
or run tests unless the user asks.

Scope comes from `$ARGUMENTS`:

- empty or `all`: committed changes on this branch against the base branch, plus uncommitted changes
- `committed`: `git diff <base>...HEAD` only
- `uncommitted`: `git diff` plus `git diff --cached`
- a PR number or URL: `gh pr view <n>` and `gh pr diff <n>`
- a branch name: `git diff <base>...<branch>`
- a path: changes under that path, or the code there if it is unchanged
- anything else: treat it as a description of the feature and find the code that implements it

Find the base branch with `git symbolic-ref refs/remotes/origin/HEAD` (fall back to `main`, then
`master`). If the scope turns up nothing, say so and ask what to plan for rather than inventing one.

## Do the full analysis, print only the cases

The research is the same as a thorough plan. Only the output is shorter.

1. **Read, don't skim.** Open the changed files, their callers, types, schemas, and existing tests.
   Collect intent from commit messages, the PR description, linked tickets, docs, and what the
   user said.
2. **Inventory privately.** List entry points, inputs (with constraints and defaults), state read
   and written, dependencies, side effects, unchanged callers of modified code, invariants, and
   existing tests. Keep this in your head or scratch notes. It does not go in the plan.
3. **Sweep for edge cases.** Run every input, state, and dependency through
   `references/edge-cases.md`. Keep a case only if the code gives it a real path to fail: a branch,
   a parse, a constraint, a lookup, a write. Drop catalog items that do not apply without comment.
4. **Derive cases** for each entry point across: happy paths and acceptance criteria, validation
   and boundaries, state and sequencing (repeat, out of order, concurrent), dependency failures,
   authorization and tenant isolation, regressions in unchanged callers, rollout (flags, existing
   data, migrations, old clients), and non-functional concerns where the change gives a reason.

## Make it short

- **Merge cases that share setup and expected result.** One line can carry an equivalence class:
  "`amount` ∈ {missing, `null`, `0`, `-0.01`, `"abc"`} → 400 naming `amount`, nothing persisted."
  Split only when the expected results differ.
- **Name boundaries as values, not prose.** "`name` at 255 / 256 chars" beats a sentence.
- **Collapse covered behavior.** Cases an existing test already proves go in one line per area:
  "Covered: `transfer.test.ts` (create, list, 404)." Do not restate them as cases.
- **No inventory, no restated diff, no generic advice.** No "consider performance", no "ensure
  error handling". If it is worth testing, it is a specific case; otherwise it is gone.
- **One line per case.** Input or state → observable result. Use arrows and code spans, not
  sentences. Add a short note after an em dash only when the reason a case exists is not obvious.
- **Expected results come from intent, not from what the code does.** Where they disagree or
  intent is unclear, write an open question instead of guessing.
- **Pick the cheapest level that proves it** (unit, integration, e2e, manual) and tag it. Mark
  manual only when automation is unreasonable, and give the reason in a few words.

Priority:

- **P0**: data loss or corruption, security or isolation breach, money or compliance impact, a
  broken core flow, an acceptance criterion
- **P1**: likely real-world inputs and failures, regressions in nearby behavior
- **P2**: rare or low-impact

## Template

````markdown
# Test plan: <feature>

<One sentence: what changed and why. Scope: branch/PR, N files.>

## <Area, e.g. "POST /transfers">
- [ ] **P0** `unit` `amount` ∈ {missing, `null`, `0`, `-0.01`, `"abc"`} → 400 naming `amount`, no row
- [ ] **P0** `int` Same `idempotency_key` twice within 1s → one transfer, both calls return it *(partial: `transfer.test.ts` single call only)*
- [ ] **P1** `int` Ledger service times out → 503, transfer stays `pending`, no ledger entry — retry path in `transferJob.ts`
- Covered: `transfer.test.ts` (happy create, list, 404 on unknown id)

## <Next area>
...

## Regressions
- [ ] **P1** `int` `reports/daily.ts` still totals legacy transfers with `currency: null`

## Open questions
- Should `amount` of exactly `0` be allowed? Code accepts it; ticket says "positive". Affects the first `amount` case.

**Run:** `pnpm test transfer`
````

Every case is missing a test unless marked *(partial: …)*. Omit the regressions section, open
questions, or the run line when empty. Order cases within an area by priority.

Print the plan in the conversation. If the user asks for a file, write it to `TEST_PLAN.md` at the
repo root (or the path they give) and say where it went.

## Before you finish

Check against your private inventory, and fix the plan rather than reporting the shortfall:

- Every acceptance criterion, entry point, and input appears in some case or a Covered line.
- Every entry point has at least one failure case.
- Every dependency has a failure case, and every invariant has a case that tries to break it.
- Every unchanged caller at risk has a regression case, or is safe for a reason you checked.
- No two lines could be merged without changing an expected result.
- No line says "works", "handles correctly", or "as expected". Each names the observable result.
- Coverage notes cite real test names you found.
