---
name: review-loop
description: >
  Review a change and fix what is worth fixing, in a loop: a fresh subagent reviews with
  /code-review (plus /security-review when the change is security-sensitive) and only reports,
  you judge each finding, fix, and run the checks, then review again until a round has nothing
  new worth fixing, at most five rounds. Use when asked to review and fix in a loop, "review
  until clean", or to run /code-review repeatedly on some changes. work-ticket, work-stack, and
  work-feature use it for their review step.
argument-hint: "[max rounds] [paths, --commit <sha>, or --from <ref> --to <ref>] [-B <background file>] [--commit-rounds]"
---

# Review and fix in a loop

Review the change named in `$ARGUMENTS`, fix what is worth fixing, and review again, until a
round has nothing new worth fixing or the round cap is hit. Each review is done by a fresh
subagent that only reports; you judge and fix.

`/code-review` always returns findings, even on clean code, and each review comments on the
previous round's fixes. A loop that waits for an empty review never ends. So the loop ends on
your judgment ("nothing new here is worth fixing"), not on an empty review, and later rounds
hold the loop's own code to a higher bar.

## Inputs

- **Max rounds:** a leading number in the arguments, else 5.
- **Scope:** paths, `--commit <sha>`, or `--from <ref> --to <ref>`. With none, the workspace
  (staged, unstaged, and untracked). If the working tree holds unrelated work, narrow the scope
  to the files that belong to the change and say which you excluded.
- **Background:** the file given with `-B` (usually acceptance criteria). Without one, write a
  sentence or two on what the change does to a file in the scratchpad and use that.
- **`--commit-rounds`:** commit each round's fixes in the repo's commit style. Without it, do
  not stage or commit.

## Permissions

Allowed without asking: editing files in scope, running the project's checks, and spawning the
review subagent. Ask first: changes outside the scope, and anything that changes the design or
scope of the change.

## 1. Before the first round

- **Target.** Turn the scope into `/code-review` args: `<from>...<to>` for a range,
  `<sha>^...<sha>` for a commit, the paths for paths, nothing for the workspace.
- **Security-sensitive?** Decide from the diff whether the change touches authentication or
  authorization, sessions, tokens, secrets, or crypto; handles untrusted input (request
  parsing, uploads, file paths, deserialization); builds SQL, shell commands, HTML, or URLs from
  data; changes permission checks, network-facing endpoints, CORS, or infra and access config;
  handles personal data; or adds or upgrades dependencies. If so, round 1 also runs
  `/security-review`. Later rounds run it only if the previous round's fixes touched sensitive
  code.
- **Ledger.** Keep a list of every finding judged so far: location, a one-line gist, the
  verdict (Fixed, Skipped with reason, Asked), and the round. It is how you recognize repeats.

## 2. Each round

1. **Review.** Spawn one `general-purpose` subagent with the brief below; a new one each round,
   so it reads the code fresh. Wait for its result, and do not review the same diff yourself
   meanwhile.
2. **Judge** each finding against the code, reading whatever it needs. First check it against
   the ledger: a finding that matches one already there (same location or same underlying
   issue, even reworded or moved a few lines) is a **Repeat**. Do not reopen it, unless it was
   Fixed and the fix demonstrably did not work. Judge the rest:
   - **Fix:** correctness bugs, real vulnerabilities, missed edge cases, and missing tests. In
     round 1 also cheap, clear improvements.
   - **Skip:** false positives; cleanup, simplification, efficiency, and altitude suggestions
     after round 1; and suggestions that are out of scope or contradict repo conventions. Keep
     the reason.
   - **Ask:** anything that changes the design or scope. Collect these and ask once, at the end
     of the loop, unless an answer blocks the remaining work.

   From round 2 on, a finding about code you changed in an earlier round of this loop is Fix
   only if it is a correctness bug or a real vulnerability. Skip the rest as "loop-written, not
   worth another round".
3. **Stop** if nothing is new and judged Fix: every finding was a Repeat, a Skip, or an Ask.
   Five findings that are all repeats or not worth fixing is a clean round, not a reason to go
   again.
4. **Fix** each Fix finding in the style of the surrounding code. Then run the project's own
   checks for the touched files (lint, format, type check, and tests; follow `CLAUDE.md` for
   how), and fix any failure your fixes caused. When a fix changes runtime behavior and the app
   can be run, check it in the app.
5. **Commit** the round's fixes if `--commit-rounds` was given.
6. Start the next round over the same scope (the fixes are now part of the diff, so they get
   reviewed too). After the last allowed round, stop even if findings remain, and list them.

## Subagent brief

Fill in the target args, the background file, and whether to run the security review.

> Review this change and report findings only: do not edit files, commit, or post anything.
> The change is described in `<background file>`; read it first.
>
> 1. Invoke the `code-review` skill with args `high --max-findings default <target args>`.
>    Do not pass `--fix` or `--comment`.
> 2. `<Only when security-sensitive:>` Then invoke the `security-review` skill.
>
> If a skill reports findings through a tool, also include them in your final message. Return
> each finding as: source (`code-review` or `security-review`), `path:start_line[-end_line]`,
> category, what is wrong, and the concrete failure it causes. Say whether the review covered
> untracked files.

## 3. Report

In a few lines: how many rounds ran and why the loop stopped (nothing new worth fixing, or the
cap); each fix, with where it was and how it was verified; findings skipped (with reasons),
repeats, and findings left open; questions collected as Ask; whether `/security-review` ran and
why; and the results of the checks. When another skill invoked this one, return the report to
it for its own report.
