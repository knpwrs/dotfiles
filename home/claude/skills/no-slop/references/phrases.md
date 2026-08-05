# Banned words and phrases

Scan every draft against this file before returning it. Exclusions: direct quotations from a named source, titles and names taken verbatim, code and configuration shown as examples, and any of these words quoted as an example of what to avoid.

## Verbs

| Avoid | Use |
|-------|-----|
| delve into | explore, examine, look at |
| leverage | use, apply, draw on |
| utilize | use |
| facilitate | help, enable |
| foster | encourage, support, build |
| bolster | strengthen, back up |
| underscore | emphasize, highlight |
| unveil | reveal, show, introduce, ship |
| navigate (metaphorical) | manage, handle, work through |
| streamline | simplify, cut steps from |
| enhance | improve, strengthen |
| empower | let, allow, give |
| supercharge | speed up, improve |
| harness | use |
| embark | start, begin |
| elevate | improve, raise |
| endeavor | try, attempt |
| ascertain | find out, determine |
| elucidate | explain, clarify |
| optimize (as filler) | improve, tune, speed up |

## Adjectives

| Avoid | Use |
|-------|-----|
| robust | strong, reliable, solid |
| comprehensive | complete, thorough, full |
| pivotal | key, central |
| crucial | important, essential |
| vital | necessary, essential |
| paramount | most important |
| transformative | major, significant |
| cutting-edge | new, recent, modern |
| groundbreaking | new, original |
| innovative | new, original |
| seamless | smooth, easy |
| intricate | complex, detailed |
| nuanced | subtle, detailed |
| multifaceted | varied, complex |
| holistic | whole, complete |
| meticulous | careful, exact |
| ever-evolving | changing |

## Nouns used metaphorically

Literal uses are fine. Flag only the figurative ones.

| Flag | Fine |
|------|------|
| a tapestry of regulations | a medieval tapestry |
| a symphony of features | Beethoven's symphony |
| a beacon of hope | a lighthouse beacon |
| in the realm of security | the realm of a kingdom |
| a testament to innovation | last will and testament |
| the repair ecosystem | Apple's software ecosystem |
| the regulatory landscape | the Arizona landscape |
| paradigm shift | (no literal use worth keeping) |
| game changer | (same) |

## Transitions and connectors

| Avoid | Use |
|-------|-----|
| furthermore | also, and |
| moreover | also, and, besides |
| notwithstanding | despite, still |
| that being said | but, still, however |
| with that in mind | (cut) |
| at its core | (cut, or name the thing) |
| in essence | (cut) |
| to put it simply | (cut) |
| it is worth noting that | (cut) |
| in the realm of | in, within, about |
| in the landscape of | in, within |
| in today's [anything] | now, today, currently |
| this begs the question | (cut) |

## Openers

- "In today's fast-paced world..."
- "In today's digital age..."
- "In an era of..."
- "In the ever-evolving landscape of..."
- "It's important to note that..."
- "Let's dive in" / "Let's delve into..."
- "Imagine a world where..."
- "Here's the thing:"
- "Here's what/why/how [X]" and every other "here's" construction
- "Let me be clear"
- "I'll be honest" / "I'm going to be honest"
- "The truth is" / "The reality is" / "The uncomfortable truth is"
- "It turns out"
- "Can we talk about"
- "Look,"
- "So," at the start of a paragraph
- Never start a sentence with "Whether you're"

## Closers

- "In conclusion..."
- "To sum up..."
- "In the final analysis..."
- "All things considered..."
- "At the end of the day..."
- "Ultimately," / "Overall,"
- "By [doing X], you can [achieve Y]"

## Empty phrases

- "when it comes to"
- "in terms of" (use "about" or "for")
- "with respect to" / "with regard to" (use "about")
- "pertaining to" (use "about")
- "in order to" (use "to")
- "the fact that" (rewrite the sentence)
- "prior to" (use "before")
- "subsequent to" (use "after")
- "in light of" (use "because of")
- "shed light on" (use "explain")
- "pave the way for" (use "enable")
- "a myriad of" / "a plethora of" (use "many" or a number)
- "it goes without saying"
- "this is where X comes in"
- "look no further"
- "our team of experts"
- "going forward"
- "in this article, we'll"

