# Style preset: kinetic-type

Bold typographic motion where the words are the picture: a manifesto, a quote, a brand promise or an event opener set word by word on the narration (or on the music), with confident type, colour and rhythm. The general-purpose sibling of `kinetic-scripture`.

*Forked from `kinetic-scripture.md`; read it for the word-timing and glyph engine. Refine after the first video built with it.*

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition: a strong, characterful read matching the brand; or `none` with the words timed to the music |
| `music` | a driving bed with clear accents (a build and a drop or resolution) that the cuts ride |
| `length` | 20–60 s |
| `formats` | `16:9`, `9:16` (each re-laid; vertical stacks words larger) |
| `thumbnail` | the key line set in the film's type on its colour field |

## Look

- One or two typefaces with range (a heavy display face and a light or italic counterpart), set big: key words fill 60–90 % of the frame width.
- Flat colour fields or one textured background per section; one accent colour for the key word of each line; high contrast always.
- Occasional supporting shapes (bars, circles, underlines) drawn from the type's own proportions; no clip-art.

## Motion

- Words appear on their aligned times (voice) or on the beat grid (music-only), ~60–70 ms before the sound.
- A vocabulary of 4–6 moves used consistently: slam (scale 1.3 → 1 with a tiny settle), rise from a mask, track in glyph by glyph (animate each glyph's x, never letter-spacing), split and slide, weight or size swap on emphasis, and a cut to a new colour field on section changes.
- Lines build, hold long enough to read (≥ 0.25 s per word after the last word lands), then clear before the next; never more than one sentence on screen.
- All text drawn as glyph outlines (rigid-text rule); masks clear the real glyph bounds.

## Sound

- Cuts and slams on beats; soft impacts or whooshes only where they add punch; music ducked under any voice; −14 LUFS.

## Verify

- Every word's reveal lands on its time; nothing clipped by masks; every line holds long enough to read at the delivered size.
