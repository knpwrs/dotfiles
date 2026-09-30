# Style preset: whiteboard

A classic whiteboard animation: simple black-marker line drawings that draw on stroke by stroke on a clean white board, with a few spot colours and handwritten labels, telling one idea at a time. For training, education, onboarding and simple explainers; a large marketplace search category of its own.

*Draft preset: refine it after the first video built with it.*

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition: warm, clear, friendly teacher; one fixed direction |
| `music` | light, optimistic acoustic or ukulele/piano bed (90–110 BPM), low under the voice, no vocals |
| `length` | 60–180 s |
| `formats` | `16:9` |
| `thumbnail` | a finished drawing from the key scene + a hand-lettered title on the white board |

## Look

- A white board with a faint, even texture (not pure #FFF; a very light warm grey with subtle marker ghosting), no vignette.
- Line art in one near-black marker weight (with a thinner line for detail), plus at most two spot colours (the brand accent and one neutral highlight) used as flat fills or highlighter strokes.
- Hand-lettered labels and titles in a marker-style OFL font, drawn as glyph outlines; the key word per scene underlined or circled.

## Drawings

- Get vector line art: generate clean, simple black-on-white line drawings (one object per image, no shading, no text), then vectorise them to centre-line SVG paths (e.g. potrace, or an autotrace centre-line mode) so each stroke can draw on in order. Keep the stroke count modest; simplify paths.
- Order strokes the way a person would draw: outline first, then details, then fills; top to bottom, left to right.
- Characters are simple and consistent (the same stick-figure or line-character design throughout, from reference images).

## Motion

- Draw-on: each path reveals via `stroke-dashoffset` at a steady, human pace (a scene's drawing finishes as its narration line lands, not long after); fills wipe in after their outline with a soft marker-texture mask.
- An optional drawing hand (a flat illustrated hand holding a marker, never a photo) that follows the leading point of the current stroke; if used, it moves continuously between strokes and leaves the frame when the scene holds.
- Scene changes: the camera pans across one long board to fresh space, or an eraser-wipe clears the board; each scene holds ≥ 0.6 s finished before it moves.

## Sound

- Marker squeak/scribble foley under active drawing (soft, varied, never looping audibly), a light pop when a colour fill lands, a whoosh for pans; music ducked ≥13 dB under the voice; −14 LUFS.

## Verify

- Every stroke's reveal is monotonic and finishes; no path draws backwards or jumps; the hand (if used) stays on the stroke.
- Drawings contain no stray text, extra objects or broken lines; labels are spelled correctly and inside the frame.
