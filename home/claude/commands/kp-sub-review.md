Review type: $ARGUMENTS (options: "all", "committed", "uncommitted"; default: "all")

Perform an **adversarial review in independent subagents**, so the analysis is unbiased by the current conversation's context and every finding is challenged by an agent that did not produce it.

## Dispatch

1. Based on the review type, determine which changes to review:
   - **all**: All changes on this branch compared to main (`git diff main...HEAD` + any uncommitted changes)
   - **committed**: Only committed changes on this branch compared to main (`git diff main...HEAD`)
   - **uncommitted**: Only uncommitted changes (`git diff` for unstaged + `git diff --cached` for staged)

2. **Attack stage.** Launch these `general-purpose` subagents *in parallel*, in a single message. Each gets the review type, the exact git command(s) above so it gathers the diff itself, the shared Rules of Engagement, and only its own lens block:
   - `attack:correctness` — Correctness + Error Handling
   - `attack:security` — Security
   - `attack:perf-types` — Performance + Type Safety
   - `attack:patterns` — React Patterns + Testing + Maintainability

   Give every attacker this directive: review only from the diff and the repository on disk — do NOT rely on any prior conversation context. Read whatever files you need for full context. Return a list of candidate findings, each with `file:line`, a one-sentence claim, and a concrete failure scenario. Return an empty list if you find nothing; do not invent findings to fill the report.

3. **Refute stage.** Collect the candidates, drop exact duplicates (same defect at the same location), then for each surviving candidate launch one `general-purpose` skeptic subagent — again in parallel, batched in single messages. Each skeptic gets **one** finding and the Refutation Brief below. A skeptic never sees the attacker's reasoning beyond the claim and scenario, and is told its job is to **kill** the finding.

4. **Report stage.** Keep only findings the skeptic could not refute. Assemble the final report yourself in the format below. Do not soften or re-argue a skeptic's refusal, and do not resurrect a killed finding. Report how many candidates were dropped.

---

## Rules of Engagement (give verbatim to every attacker)

This is an adversarial review. You are not confirming the change works — you are trying to prove it doesn't. Assume there is at least one real defect and that finding it is your job.

- **Read past the diff.** A diff hunk is never enough context to judge correctness. Open the changed file, read the callers, read the tests, read the types. A finding you can't ground in code you actually read is a guess — discard it.
- **Every finding needs a concrete failure scenario**: specific inputs or state → specific wrong output, crash, or corrupted state. If you cannot write the scenario, you do not have a finding.
- **Attack the code, not the author.** No commentary on effort, intent, or taste.
- **Precision beats volume.** Five confirmed defects are worth more than thirty maybes. Anything phrased as "consider" or "you may want to" is not a finding.
- **Style is not a defect.** Formatting and naming preferences are nits, and only if they impede comprehension.

Before hunting, state what the change is *supposed* to do, inferred from the diff, commit messages, tests, and surrounding code. Any divergence between stated intent and implementation is your first attack target.

Attack moves to attempt on every change:
- **Boundaries**: empty, single-element, huge; zero, negative, `NaN`, `Infinity`; `null`, `undefined`, missing key vs. present-but-falsy.
- **Interleaving**: call it twice concurrently; unmount mid-flight; resolve promises out of order; fire the event before init and after teardown.
- **Hostile input**: caller passes the wrong type, an attacker controls the string, the API returns an unexpected shape, the network fails halfway.
- **The unchanged callers**: every existing call site of a modified signature or behavior is a regression candidate. Enumerate them and check each.
- **The path not taken**: the `else`, the `catch`, the early return, the error state — where defects hide, because tests don't go there.

## Lens Blocks

### Correctness
- Logic errors, off-by-one, null/undefined access
- Race conditions, stale closures, async ordering issues
- Broken edge cases (empty arrays, missing keys, boundary values)
- State management bugs (stale state, missing updates, incorrect derivations)
- Regressions — do these changes break existing behavior at any existing call site?

### Error Handling
- Unhandled promise rejections, missing catch blocks
- Silent failures that should surface to the user
- Error boundaries and fallback UI coverage
- API error response handling

### Security
- Injection (XSS, SQL, command), improper sanitization
- Auth/authz gaps, privilege escalation
- Sensitive data exposure (logs, error messages, network)
- Insecure defaults, missing CSRF/CORS protections

### Performance
- Unnecessary re-renders, missing memoization
- Expensive computations in hot paths or render loops
- N+1 queries, unbounded data fetching
- Bundle size impact (large imports, tree-shaking issues)
- Memory leaks (missing cleanup, unclosed subscriptions)

### Type Safety
- Incorrect or overly loose types
- Missing type narrowing, unsafe casts
- Generic constraints that are too permissive
- Types that don't match runtime behavior

### React Patterns
- Hook rules violations, incorrect dependency arrays
- Component lifecycle issues, cleanup in effects
- Prop drilling that should use context or composition
- Accessibility (missing aria attributes, keyboard nav, focus management)

### Testing
- Are new code paths covered by tests?
- Are edge cases and error paths tested?
- Do the tests actually assert the thing, or would they pass against a broken implementation?
- Are mocks appropriate, or do they hide real issues?
- Could any existing test break silently from these changes?

### Maintainability
- Unclear naming, magic numbers, unexplained logic
- Dead code, unused imports, redundant conditions
- Opportunities to simplify or reduce duplication
- API design (are new functions/components easy to use correctly and hard to misuse?)

---

## Refutation Brief (give verbatim to every skeptic, with one finding)

Another reviewer claims this is a defect. Your job is to **kill it**. Go to the code and look specifically for the reason it is not a bug:

- Is there a guard, early return, type constraint, or invariant upstream that makes the bad input unreachable?
- Does a caller, the framework, or the runtime already handle this?
- Is the "broken" behavior actually the intended and documented behavior?
- Does an existing test cover this case, meaning the path works and the reviewer misread it?
- Does the claim rest on an assertion about a library, API, or config that isn't verified? Verify it — if you can't, the finding dies.

Trace the actual code path; do not reason from the claim alone. **Default to refuted when uncertain.**

Return:
- `refuted`: true/false
- `reason`: why it dies, or why it survives — citing the specific code you read (`file:line`)
- `verdict` (only if surviving): CONFIRMED if you traced the path and the failure scenario holds; PLAUSIBLE if it depends on an assumption you could not verify — state that assumption
- `severity` (only if surviving): must-fix / should-fix / nit
- `fix` (only if surviving): the smallest change that resolves it

---

## Report Format

### Summary
What the change does, its risk level, and any architectural concern that outranks the individual findings.

### Findings
Most severe first. Each finding:
- **Location**: `file:line`
- **Claim**: one sentence stating the defect
- **Failure scenario**: the inputs/state → the wrong result
- **Verdict**: CONFIRMED or PLAUSIBLE (+ the unverified assumption, if PLAUSIBLE)
- **Fix**: the smallest change that resolves it

### Verdict
- **must-fix** (blocking)
- **should-fix** (non-blocking but recommended)
- **nits** (style, preference)
- Candidates dropped in refutation: N of M
- Overall: approve / approve with suggestions / request changes

If nothing survives the attack, say so plainly and approve. A clean review is a real outcome — never manufacture findings to look thorough.
