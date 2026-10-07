# Edge-case catalog

Work through each section that applies to an input, state, or dependency in the feature. Each line
is a prompt for a case, not a case itself: turn it into a specific input and an observable expected
result, or skip it.

## Presence and type

- Missing key vs. key present with `null` vs. present with an empty value
- `undefined` vs. `null` vs. `0` vs. `false` vs. `""` where code uses truthiness checks
- Wrong type: string for number, number for string, object for array, array of one for scalar
- Extra, unknown fields (dropped, rejected, or silently persisted?)
- Duplicate keys, or the same field set by two sources (query and body, header and config)
- Default applied when absent; default not applied when explicitly set to its zero value

## Strings

- Empty, whitespace only, leading or trailing whitespace
- Exactly at the max length, one over, far over
- Unicode: accents, CJK, RTL text, emoji, combining characters, zero-width characters
- Length counted in bytes vs. code units vs. characters (emoji and surrogate pairs)
- Case sensitivity in comparisons, lookups, and uniqueness constraints
- Newlines, tabs, control characters, NUL bytes
- Characters that mean something downstream: quotes, `<>&`, `%`, `\`, `/`, `..`, `${}`, SQL
  wildcards, regex metacharacters, CSV formula prefixes (`=`, `+`, `-`, `@`)
- Values that look like other types: `"null"`, `"true"`, `"0"`, `"1e3"`, `"NaN"`

## Numbers

- `0`, `-0`, `1`, `-1`
- Minimum, maximum, one past each
- Integer overflow, values past `Number.MAX_SAFE_INTEGER`, 32-bit vs. 64-bit limits
- Floating point: `0.1 + 0.2`, rounding mode, currency precision, representations of large decimals
- `NaN`, `Infinity`, `-Infinity`
- Numeric strings, leading zeros, exponent notation, locale separators (`1,000.5` vs. `1.000,5`)
- Division by zero, percentages over 100 or under 0

## Collections

- Empty, one element, two elements (the first case where order matters), many
- At the page size, one over, an exact multiple of the page size
- Very large (performance, memory, payload limits, query parameter limits)
- Duplicates, including duplicates that differ only by case or whitespace
- Unsorted input where sorted is assumed; stable vs. unstable sort with ties
- `null` or malformed elements inside an otherwise valid list
- Nested structures at depth, and cycles

## Dates and time

- Time zones: UTC, positive and negative offsets, half-hour offsets, the user's zone vs. the server's
- DST transitions: the skipped hour and the repeated hour
- Midnight, end of day, end of month, end of year, Feb 29, leap seconds where relevant
- Inclusive vs. exclusive range ends, ranges where start equals end, start after end
- Timestamps in the past, far past, future, far future, epoch zero
- Formats: ISO 8601 with and without offset, date-only, epoch seconds vs. milliseconds
- Clock skew between services; the clock moving during a long operation
- Expiry exactly at the boundary (token, cache entry, trial, lock)

## Identity, auth, and isolation

- Unauthenticated, expired session, revoked token, malformed token
- Authenticated but lacking the permission; permission granted or revoked mid-session
- Each role, including the least privileged role that should succeed
- Accessing another user's or tenant's resource by ID (IDOR), including through list filters,
  search, exports, and nested resources
- Deleted, suspended, or not-yet-activated users and tenants
- Impersonation or admin-on-behalf-of flows, and what the audit log records

## Security

- Injection into SQL, NoSQL, shell, LDAP, templates, and log lines
- XSS in every place user content is rendered, including emails, PDFs, and admin views
- Path traversal and unexpected file types or sizes on upload
- SSRF through any user-supplied URL
- Mass assignment of fields the user should not control (`role`, `tenant_id`, `price`)
- Secrets or PII in logs, errors, URLs, analytics, or client bundles
- Rate limiting and abuse: rapid repeats, enumeration via different error messages

## State and lifecycle

- Each state the entity can be in, and each transition, including ones that should be refused
- Operating on something deleted, archived, locked, or in the middle of another operation
- First use (no prior data), and use with years of accumulated data
- Records created before this change (old shape, missing new fields, values the new code rejects)
- Cleanup: what happens to child records, files, caches, and scheduled jobs on delete or cancel

## Concurrency and ordering

- The same action twice at once (double click, double submit, two tabs, two workers)
- Two different actions on the same record at once (lost update, write skew)
- Events or messages delivered out of order, duplicated, or delayed
- A read immediately after a write (replication lag, cache staleness, eventual consistency)
- Retries: is the operation idempotent, and does a retry after a timeout double-apply?
- Locks: acquired and never released after a crash; contention under load

## Dependency failures

For each external call (database, cache, queue, HTTP API, file system, third-party SDK):

- Timeout, connection refused, DNS failure
- Error status: 4xx, 5xx, 429 with and without `Retry-After`
- Success status with an unexpected, empty, or malformed body
- Partial success: the first of several writes succeeds, the rest fail. What is left behind?
- Slow responses that succeed (does a caller time out first and retry?)
- The dependency being down at startup vs. going down mid-request
- Fallbacks and circuit breakers actually taking effect

## Configuration, flags, and rollout

- Feature flag off, on, and changed while a request or job is in flight
- Flag on for some tenants or users and off for others, with data crossing between them
- Missing or invalid config values; config differing between environments
- Mixed versions during a rolling deploy: new code reading old data, old code reading new data
- Migration applied, not yet applied, rolled back; migration on a large table
- API versioning: old clients sending the old shape, new clients talking to old servers
- Removing the flag later: is there a path that only works with it on?

## Performance and scale

- Realistic production volume, and ten times that
- N+1 queries as collection size grows
- Payload and response size limits, pagination under load
- Memory growth on long-running processes, listeners or timers never cleaned up
- Cold start and cold cache

## UI

- Loading, empty, error, partial, and success states, and the transitions between them
- Slow network (spinners, double submission while pending), offline, request cancelled
- Very long content, very short content, missing images, content with no spaces
- Narrow and wide viewports, zoom, high-DPI
- Keyboard-only use, focus order and focus after actions, screen-reader labels, color contrast
- Browser back and forward, refresh mid-flow, deep links straight into a step, multiple tabs
- Form state preserved or cleared as intended after errors and navigation
- Localization: translated strings that are much longer, RTL layouts, locale date and number formats
- Optimistic updates that the server then rejects

## Observability and operations

- Errors are logged with enough context to debug, and without secrets or PII
- Metrics, traces, and audit events are emitted for the new paths
- Alerts that should fire on failure actually would
- Error messages shown to users are actionable and do not leak internals
