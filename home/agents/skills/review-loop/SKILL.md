---
name: review-loop
description: >
  Review a change and fix what is worth fixing, in a loop: a fresh subagent reviews with Open
  Code Review in delegation mode (else /code-review) and only reports, you judge each finding,
  fix, and run the checks, then review again until a round has nothing worth fixing, at most
  five rounds. Use when asked to review and fix in a loop, "loop the OCR review", "review until
  clean", or to run /open-code-review:delegate-review repeatedly on some changes. work-ticket,
  work-stack, and work-feature use it for their review step.
argument-hint: "[max rounds] [paths, --commit <sha>, or --from <ref> --to <ref>] [-B <background file>] [--commit-rounds]"
---

# Review and fix in a loop

Review the change named in `$ARGUMENTS`, fix what is worth fixing, and review again, until a
round has nothing worth fixing or the round cap is hit. Each review is done by a fresh subagent
that only reports; you judge and fix.

A loop that runs until the reviewer has nothing to say rarely ends: each review comments on the
previous round's fixes, and most late findings are about code the loop itself wrote. So the loop
ends on your judgment ("nothing here is worth fixing"), not on an empty review, and later rounds
hold the loop's own code to a higher bar.

## Inputs

- **Max rounds:** a leading number in the arguments, else 5.
- **Scope:** paths, `--commit <sha>`, or `--from <ref> --to <ref>`, as `ocr delegate preview`
  takes them. With none, the workspace (staged, unstaged, and untracked). If the working tree
  holds unrelated work, narrow the scope to the files that belong to the change and say which
  you excluded.
- **Background:** the file given with `-B` (usually acceptance criteria). Without one, write a
  sentence or two on what the change does to a file in the scratchpad and use that.
- **`--commit-rounds`:** commit each round's fixes in the repo's commit style. Without it, do
  not stage or commit.

## Permissions

Allowed without asking: editing files in scope, running the project's checks, and spawning the
review subagent. Ask first: installing OCR or its plugin, changes outside the scope, and
anything that changes the design or scope of the change.

## 1. Pick the reviewer

Use Open Code Review when both hold: `command -v ocr` succeeds, and
`open-code-review:delegate-review` is in the available skills. Otherwise use `/code-review`, and
say in the report that OCR was not available (the CLI is `brew 'open-code-review'` in the
Brewfile; the plugin is enabled in Claude settings).

## 2. Each round

1. **Review.** Spawn one `general-purpose` subagent with the brief below; a new one each round,
   so it reads the code fresh. Wait for its result, and do not review the same diff yourself
   meanwhile. If it returns `OCR FAILED`, use `/code-review` for this round and say so in the
   report.

   With `/code-review`, invoke it through the Skill tool (`code-review`, args `high` plus the
   scope: `<from>...<to>` for a range, nothing for the workspace). Do not pass `--fix` or
   `--comment`: you decide what gets fixed, and nothing gets posted.
2. **Judge** each finding against the code, reading whatever it needs:
   - **Fix:** real bugs, missed edge cases, missing tests, and cheap clear improvements.
   - **Skip:** false positives, and suggestions that are out of scope or contradict repo
     conventions. Keep the reason.
   - **Ask:** anything that changes the design or scope. Collect these and ask once, at the end
     of the loop, unless an answer blocks the remaining work.

   From round 2 on, raise the bar:
   - A finding about code you changed in an earlier round of this loop is Fix only if it is a
     high-severity bug (OCR) or a correctness bug (`/code-review`). Skip the rest as
     "loop-written, not worth another round".
   - With `/code-review`, fix only correctness bugs anywhere, and skip cleanup, simplification,
     efficiency, and altitude suggestions. It asks for findings even on clean code, and chasing
     them churns the change.
   - Findings already skipped or asked about are not new, even reworded; do not reopen them.
3. **Stop** if nothing was judged Fix.
4. **Fix** each Fix finding in the style of the surrounding code. Then run the project's own
   checks for the touched files (lint, format, type check, and tests; follow `CLAUDE.md` for
   how), and fix any failure your fixes caused. When a fix changes runtime behavior and the app
   can be run, check it in the app.
5. **Commit** the round's fixes if `--commit-rounds` was given.
6. Start the next round over the same scope (the fixes are now part of the diff, so they get
   reviewed too). After the last allowed round, stop even if findings remain, and list them.

## Subagent brief

Fill in the scope arguments and the background file.

> Review this change with Open Code Review. Invoke the `open-code-review:delegate-review` skill
> with args `<scope args> -B <background file>` and follow it, with these overrides:
>
> - Report findings only. Ignore its instruction to fix issues: do not edit files, commit, or
>   post anything.
> - If `ocr` is missing or `ocr delegate` fails, do not install anything; stop and return
>   `OCR FAILED:` with the error.
> - Read whatever context a finding needs (the whole file, callers, tests) before reporting it,
>   and do not stop at the first serious finding.
>
> Return a summary line (`total_files`, `reviewed_files`, `skipped_files` with reasons,
> `coverage_rate`), then each high and medium finding as: `path:start_line[-end_line]`,
> severity, category, what is wrong, and the concrete failure it causes.

## 3. Report

In a few lines: how many rounds ran and why the loop stopped (nothing worth fixing, or the
cap); each fix, with where it was and how it was verified; findings skipped (with reasons) and
left open; questions collected as Ask; OCR coverage from the last round; and the results of the
checks. When another skill invoked this one, return the report to it for its own report.
