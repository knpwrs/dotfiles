# Style preset: kinetic-type

Bold typographic motion where the words are the picture: a manifesto, a quote, a brand promise or an event opener set word by word on the narration (or on the music), with confident type, colour and rhythm.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition for a strong, characterful read matching the brand; narration is the timing source (see Timing). With `voice: none`, time the words to the music. |
| `music` | a driving bed with clear accents (a lift and a resolution) for the cuts to ride; ask for an ending that resolves on a downbeat and rings out |
| `length` | 20–60 s |
| `formats` | `16:9`, `9:16` (each re-laid; vertical stacks words larger) |

## Engine

- No live text anywhere. In the build, shape every line with HarfBuzz (pair kerning), pull each glyph's outline with fontTools, and emit each word as its own SVG group of glyph paths with its measured ink box (advance plus real overhang) and its aligned time.
- The build lays out every card, runs the fit, mask and timing audits below, and fails on any violation; `film.js` only plays the moves from that data.

## Look

- One heavy display face with a Light weight in the same family (for the weight swap), plus an italic serif for emphasis words. Set big: lines fill 60–90 % of the frame width. In 16:9 that is about 160–300 px on 1080; in 9:16, about 170–340 px on 1920, one or two words per line.
- One flat colour field per section, cut on the section's first word. One accent colour for the key word of a line; keep contrast high. A new field about every 6 s does not feel busy.
- Supporting marks drawn from the type's own measured boxes, never clip-art, e.g. a highlighter stroke under an italic word, a hand-drawn pencil loop around a word, a typing caret that follows the words, a ring drawn behind a line.
- A faint grain overlay (about 9 % overlay) and a slow stage push (scale 1 → 1.035 per section) keep the flat fields from feeling static.
- Thumbnail: the key line set in the film's type on its colour field.

## Motion

- Use a vocabulary of 5–7 moves consistently; each word picks one:
  - **cut** (instant): the first word of a section or card
  - **rise** from a mask: the default for running words
  - **slam**: scale 1.3 → 1 with `back.out`, plus a small camera kick on the card (scale 1.03 → 1, `elastic.out`)
  - **slide** in from the right
  - **drop** from above with a small bounce
  - **track in glyph by glyph**: animate each glyph's x, staggered (never letter-spacing)
  - **weight swap**: land in Light, cross-fade to Black on the word's time
- Give every slam and drop a camera kick; without them the film reads as predictable, centre-locked cuts.
- **Reading order:** a word never starts moving before the previous word has landed. When narration runs fast (words about 0.14 s apart), shorten the move to ≥ 0.1 s rather than overlapping reveals.
- **Repetition is a device:** in a run like "One more tab. / One more ping. / One more reason…", hold the repeated words in place and change only the last one, which falls away while the next drops in. When the next card re-lays the held words, slide them to their new positions during the outgoing card's exit. The hand-over must be seamless; new words never rise next to held words that are still moving.
- **Exits** follow the content: up and out (default), left (a push into the next line), drop away (only the changing word), hard cut (when the gap to the next line is under about 1.8 s; it buys read time), and a scale-down into the lockup.
- Never more than one sentence on screen. Every element of a card leaves before the next card's first word.

## Layout

- Fit lines by **ink width** (advance plus any italic or punctuation overhang), not by advance; italic emphasis words overhang the frame otherwise.
- Size the base from the plain lines. An emphasis line may grow by its factor only as far as it fits, and an emphasis word is never smaller than the plain words around it.
- Reserve room for decorations in the fit: about 10 % of the line width for a trailing caret in 9:16, 20 % for a highlighter that runs past the ink.
- **9:16:** centre everything on the safe band (x = 510, y = 905), not the frame. Assert every word, mark and decoration against the safe area. Cap the size of a five-line card so it fits the band height.
- Rise masks are the real ink box plus 10 % of the size horizontally (18 % for italics) and 12 % vertically. Assert in the build that each mask clears the ink.

## Timing

- **Narrated (default):** generate the take, cut it into lines, and lay each line so its **first word lands on a music beat**. Then force-align the final laid VO and set every word fully revealed 60 ms before its spoken time. The voice's phrasing becomes the type's rhythm, and that is most of the film's character.
- **Music-only (`voice: none`):** put words on the eighth-note grid from each line's beat, but vary the note values by phrasing — hold the last word of a line onto the next beat, leave a rest before a key word. (Two eighths for long words leaves too little read time on short lines.) One eighth per word, uniformly, reads tidy but mechanical: every line ticks out at the same speed, then sits idle.
- **Read time.** Words land as they are heard, so the viewer reads along as the line builds. Require both:
  - after the last word lands, the full line holds **≥ max(0.6 s, 0.12 s per word)** before it starts to leave;
  - the line as a whole is on screen **≥ 0.3 s per word + 0.3 s** before it starts to leave.
  
  The build fails on a violation and prints the read-time table every time.

## Sound

- Duck music about 9 dB under each VO line (fast attack, slow release). If the music's own tail cuts off, fade it and carry the ring-out with a dark multi-tap echo of the final hit.
- Synthesised, seeded sound design is enough:
  - colour-field cuts: soft low thumps, alternating two voicings
  - slams: punchy body hits; a repeated run steps up two semitones per slam
  - glyph track-ins: a tick per glyph, climbing a semitone, panned across the word
  - airy whooshes on slides and exits; a plop on a drop; a thunk on a weight swap
  - a soft swell when a ring draws; key clicks on a caret; pencil scribble on a drawn loop
  - a chime on the wordmark
- Leave rises unsounded: the voice carries those.

## Verify

- In the build: reading order respected; the read-time table passes; every mask clears its ink; everything inside the frame (16:9) or the safe band (9:16).
- On the rendered file: for every revealed word, compare its ink box in three frames — just before its move (absent), on its time, and 0.2 s later (same as on its time). Don't compare against the end of the card, because the stage push drifts the edges. A camera kick in the reference frame can flag a word that is actually fine, so check every flag by eye.
- Step frame by frame through each hand-over of held words and each colour-field cut, looking at mid-move frames as well as fully built ones.

## Limits

- Music-only timing is less proven than narrated timing. Untested: 1:1, pieces over 45 s, textured or footage backgrounds, more than one typeface family.
