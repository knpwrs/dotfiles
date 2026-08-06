# Structural patterns

Each pattern, why it reads as machine output, and the fix.

## Binary contrasts

The single most recognizable tell of 2024-era models onward. More than two in a 500-word block is high confidence on its own.

| Pattern | Problem |
|---------|---------|
| "It's not X. It's Y." | Telegraphed reversal |
| "It's not about X, it's about Y." | Same, hedged |
| "The question isn't X. It's Y." | Rhetorical misdirection |
| "The problem isn't X. The problem is Y." | Formulaic reframe |
| "Not because X, but because Y." | Same shape, causal |
| "It feels like X. It's actually Y." | Setup and reveal cliche |
| "Not just X but Y." | Additive hedge |
| "stops being X and starts being Y" | False transformation arc |
| "doesn't mean X, but actually Y" | Negation as a running start |

**Fix:** state Y. Delete the negation entirely.

- WRONG: "The question isn't the model. It's the eval."
- RIGHT: "The eval matters more than the model."

## Negative listing

Listing what a thing is not before naming what it is.

| Pattern | Problem |
|---------|---------|
| "Not a X. Not a Y. A Z." | Buildup through negation |
| "It wasn't X. It wasn't Y. It was Z." | Same, past tense |

**Fix:** say Z. The reader does not need the runway.

## Dramatic fragmentation

| Pattern | Problem |
|---------|---------|
| "[Noun]. That's it. That's the whole thing." | Performative simplicity |
| "X. And Y. And Z." | Staccato drama |
| "This unlocks something. Trust." | Manufactured revelation |
| One-sentence paragraphs stacked for pacing | Drama substituting for content |

**Fix:** complete sentences. Fragments survive only when they are the writer's own habit and not doing emotional work.

## Rhetorical setups

| Pattern | Problem |
|---------|---------|
| "What if I told you..." | Posturing |
| "Think about it:" | Condescending |
| "Here's what I mean:" | Redundant preview |
| "Plot twist:" | Manufactured turn |
| A question answered in the next sentence | Fake dialogue |
| "And that's okay." | Unnecessary permission |

**Fix:** make the point.

## Faux-insight setups

These flatter the writer as the only person who noticed.

- "What most people get wrong"
- "Here's what nobody tells you"
- "This is the part everyone skips"
- "The detail most teams miss"

**Fix:** cut the setup and let the claim stand on its own.

- WRONG: "The part everyone misses: distribution is the real moat."
- RIGHT: "Distribution is the moat."

## Colon reveals

A noun phrase, a colon, then a lowercase dramatic payoff.

- WRONG: "The detail that makes it work: a separate agent grades it."
- WRONG: "The best part: it learns."
- RIGHT: "A separate agent does the grading, which is what makes it work."

Colons introduce lists, labels, and quotations. Use sentence case after a colon unless grammar, a proper noun, a title, or code requires otherwise.

## Importance puffery

Claiming significance in place of demonstrating it.

- "stands as a testament to"
- "marks a pivotal moment"
- "plays a vital role"
- "solidifies its position"
- "underscores its significance"
- "this is what leadership actually looks like"
- "this is genuinely hard"

**Fix:** state the fact and let the reader judge.

- WRONG: "The launch marks a pivotal moment for the company."
- RIGHT: "The launch is the company's first paid product."

## Superficial analysis

Trailing `-ing` clauses that look like analysis and carry none: highlighting, underscoring, reflecting, showcasing, demonstrating, signaling.

- WRONG: "The launch adds file search, highlighting the team's commitment to better workflows."
- RIGHT: "The launch adds file search, so users can find old drafts without leaving the editor."

## Fake-strong verbs

Inflated verbs standing in for a plain description. Prefer "is" and "has" when they are clearer.

- WRONG: "The app serves as a centralized hub for sponsor management."
- RIGHT: "The app tracks sponsors, drafts, due dates, and approvals in one place."

## False agency

Inanimate things performing human verbs. Models reach for this because it avoids naming who acted.

| Pattern | Problem |
|---------|---------|
| "a complaint becomes a fix" | The complaint did nothing. Someone fixed it. |
| "the decision emerges" | Someone decided. |
| "the culture shifts" | People changed behavior. |
| "the conversation moves toward" | Someone steered it. |
| "the data tells us" | Someone read it and drew a conclusion. |
| "the market rewards" | Buyers paid for something. |
| "a bet lives or dies in days" | Someone killed the project or shipped it. |

**Fix:** name the human. If no specific person fits, use "you" and put the reader in the seat.