## Emphasis crutches

Delete these. They add volume, not meaning.

- "Full stop." / "Period."
- "Let that sink in."
- "Make no mistake"
- "This matters because"
- "Here's why that matters"
- "This changes everything" / "This is huge"

## Intensifiers and filler adverbs

Cut when empty. Keep only when the word carries real uncertainty, contrast, or the writer's spoken rhythm (see the Judgment calls section of `SKILL.md`).

Almost always empty: absolutely, basically, certainly, clearly, definitely, dramatically, essentially, exceptionally, extremely, incredibly, interestingly, naturally, obviously, quite, remarkably, significantly, surely, truly, undoubtedly, very, importantly, crucially, inherently, inevitably, deeply.

Judgment call: just, actually, honestly, literally, simply, genuinely, fundamentally, maybe, probably.

### Unstated-baseline comparatives

A separate failure from the empty intensifiers above: these claim the thing is off some norm without ever naming the norm, so the reader cannot check it and the writer never had to.

- unusually, uncommonly, atypically, abnormally, unexpectedly, surprisingly, strikingly, notably, impressively, refreshingly, oddly, curiously

"An unusually clean codebase", "surprisingly fast", "notably small". Unusual next to what? Either give the comparison ("300 lines where the old one was 2,000") or drop the adverb and let the adjective stand. `unusually` in particular is heavily overused in current model output; treat a single occurrence as a flag, not a judgment call.

Keep it only when the text goes on to say what the baseline is, and the deviation from it is the point.

## Hedging markers

AI hedges four to seven times more than human writers. Count them: more than three in a paragraph, or more than eight per thousand words in a section stating established facts, means the draft is hedging out of habit rather than honesty.

- Modals: may, might, could, potentially
- Cognitive verbs: I think, I believe, it seems, it appears
- Limiters: probably, generally, usually, arguably, likely
- Constructions: "may potentially", "can help to", "helps ensure", "might be able to", "one could argue that", "it should be noted that", "it is widely acknowledged that", "while X, Y remains", "remains to be seen", "further research is needed"

Appropriate hedging: pending legislation, ongoing litigation, genuinely disputed facts, and anything the writer honestly does not know. Do not flag those.

## Inflated symbolism

Corpus analysis puts these at hundreds of times their human frequency:

- "provide a valuable insight"
- "left an indelible mark"
- "play a significant role in shaping"
- "an unwavering commitment"
- "open a new avenue"
- "a stark reminder"
- "gain a comprehensive understanding"
- "serves as a testament"
- "watershed moment"
- "deeply rooted"

## Vague declaratives

Sentences that announce importance without naming the thing. Cut them or replace them with the specific thing.

- "The reasons are structural"
- "The implications are significant"
- "This is the deepest problem"
- "The stakes are high"
- "The consequences are real"
- "This has had a significant impact"
- "This plays a vital role"

## Meta-commentary

The text should move without narrating its own structure.

- "as discussed above" / "as we'll see" / "as mentioned earlier"
- "The rest of this post explains..."
- "In this section, we'll..."
- "Let me walk you through..."
- "Hint:" / "Plot twist:" / "Spoiler:"
- "You already know this, but"
- "But that's another post"
- "X is a feature, not a bug"

## Markup artifacts

Any occurrence means text was pasted from a tool without reading it. Zero tolerance: `oaicite`, `contentReference`, `turn0search0`, `grok_card`, `attributableIndex`.

## Severity, in context

A banned word next to specific named entities, dates, or amounts is more likely doing technical work than filler work. "A comprehensive examination of the issues" is worse than "the FTC's comprehensive audit in 2024". Downgrade the second, still prefer a plainer word.
