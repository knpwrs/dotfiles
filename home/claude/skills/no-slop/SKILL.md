---
name: no-slop
description: Remove AI writing tells from prose while keeping the writer's voice, or audit a draft and report which patterns it contains without rewriting. Use when drafting, editing, or reviewing any prose (essays, posts, docs, READMEs, PR descriptions, commit messages, emails, release notes), and when asked whether text reads as AI-written.
---

# No Slop

Strip the patterns that mark text as machine-written. Keep everything that makes it sound like the person who wrote it.

There are two ways to fail here. The first is slop: hollow claims, formulaic contrasts, throat-clearing, puffery, hedging. The second is over-correction: a draft with a real voice sanded down into clean, tidy, interchangeable prose. Anti-slop tooling usually guards against the first and causes the second. This skill treats both as defects.

## Modes

**Edit** (default). The user hands over a draft. Make the smallest set of changes that removes the slop, then return the full edited draft followed by a short **What changed** list.

**Audit.** The user asks whether a draft reads as AI, or asks to scan or flag it without rewriting. Name each pattern that appears, quote the line, and give the fix in a handful of words. Do not rewrite. Do not claim to know what wrote it: detectors guess, named patterns are evidence the reader can check. Offer to edit afterward.

**Draft.** The user asks for new prose. Every rule here applies to your own output. Run `references/eval.md` against it before returning it.

If no draft has been provided, ask for it. If the audience or venue is unclear and it changes the edit, ask one question: who reads this, and where does it go? Otherwise get on with it.

## The one rule that outranks the others

Preserve the writer's voice. Read the whole draft first and note what belongs to this person: vocabulary, sentence cadence, bluntness, humor, profanity, uncertainty, digressions, level of polish. Those stay.

Consequences of that rule:

- Make the minimum effective edit. Fix slop, errors, repetition, and genuinely tangled sentences. Leave strong human sentences alone, including ones you would have written differently.
- Do not make every paragraph equally tidy. Uniform polish is itself a machine tell.
- Do not compress a rough draft into a tight one unless the user asked for that. Cutting should be proportional to the actual slop.
- Keep the writer's structure and detours unless the structure is hurting the piece. If you reorder anything, say why in **What changed**.
- Never add claims, statistics, examples, quotes, or opinions the writer did not have. If something is unclear, ask rather than invent.
- A rough draft with a real voice should still sound like the same person afterward.

## Hard bans

No judgment call, no exceptions outside quoted material, code, and titles taken verbatim from a source.

1. **No em dashes.** Use a comma, a period, a semicolon, parentheses, or restructure. This is the loudest single tell and the cheapest to remove. Also delete decorative dash clusters.
2. **No unsourced numbers.** Every figure must be real and attributable. An invented statistic is worse than no statistic.
3. **No fabricated attributions.** Never write that a person, company, or organization said or believes something without a real source. Do not infer a position from someone's role, employer, or party.
4. **No fabricated events, dates, milestones, or case studies.** Do not write a narrative scenario as though it happened unless it happened and you can point to where.
5. **No banned filler verbs, adjectives, transitions, or phrases.** The full lists are in `references/phrases.md`. If one appears in the output, the output fails.
6. **No emoji in headings or bullets.** No exclamation marks added for enthusiasm.
7. **No research-process narration.** Report what you can support and silently drop what you cannot. Never write "could not be located", "no record was found", or "as of [date] there is no public information". Do not enumerate what you failed to find, and do not add meta-commentary about how the text was assembled.

## Grounding

Slop is mostly a symptom of sentences that assert without carrying anything checkable.

- **Every claim ends on a concrete detail.** If a sentence cannot end on a fact, delete the sentence. "This practice has had a significant impact" becomes "The company replaced 11 million batteries in 2018, against the 1 to 2 million it forecast."
- **Replace intensifiers with the number they stand in for.** "Significantly higher than the cost of the part" becomes "$1,200 for a repair that needed a $5 chip."
- **Protect the specific fact.** Do not smooth a useful detail into generic importance. "The tool improves engineering productivity" becomes "The tool cut review time from 30 minutes to 8."
- **Commit or cut.** "May potentially", "can help to", "might be able to" hedge a claim into nothing. Either it happens or it does not. Say which. More than three hedges in one paragraph is a red flag; save hedging for genuinely disputed or pending things.
- **Name the source or drop the claim.** "Experts agree", "studies show", "widely regarded as" are weasel attribution. If the user has no source, ask instead of supplying one.
- **Write like a researcher, not a copywriter.** If a sentence could sit unchanged on any site in the category, it is generic. Anchor it or delete it.
- **When you contrast two things, name the mechanism.** Do not assert that one is newer, better, or unaffected without saying what specifically makes it so: the part, the version, the date, the supply-chain change. If you do not have that detail, do not imply the difference exists.

## Structure and rhythm

Full pattern catalog with fixes in `references/structures.md`. The ones that matter most:

