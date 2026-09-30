# Style preset: paper-collage

A whimsical, hand-made cut-paper stop-motion explainer: warm, clear, a little playful, explaining rather than telling a story.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition for a warm, friendly narrator (previous winner: Gemini TTS `Sadaltager`, warm American male — include as a candidate); default direction "warm, friendly, upbeat, confident narrator"; every line uses the same direction string unless a line needs an intonation note |
| `music` | a whimsical bed (pizzicato, glockenspiel, lute/reeds, ~96–105 BPM), trimmed so audio starts on frame one |
| `length` | 60–120 s |
| `thumbnail` | paper-collage: the subject's title on a torn/taped paper card, one bold label, a character or prop, an indigo/parchment/brand ground |

## Look

- Palette and type from the subject's own branding (site, cover, logo); handwriting in Caveat, quotes in a book serif (EB Garamond or the cover's face), UI text in Inter.
- Art: transparent cut-paper assets from the image model that wins the bake-off for clean transparency and paper texture, ONE OBJECT per image, no baked-in text, character consistency via reference images; paper textures, tape and torn strips sharp at `asset_resolution`. Display cutouts at ≤ ~500 CSS px (1024 px sources) so they stay sharp at 4K.
- Mascot only if the subject has one.

## Motion and craft

- Stop-motion feel: props/characters animate on twos (12 fps holds), ink boils at 8 fps (SVG turbulence), cutouts jitter, grain + subtle flicker.
- Torn-paper sheet wipes between scenes; every animation completes and holds ≥0.6 s before a wipe covers it.
- Measure, never hard-code: cards sized to their measured text with even padding; tape, underlines, rays, arrows and landing points placed from measured boxes (derive image heights from known aspect ratios — images may not be loaded at build time).
- Lockups: build titles as one measured unit (mark height = text block height, consistent gaps) on a strip sized to fit.
- Handwriting write-on stays hidden until its start time, and its reveal never clips the text: script fonts (and trailing punctuation) overhang their text box, so end the `clip-path` reveal well outside the box on every side (or pad the element) and remove the clip once revealed. Check every text element's glyph bounds against its visible area at its fully revealed moment.
- Glyphs: real font glyphs for ?, !, $; inspect any hand-drawn symbol at full size.
- Doodle SVGs sit above props (append them last in each stage; raise z-index when a prop is promoted).

## Sound

CC0 paper foley (tape, slaps, swooshes, typing, pops, marker writing, stamps) on every beat, following the Sound variety rule; music ducked under the VO; −14 LUFS.

## Implementation notes

- **On twos:** animate props and characters with a helper that emits one `tl.set` per step at 12 fps (or 24 for snappy slaps) instead of a smooth tween — `anim(el, t0, dur, p => props, fps)` sampling an eased progress `p` — so motion holds like hand-moved paper. Only the slow camera drift on a scene's stage is a smooth tween (scale 1 → ~1.03 over the scene).
- **Boil and jitter:** ink doodles live in an SVG with a `feTurbulence` + `feDisplacementMap` filter whose `seed` changes every 1/8 s from a seeded RNG; each cutout sits in a `.pp > .j` wrapper whose `.j` gets tiny seeded x/y/rotation offsets at 8 fps.
- **Texture:** a grain PNG with `mix-blend-mode: overlay` whose `background-position` jumps at 12 fps, a soft vignette, and a faint warm flicker layer.
- **Primitives:** pop (scale from 0 with back-out overshoot), drop (fall from above with squash on landing), rise (from below), slap (scale 1.5 → 1 with a small settle), hop; `draw(path)` reveals SVG strokes via `stroke-dashoffset`; `writeOn(el)` reveals handwriting left-to-right with an animated `clip-path: inset(…)`, the element hidden (opacity 0) until its start; `typeOut` reveals text character by character.
- **Torn-paper wipe:** a wide strip of two mirrored torn-edge paper sheets (height ≈ frame height + margins, sheet aspect preserved) that travels across the frame on twos with slight random rotation/offset, fully covering the frame at the cut; scene clips switch underneath at the midpoint.
- **Cards:** paper-textured boxes sized to their measured text (fit-content with even padding), taped with a semi-transparent tape image at a slight angle; word-by-word scripture reveals keyed to aligned word times, monotonic per card.
