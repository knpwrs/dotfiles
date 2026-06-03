Review type: $ARGUMENTS (options: "all", "committed", "uncommitted"; default: "all")

Perform this review in an **independent subagent** so the analysis is unbiased by the current conversation's context.

## Dispatch

1. Based on the review type, determine which changes to review:
   - **all**: All changes on this branch compared to main (`git diff main...HEAD` + any uncommitted changes)
   - **committed**: Only committed changes on this branch compared to main (`git diff main...HEAD`)
   - **uncommitted**: Only uncommitted changes (`git diff` for unstaged + `git diff --cached` for staged)

2. Launch a single subagent via the Agent tool (`general-purpose` type) to perform the review. Pass it:
   - The selected review type and the exact git command(s) above so it gathers the diff itself.
   - The full review instructions below (everything under "Review Instructions").
   - An explicit directive: review only from the diff and the repository on disk — do NOT rely on any prior conversation context. Read whatever files it needs for full context.

3. Relay the subagent's complete review back to the user verbatim. Do not summarize or editorialize — the point is an independent assessment.

---

## Review Instructions (for the subagent)

Perform a thorough, file-by-file analysis of the selected changes.

### Summary
Start with a high-level summary of what these changes do, their risk level, and any architectural concerns.

### File-by-File Review
For each changed file, provide:
- **Purpose**: What this file's changes accomplish
- **Findings**: Any issues, organized by severity (critical → minor)

### Analysis Categories
Apply ALL of the following lenses to every change:

#### Correctness
- Logic errors, off-by-one, null/undefined access
- Race conditions, stale closures, async ordering issues
- Broken edge cases (empty arrays, missing keys, boundary values)
- State management bugs (stale state, missing updates, incorrect derivations)
- Regressions — do these changes break existing behavior?

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
- Are mocks appropriate, or do they hide real issues?
- Could any existing test break silently from these changes?

#### Maintainability
- Unclear naming, magic numbers, unexplained logic
- Dead code, unused imports, redundant conditions
- Opportunities to simplify or reduce duplication
- API design (are new functions/components easy to use correctly and hard to misuse?)

### Verdict
End with:
- A list of **must-fix** items (blocking)
- A list of **should-fix** items (non-blocking but recommended)
- A list of **nits** (style, preference)
- An overall assessment: approve, approve with suggestions, or request changes
