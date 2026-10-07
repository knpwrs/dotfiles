# Style preset: paper-collage

A whimsical, hand-made cut-paper stop-motion explainer: warm, clear, a little playful, explaining rather than telling a story.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition for a warm, friendly narrator; direction "warm, friendly, upbeat, confident narrator", the same for every line unless a line needs an intonation note |
| `music` | a whimsical bed (pizzicato, glockenspiel, lute/reeds, ~96–105 BPM) |
| `length` | 60–120 s |

## Look

- Palette and type from the subject's own branding (site, cover, logo); handwriting in a casual script (e.g. Caveat), quotes in a book serif (e.g. EB Garamond, or the cover's face), UI text in a clean sans (e.g. Inter).
- Art: transparent cut-paper cutouts, judged in the bake-off on clean transparency and paper texture; ONE OBJECT per image, no baked-in text, character consistency via reference images. Display cutouts at ≤ ~500 CSS px from 1024 px sources so they stay sharp at 4K.
- Paper textures, tape and torn strips: use a paper-collage kit if the user has one; otherwise generate them.
- Mascot only if the subject has one.
- Thumbnail: the subject's title on a torn, taped paper card, one bold label, a character or prop, on an indigo, parchment or brand ground.

## Motion

- Stop-motion feel: props and characters animate on twos (12 fps holds), ink boils at 8 fps, cutouts jitter, grain plus a subtle flicker.
- Torn-paper sheet wipes between scenes.
- Place tape, underlines, rays, arrows and landing points from measured boxes; derive image heights from known aspect ratios, since images may not be loaded at build time.
- Lockups: build titles as one measured unit (mark height = text block height, consistent gaps) on a strip sized to fit.
- Handwriting write-on stays hidden until its start time. Script fonts and trailing punctuation overhang their box, so end the `clip-path` reveal well outside the box on every side (or pad the element), and remove the clip once revealed.
- Doodle SVGs sit above props: append them last in each stage and raise z-index when a prop is promoted.

## Sound

- CC0 paper foley on every beat: tape, slaps, swooshes, typing, pops, marker writing, stamps.

## Implementation

- **On twos:** animate props and characters with a helper that emits one `tl.set` per step at 12 fps (24 for snappy slaps) instead of a smooth tween — `anim(el, t0, dur, p => props, fps)` sampling an eased progress `p` — so motion holds like hand-moved paper. Only the slow camera drift on a scene's stage is a smooth tween (scale 1 → ~1.03 over the scene).
- **Boil and jitter:** ink doodles live in an SVG with an `feTurbulence` + `feDisplacementMap` filter whose `seed` changes every 1/8 s from a seeded RNG; each cutout sits in a `.pp > .j` wrapper whose `.j` gets tiny seeded x/y/rotation offsets at 8 fps.
- **Texture:** a grain PNG with `mix-blend-mode: overlay` whose `background-position` jumps at 12 fps, a soft vignette, and a faint warm flicker layer.
- **Primitives:** pop (scale from 0 with back-out overshoot), drop (fall from above with squash on landing), rise (from below), slap (scale 1.5 → 1 with a small settle), hop; `draw(path)` reveals SVG strokes via `stroke-dashoffset`; `writeOn(el)` reveals handwriting left to right with an animated `clip-path: inset(…)`, the element at opacity 0 until its start; `typeOut` reveals text character by character.
- **Torn-paper wipe:** a wide strip of two mirrored torn-edge paper sheets (height ≈ frame height + margins, sheet aspect preserved) that travels across the frame on twos with slight random rotation and offset, fully covering the frame at the cut; scene clips switch underneath at the midpoint.
- **Cards:** paper-textured boxes sized to their measured text (fit-content with even padding), taped with a semi-transparent tape image at a slight angle; word-by-word quote reveals keyed to aligned word times, monotonic per card.
