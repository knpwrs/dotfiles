---
name: test-plan
description: >
  Write a thorough, edge-case-heavy test plan for the feature currently being worked on, grounded
  in the actual diff, its callers, and the existing tests. Use when asked for a test plan, QA plan,
  testing checklist, "how should I test this", "what could break", or "what tests am I missing"
  for a branch, PR, set of uncommitted changes, or described feature. Produces a plan, not tests.
argument-hint: "[all|committed|uncommitted|<PR number>|<branch>|<path>|<feature description>]"
---

# Test plan

Produce a test plan for the feature in progress that a reviewer or QA engineer could execute
without asking questions, and that would catch the defects most likely to ship. The plan is the
deliverable. Do not write or run tests unless the user asks.

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

## Rules

- **Ground every case in code you read.** A diff hunk is not enough. Open the changed files, their
  callers, the types, the schemas, and the existing tests. A case you cannot tie to a real code path,
  input, or requirement is padding. Leave it out.
- **Be concrete.** Every case names the specific input or state, the action, and the observable
  expected result. "Test invalid input" is not a case. "POST `amount: -0.01` → 400, body names
  `amount`, no row written" is.
- **Expected results come from the spec or the code's evident intent, not from what the code
  happens to do.** When the two disagree, or the intent is unclear, record it as an open question,
  not as an expected result.
- **Go past the happy path.** Most of the plan should be boundaries, failures, and interactions.
  Work through `references/edge-cases.md` for every input, state, and dependency you identify. Skip
  categories that genuinely do not apply, and do not pad the plan with ones that don't.
- **Note what already exists.** For each case, check whether a current test covers it. Mark it
  covered (cite the test), partial, or missing. The gaps are the most useful part of the plan.
- **Prefer the cheapest level that proves the behavior.** Unit before integration before end-to-end
  before manual. Use manual only for what cannot reasonably be automated, and say why.

## Process

### 1. Establish intent

Collect what the feature is supposed to do: commit messages, the PR description, a linked ticket
if one is referenced and a tool to read it is available, docs or specs touched in the diff, the
names and comments in the code, and what the user said. Write a short statement of intent and list
the acceptance criteria, explicit or inferred. Mark inferred ones as inferred.

### 2. Map the surface

Build an inventory before writing any cases:

- **Entry points**: endpoints, CLI commands, UI routes and controls, jobs, event handlers, public
  functions. Note which are new and which are existing ones whose behavior changed.
- **Inputs**: every parameter, field, header, env var, config value, and feature flag, with its
  type, constraints, and default.
- **State**: what is read and written (DB tables, caches, files, local storage, in-memory), and the
  states the entity can be in.
- **Dependencies**: services, APIs, queues, clocks, randomness, the file system. Each is a source
  of failure cases.
- **Outputs and side effects**: responses, rendered UI, emitted events, writes, notifications,
  logs, metrics.
- **Unchanged callers**: every existing call site of a modified function, type, schema, or
  endpoint. Each one is a regression candidate.
- **Invariants**: what must always hold (balances never negative, one active record per user,
  audit row for every write). Each one becomes at least one case that tries to break it.
- **Existing tests**: the framework, where tests live, fixtures and factories, how to run them.

### 3. Derive cases

For each entry point, cover in order:

1. **Happy paths**: each acceptance criterion, plus each meaningfully different valid input class.
2. **Validation and boundaries**: every input against the relevant parts of the edge-case catalog.
3. **State and sequencing**: each starting state the entity can be in, repeated calls, out-of-order
   calls, and concurrent calls.
4. **Dependency failures**: each dependency timing out, erroring, returning malformed data, or
   succeeding only partly. State what the system must do and what it must not leave behind.
5. **Authorization and isolation**: who may do this, who may not, and whether one tenant or user
   can see or affect another's data.
6. **Regression**: each unchanged caller and each existing behavior near the change.
7. **Compatibility and rollout**: existing data, old clients, mixed versions during deploy, the
   flag off and on and flipped mid-flight, migration forward and back.
8. **Non-functional**: performance at realistic and extreme sizes, security, accessibility,
   observability, where the change gives a reason to care.

Combine inputs deliberately. Use pairwise combinations when a full matrix would explode, and call
out the specific combinations that interact in the code (two flags read in the same branch, a field
that is only validated when another is set).

### 4. Prioritize

Rate each case:

- **P0**: data loss or corruption, security or isolation breach, money or compliance impact, a
  core flow broken, or an acceptance criterion. Must pass before merge.
- **P1**: likely real-world inputs and failures, regressions in nearby behavior.
- **P2**: rare or low-impact cases, polish.

Rank by likelihood times impact, not by how easy the case is to write.

### 5. Write the plan

Use the template below. Keep IDs stable (`TP-01`, `TP-02`, ...) so the user can refer to cases. Group
cases by area. Put the gaps and open questions where they are easy to find, because those are what
the user acts on.

Print the plan in the conversation. If the user asks for a file, write it to `TEST_PLAN.md` at the
repo root (or the path they give) and say where it went.

## Template

````markdown
# Test plan: <feature name>

**Scope:** <branch / PR / paths>, <N files changed>
**Intent:** <two or three sentences on what the feature does and why>

## Acceptance criteria
- AC1: <criterion> (*inferred* if not stated anywhere)

## Surface
- **Entry points:** ...
- **Inputs:** ...
- **State touched:** ...
- **Dependencies:** ...
- **Unchanged callers at risk:** `path/to/file.ts` (`functionName`), ...
- **Invariants:** ...

## Test cases

### <Area, e.g. "Create transfer endpoint">

| ID | P | Level | Case | Setup / input | Expected | Coverage |
|----|---|-------|------|---------------|----------|----------|
| TP-01 | P0 | unit | Rejects negative amount | `amount: -0.01` | 400, error names `amount`, nothing persisted | missing |
| TP-02 | P1 | integration | Duplicate submit is idempotent | Same `idempotency_key` sent twice within 1s | One transfer, second call returns the first result | partial: `transfer.test.ts` "creates transfer" covers a single call only |

### <Next area>
...

## Manual checks
Only what cannot reasonably be automated, each with steps and the reason it is manual.

## Coverage gaps
The missing and partial P0 and P1 cases, in priority order, with where each test should go
(file, describe block, fixture to reuse).

## Open questions
Places where intended behavior is unclear or where the code and the stated intent disagree. Each
one names the case IDs that depend on the answer.

## Running
The commands to run the relevant existing suites, and any setup they need.
````

## Before you finish

Check the plan against these, and fix it rather than reporting the shortfall:

- Every acceptance criterion has at least one case.
- Every entry point has at least one failure case, not only happy paths.
- Every unchanged caller at risk has a regression case or a stated reason it is safe.
- Every dependency has a failure case.
- Every invariant has a case that tries to violate it.
- No case says "should work", "handles correctly", or "behaves as expected". Each names the
  observable result.
- Coverage marks cite real test names you found, not guesses.