## Passive voice

| Pattern | Fix |
|---------|-----|
| "X was created" | Name who created it |
| "It is believed that" | Name who believes it |
| "Mistakes were made" | Name who made them |
| "The decision was reached" | Name who decided |

Passive voice is fine when the actor is genuinely unknown or irrelevant, and in the standard scientific register. It is not fine as a default.

## Narrator from a distance

Floating above the scene instead of putting the reader in it.

| Pattern | Problem |
|---------|---------|
| "Nobody designed this." | Disembodied observation |
| "This happens because..." | Lecturer voice |
| "People tend to..." | Armchair sociology |

**Fix:** "You" beats "people". Specifics beat abstractions.

## Endings

| Pattern | Problem |
|---------|---------|
| Fake-profound kicker | A cute metaphor or aphorism as the last line |
| Summary recap | "In conclusion", or a paragraph restating the piece |
| Mic-drop one-liner | Punchy closer with no new information |

**Fix for kickers:** delete the line. Do not rewrite it into a better metaphor and do not preserve its rhythm. End on the clearest concrete sentence already in the draft, or add a plain takeaway or next action.

## Headings

A heading names what the section holds. It does not tease, dramatize, or abstract.

| Pattern | Bad | Good |
|---------|-----|------|
| "The [Concept] Trap" | "The Initialization Trap" | "Import versus initialize: metadata loss risk" |
| "The [Adjective] [Noun]" | "The Hidden Danger" | "Firmware corruption after sudden power loss" |
| "Why [X] [Dramatic Verb] [Y]" | "Why Rebuilding Destroys Everything" | "How forced rebuilds overwrite parity on degraded arrays" |
| "[Noun]: The [Adjective] [Noun]" | "Encryption: The Hidden Trap" | "Hardware AES-256 on Passport bridge boards" |
| Vague analytical | "Broader implications" | "Effect on independent repair shops" |

Checks: could it be a thriller chapter title or a video thumbnail? Rewrite. Remove the leading "The" and see whether a dramatic noun pairing remains. A good heading reads like an entry in a technical manual index: specific, descriptive, and boring to anyone outside the subject. No parenthetical clarifications in headings.

## Structural repetition

Three consecutive sections built from the same template read as machine output even when every fact in them is true.

- WRONG, three sections of identical shape:
  ```
  In [year], [party] did [thing]. This affected [number] people. [Party] responded by [action].
  In [year], [party] did [thing]. This affected [number] people. [Party] responded by [action].
  In [year], [party] did [thing]. This affected [number] people. [Party] responded by [action].
  ```
- RIGHT, vary the shape:
  ```
  Section one: narrative with timeline and context across two paragraphs.
  Section two: two sentences, because the event is thinly documented.
  Section three: opens with the party's stated justification, then the contradicting evidence.
  ```

Related measures worth checking by eye:

- **Paragraph uniformity.** If every paragraph in a section lands within 15% of the same word count, vary them. Lists and tables are exempt.
- **Sentence uniformity.** If a 500-word block has no sentence under 8 words and none over 30, it lacks burstiness.
- **Transition density.** If more than a third of paragraphs open with a transition word or adverbial clause, the flow is artificial.
- **Opening repetition.** Three or more consecutive paragraphs starting with the same word or shape.
- **Flat register.** Human introductions run tighter, bodies denser, endings different. A monotone from start to finish is a tell on its own.

## Rhythm and word patterns

| Pattern | Fix |
|---------|-----|
| Three-item lists everywhere | Two items, or one, or four. Stop padding to three. |
| Every paragraph ending punchily | Vary endings |
| Em dashes | Remove. Comma, period, semicolon, parentheses, or restructure. |
| "Not always. Not perfectly." | Hedging dressed as reassurance |
| Lazy extremes: every, always, never, everyone, nobody | False authority. Use the specific case. |
| Synonym cycling across agent / assistant / tool | Repeat the plain word |
| Wh- sentence openers as a habit | "What makes this hard is..." becomes "The constraint is [the specific constraint]." Occasional use is fine; a pattern is not. |

## Formatting

- Emoji in headings or bullets.
- Bold sprinkled mid-sentence for emphasis.
- Bullet lists where two sentences of prose read better.
- A heading over a two-sentence section.
- Numbered steps imposed on something that is not sequential.
- Excessive boldface on concept names and product names.

Format follows content. It does not decorate it.

## Exclusion zones

Do not flag anything inside a direct quotation from a cited source, a title or name taken verbatim, or code and configuration shown as an example.
