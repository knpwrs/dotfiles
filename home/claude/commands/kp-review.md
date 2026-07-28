Review type: $ARGUMENTS (options: "all", "committed", "uncommitted"; default: "all")

Based on the review type, determine which changes to review:
- **all**: All changes on this branch compared to main (`git diff main...HEAD` + any uncommitted changes)
- **committed**: Only committed changes on this branch compared to main (`git diff main...HEAD`)
- **uncommitted**: Only uncommitted changes (`git diff` for unstaged + `git diff --cached` for staged)

This is an **adversarial review**. You are not confirming the change works — you are trying to prove it doesn't. Assume there is at least one real defect and that it is your job to find it. Then assume each defect you found is wrong, and try to kill it.

## Rules of Engagement

- **Read past the diff.** A diff hunk is never enough context to judge correctness. Open the changed file, read the callers, read the tests, read the types. A finding you can't ground in code you actually read is a guess — discard it.
- **Every finding needs a concrete failure scenario**: specific inputs or state → specific wrong output, crash, or corrupted state. If you cannot write the scenario, you do not have a finding.
- **Attack the code, not the author.** No commentary on effort, intent, or taste.
- **Precision beats volume.** Five confirmed defects are worth more than thirty maybes. A report padded with "consider" and "you may want to" is a failed review.
- **Style is not a defect.** Formatting and naming preferences belong in nits, and only if they impede comprehension.

## Phase 1 — Establish Intent

Before hunting, state what the change is *supposed* to do, inferred from the diff, commit messages, tests, and surrounding code. Note any place where the stated intent and the implementation appear to diverge — those are your first attack targets.

## Phase 2 — Attack

Work file by file. For each changed file, apply every lens below and actively try to construct an input, sequence, or environment that breaks it.

Concrete attack moves to attempt on every change:
- **Boundaries**: empty, single-element, huge; zero, negative, `NaN`, `Infinity`; `null`, `undefined`, missing key vs. present-but-falsy.
- **Interleaving**: call it twice concurrently; unmount mid-flight; resolve promises out of order; fire the event before init and after teardown.
- **Hostile input**: caller passes the wrong type, an attacker controls the string, the API returns a shape the code doesn't expect, the network fails halfway.
- **The unchanged callers**: every existing call site of a modified signature or behavior is a regression candidate. Enumerate them and check each.
- **The path not taken**: the `else` branch, the `catch`, the early return, the error state — these are where defects hide, because they're where tests don't go.

### Lenses

#### Correctness
- Logic errors, off-by-one, null/undefined access
- Race conditions, stale closures, async ordering issues
- Broken edge cases (empty arrays, missing keys, boundary values)
- State management bugs (stale state, missing updates, incorrect derivations)
- Regressions — do these changes break existing behavior at any existing call site?

#### Security
- Injection (XSS, SQL, command), improper sanitization
- Auth/authz gaps, privilege escalation
- Sensitive data exposure (logs, error messages, network)
- Insecure defaults, missing CSRF/CORS protections

#### Performance
- Unnecessary re-renders, missing memoization
- Expensive computations in hot paths or render loops
- N+1 queries, unbounded data fetching
- Bundle size impact (large imports, tree-shaking issues)
- Memory leaks (missing cleanup, unclosed subscriptions)

#### Type Safety
- Incorrect or overly loose types
- Missing type narrowing, unsafe casts
- Generic constraints that are too permissive
- Types that don't match runtime behavior

#### Error Handling
- Unhandled promise rejections, missing catch blocks
- Silent failures that should surface to the user
- Error boundaries and fallback UI coverage
- API error response handling

#### React Patterns
- Hook rules violations, incorrect dependency arrays
- Component lifecycle issues, cleanup in effects
- Prop drilling that should use context or composition
- Accessibility (missing aria attributes, keyboard nav, focus management)

#### Testing
- Are new code paths covered by tests?
- Are edge cases and error paths tested?
- Do the tests actually assert the thing, or would they pass against a broken implementation?
- Are mocks appropriate, or do they hide real issues?
- Could any existing test break silently from these changes?

#### Maintainability
- Unclear naming, magic numbers, unexplained logic
- Dead code, unused imports, redundant conditions
- Opportunities to simplify or reduce duplication
- API design (are new functions/components easy to use correctly and hard to misuse?)

## Phase 3 — Refute

Now switch sides. For each candidate finding from Phase 2, argue *against* it as hard as you argued for it. Go back to the code and look specifically for the reason it is not a bug:
- Is there a guard, early return, type constraint, or invariant upstream that makes the bad input unreachable?
- Does a caller already handle this? Does the framework already do it?
- Is the "broken" behavior actually the intended and documented behavior?
- Does a test already cover the case, meaning the code path works and I misread it?
- Am I asserting a fact about a library, API, or config I did not verify? Verify it or drop the finding.

Default to refuted when uncertain. Label survivors:
- **CONFIRMED** — I traced the code path and the failure scenario holds.
- **PLAUSIBLE** — the scenario depends on an assumption I could not verify; state the assumption explicitly.

Everything else is deleted, not downgraded. Report the count of candidates you dropped in refutation, so the reader knows the pass happened.

## Report

### Summary
What the change does, its risk level, and any architectural concern that outranks the individual findings.

### Findings
Most severe first. Each finding:
- **Location**: `file:line`
- **Claim**: one sentence stating the defect
- **Failure scenario**: the inputs/state → the wrong result
- **Verdict**: CONFIRMED or PLAUSIBLE (+ unverified assumption, if PLAUSIBLE)
- **Fix**: the smallest change that resolves it

### Verdict
- **must-fix** (blocking)
- **should-fix** (non-blocking but recommended)
- **nits** (style, preference)
- Candidates dropped during refutation: N
- Overall: approve / approve with suggestions / request changes

If the change survives the attack, say so plainly and approve it. A clean review is a real outcome — do not manufacture findings to look thorough.
