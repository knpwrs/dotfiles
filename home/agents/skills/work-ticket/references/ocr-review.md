# Open Code Review in delegation mode

Open Code Review (OCR) picks the files to review and the rules for each; in delegation mode a
subagent does the review with its own model, so OCR needs no LLM configured. It runs through the
open-code-review plugin's `delegate-review` command. Docs: https://open-codereview.ai/docs/delegate.

## Check it is available

Both must hold: `command -v ocr` succeeds, and `open-code-review:delegate-review` is in the
available skills. If either fails, use `/code-review high` instead. Do not install OCR or the
plugin without asking.

## Run it

Spawn one `general-purpose` subagent with the brief below, filling in `<from>` (the base the
change is measured against: `origin/<base>`, or in a stack the layer below) and `<to>` (`HEAD`).
Write the ticket's acceptance criteria to a file in the scratchpad as `<background file>`. Wait
for its result; do not review the same diff yourself meanwhile.

If the subagent returns `OCR FAILED`, fall back to `/code-review high` for that round and say so
in the report.

## Subagent brief

> Review this branch with Open Code Review. Invoke the `open-code-review:delegate-review` skill
> with args `--from <from> --to <to> -B <background file>` and follow it, with these overrides:
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