- **Binary contrasts.** "It's not X. It's Y." "The question isn't X, it's Y." "Not just X but Y." State Y and move on. More than two of these in 500 words is a high-confidence tell.
- **Negative listing.** "Not a X. Not a Y. A Z." Say Z.
- **Throat-clearing openers.** "Here's the thing", "Let me be clear", "I'll be honest", "The uncomfortable truth is". Cut and state the point.
- **Faux-insight setups.** "What most people miss", "here's what nobody tells you", "this is the part everyone skips". These flatter the writer. Cut the setup; let the claim stand alone.
- **Colon reveals.** A noun phrase, a colon, a lowercase dramatic reveal. Rewrite as a sentence. Colons are for lists, labels, and quotes.
- **Importance puffery.** "Marks a pivotal moment", "stands as a testament", "underscores its significance". State the fact and let the reader decide whether it matters.
- **Superficial analysis.** Trailing `-ing` clauses that pretend to explain: "highlighting", "underscoring", "reflecting", "showcasing". Replace with the actual consequence.
- **Fake-profound kickers.** Delete the closing mic-drop metaphor. Do not rewrite it into a better metaphor and do not preserve its rhythm. End on the clearest concrete sentence already in the draft, or add a plain takeaway.
- **Summary-recap endings.** "In conclusion", "Ultimately", "Overall", or a final paragraph restating the piece. The reader was just there.
- **Dramatic headings.** A heading names what the section holds. It does not tease, dramatize, or abstract. "The Hidden Cost of Serialization" becomes "Parts pairing and third-party repair". Kill vague analytical headings too: "Broader implications", "Wider context", "The bigger picture". No parenthetical clarifications in headings.
- **Structural repetition.** Three consecutive sections built from the same template read as machine output even when every fact is true. Vary paragraph count, opening move, and sentence rhythm between sections. Three paragraphs in a row starting with the same word or shape is the same problem.
- **Formatting that decorates instead of organizing.** Bold sprinkled mid-sentence, bullets where two sentences of prose read better, a heading over a two-sentence section, lists padded to three items because three feels complete.
- **Active voice with human subjects.** "The team shipped it Tuesday" beats "the decision emerged". Inanimate things do not perform human verbs: complaints do not become fixes, cultures do not shift, data does not tell us. Name who acted, or use "you" to put the reader in the seat.
- **Synonym cycling.** If the plain word is right, repeat it. Do not rotate "agent", "assistant", "tool" for variety.

## Judgment calls

These three are where the source material disagrees. The resolution here favors voice preservation, because the alternative flattens everything it touches.

**Adverbs.** Cut them when they carry no information: "very", "quite", "extremely", "incredibly", "significantly", "truly", "basically", "obviously", "clearly", "fundamentally". Keep "just", "honestly", "actually", "literally", "maybe" when they carry real uncertainty, contrast, or the writer's spoken rhythm. A blanket ban on `-ly` words produces stilted prose, which is its own tell.

**Sentence length.** Vary it. Human writing alternates short and long; machine writing clusters around 15 to 20 words. If a 500-word block has nothing under 8 words and nothing over 30, it lacks burstiness. Do not fix this by stacking punchy fragments, which is a different tell.

**Fragments and spoken cadence.** Allowed when they are the writer's own. Banned when they manufacture drama: "That's it. That's the whole thing." "X. And Y. And Z."

## Prose in a repo

The same rules apply to commit messages, PR descriptions, code comments, READMEs, changelogs, and issue writeups, with a few local translations:

- A commit subject names what changed. It does not announce significance.
- A PR description says what changed, why, and what to look at. It does not open with "This PR introduces a comprehensive refactor that improves maintainability."
- Comments explain why, not what. A comment restating the line below it is filler.
- Docs state what the thing does and what breaks. No "seamlessly integrates", no "powerful and flexible", no "designed from the ground up".
- Do not report work as complete, verified, or tested when it is not. Say what you ran and what you skipped.

## Audit scoring

For audit requests, after naming the patterns, rate 1 to 10 on each dimension:

| Dimension | Question |
|-----------|----------|
| Grounding | Does every claim carry something checkable? |
| Directness | Statements, or announcements of statements? |
| Rhythm | Varied, or metronomic? |
| Trust | Does it respect the reader's intelligence? |
| Voice | Does it sound like a specific person? |
| Density | What is cuttable? |

Below 42 out of 60, revise. Report the scores with one line of evidence each. Never report a score on an edit request; scores invite polishing toward the rubric.

## Workflow

1. Read the entire draft before changing anything.
2. Identify the core point and three to five voice signals to protect. Keep this note internal. If you cannot find the core point, ask.
3. For an audit, produce the findings report and the scores, then stop.
4. For an edit or a draft, apply the rules above, then check the result against `references/eval.md` yourself. No separate evaluator agent.
5. Fix every failed check and run the checks again.
6. Return the full text plus a short **What changed** list. No preamble.
