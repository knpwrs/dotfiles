---
name: work-stack
description: >
  Turn a parent ticket's child tickets into one stack of PRs, one layer per child: order the
  children by dependency, create the stack with gh-stack, do each child's work on its own layer
  the way work-ticket does (implement, test, /code-review, fix), then open every layer as a draft
  PR. Use when asked to work on, implement, or stack a parent ticket, epic, or story with
  sub-tickets, or when /work-ticket is given a ticket whose children each need their own PR.
argument-hint: "<parent ticket id or URL> [extra instructions]"
---

# Work a stack

Take the parent ticket in `$ARGUMENTS` to a stack of draft PRs, one per child ticket. Anything
after the ticket reference is extra instruction from the user and overrides the tickets where
they conflict.

This skill builds on two others. Read both before starting:

- `../work-ticket/SKILL.md` (next to this skill's directory): how to read a ticket, do the work,
  review it, and write a PR. Its permissions apply here too.
- The gh-stack skill: always use its non-interactive forms of `gh stack` commands, and its rules
  for which layer owns a change.

## 1. Read the tickets

1. Read the parent the way work-ticket step 1 does, and list its children with whatever tools the
   tracker offers. Read every child in full: description, comments, attachments, and relations.
2. Drop children that are done, canceled, or already merged, and children with no code change
   (manual tasks, docs outside the repo). Keep a note of each for the report.
3. Order the rest bottom to top: a child that another child depends on goes lower. Use explicit
   relations (blocks / blocked by) first, then what the work itself requires (a schema before
   the code that uses it, an API before its client), then the tracker's own order.
4. Show the user the planned stack, bottom first: one line per layer with the ticket id, title,
   and branch name, plus the skipped children and why. Ask once, together with any questions
   about the tickets, before creating branches. Continue without asking only if the user said to.

If the children belong to different repos, stack only the ones in the current repo and say which
were left out. If there is only one open child, use work-ticket instead.

## 2. Set up the stack

Follow work-ticket step 2 to check where things stand, then:

- **Already in a stack for this parent** (a restart, or work the user began): map its layers to
  the children by branch name and commits. Keep finished layers, continue from the first
  unfinished one, and add missing children with `gh stack add`. If the existing order conflicts
  with the plan, ask before restructuring.
- **Child branches exist outside a stack**: ask whether to build the stack from them
  (`gh stack init <branch>...` adopts existing branches) or start fresh.
- **Otherwise**: from an up-to-date base, `gh stack init <first-branch>` for the bottom layer.
  Add each later layer with `gh stack add <branch>` when you reach it, not all up front, so each
  branch starts from the finished layer below it.

Name each branch with its child's suggested branch name when the tracker gives one, otherwise
after the repo's recent branch names.

## 3. Work each layer, bottom to top

For each child, on its own layer:

1. Do work-ticket steps 3 and 4 for that child: implement, test, commit, `/code-review high` on
   this layer's diff only (against the layer below), fix what is worth fixing, commit.
2. Keep each layer to its own ticket. If a later child needs a change in a lower layer, check out
   that layer, commit there, `gh stack rebase --upstack`, and return. Never put a lower ticket's
   change on a higher layer.
3. Before moving up, make sure the layer builds and its tests pass on its own; a reviewer will
   see it alone.

Stop and ask if a child turns out to be much larger than expected, or to depend on something no
child covers.

## 4. Open the draft PRs

1. `gh stack submit --auto` pushes every layer and opens each PR as a draft.
2. The generated titles and bodies are placeholders. For each PR, write the title and body the
   way work-ticket step 5 does, about that layer's child ticket only; link the child ticket and
   mention the parent. Apply them with `gh pr edit <number> --title ... --body-file <file>`.
3. Confirm with `gh stack view --json` that every layer has an open draft PR.

## 5. Report

One line per layer, bottom first: PR URL, ticket, and what it does. Then how it was tested,
review findings fixed and skipped (with reasons), skipped children, and anything left open.

End with one offer: mark every PR in the stack ready for review and hand the stack to
`/babysit-pr stack`. If the user accepts, run `gh pr ready <number>` for each PR, then invoke the
babysit-pr skill with `stack`. If any questions are still open, say they should be answered
first.
