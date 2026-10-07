# Style preset: whiteboard

A classic whiteboard animation: simple black-marker line drawings that draw on stroke by stroke on a clean white board, with a few spot colours and handwritten labels, telling one idea at a time. For training, education, onboarding and simple explainers.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition for a warm, clear, friendly teacher; one fixed direction for every line |
| `music` | a light, optimistic acoustic or ukulele/piano bed (90–110 BPM), low under the voice, no vocals |
| `length` | 60–180 s. Budget about 25 % on top of the spoken time for pans, drawing ahead of word-synced labels, and the end card (72 s of speech makes a film of about 89 s). |

## Look

- A white board with a faint, even texture: not pure #FFF but a very light warm grey (`#F6F5F1`) with low-frequency sheen and a few ghosted, half-erased marker smudges; no vignette. Make it a seamless procedural tile (2400 px shown at 1200 CSS px holds at 4K). Give the board a thin brushed-aluminium frame, seen only when the camera pulls back.
- Line art in one near-black marker weight (`#1F2328`, 7 board px; 5 px for short detail strokes), plus at most two spot colours used as scribbled marker fills, underlines and doodles, e.g. a warm amber (`#F2A33A`) for the subject and a cool blue (`#4A9FE0`) for contrast. With a brand kit, the brand accent replaces the first.
- Hand-lettered labels and titles in a marker-style OFL font (e.g. Kalam Regular/Bold), drawn as glyph outlines; underline the key word per scene in a spot colour.
- Thumbnail: the finished key-scene drawing multiplied onto a fresh board, under a big hand-lettered title with a marker underline.

## Drawings

- **Line-art criteria for the image bake-off** (test on two real objects): one even marker weight, closed shapes, no shading, no stray marks. Typical failures: parts drawn as double lines, thin sketchy strokes, a grey background, overlapping lines.
  - Prompt shape: "a simple cute cartoon <object>, clean black marker line art on a plain white background, one even line weight, closed outlines, no shading, no fill, no text, ONLY ONE OBJECT, centred, generous margin."
  - 1024 px sources are enough: everything becomes vectors, so no upscaling is needed.
- **Vectorise to centre lines; do not trace outlines.** potrace traces both edges of every line, so a draw-on shows two parallel strokes; autotrace's centre-line mode returns empty or fragmented traces.
  - What works: ink mask → skimage skeleton → pixel graph (drop diagonal links that duplicate a 4-path) → prune spurs → merge strokes straight through junctions → smooth and simplify.
  - Seeded flood fills of the paper regions enclosed by ink give clip polygons for the spot-colour fills.
  - Expect 15–21 strokes per object; that is about right.
- **Stroke order as a person draws it:** export a numbered preview of each object's strokes, then set the order and any reversed directions by hand (e.g. `--order 12,15,13,…,19r`). A handful of objects takes a few minutes and beats any heuristic. Rule of thumb: outline first, then details, then fills; top to bottom, left to right (for a creature: head, face, body, markings top-down, wings or limbs last).
- **Procedural doodles** cover anything better drawn in code: hexagons, drops, snowflakes, arrows, small repeated icons. Write their points in drawing order, add a slight seeded wobble and Catmull-Rom smoothing, and give every closed shape a little overshoot past its start.
- **Fills** are zig-zag marker scribbles (34 px wide, at 35°, rows 0.62 width apart) clipped to the region and laid **beneath** the outlines and any label on them. A fill added after a label or outline paints over it: insert it beneath them in DOM order and keep its timing.
- Keep characters simple and consistent: the same stick-figure or line-character design throughout, generated from reference images.

## Lettering

- Pre-outline every glyph with fontTools and kern with HarfBuzz. Rasterise each glyph large and run it through the same centre-line vectoriser to get the pen strokes that write it, ordered like handwriting.
- Show the crisp outline through an SVG mask made of those strokes, drawn on with `stroke-dashoffset`: text stays rigid under camera moves and still writes on.
- Keep end-card lines inside the board: measure the width and split long lines.

## Motion

- **Draw-on:** each stroke is an SVG path with `pathLength=1`, revealed by `stroke-dashoffset`.
  - Pace: 3,200 board px/s nominal (board px = CSS px at camera scale 1), rising to at most 4,000 only to reach the next word-synced label. Fills count at 0.3× their length, lettering at 1.2×.
  - Pen lifts: 0.03 s + distance/5,600 px/s between strokes (0.02 s + distance/9,000 inside lettering). A stroke that starts where the pen already is runs on with no pause. Minimum stroke time 0.07–0.1 s.
  - Reference speeds: a 21-stroke object takes about 2.3 s at half size and 3 s near full size; a 20-letter label about 1.4 s.
- **Timing to the voice:** group each scene's drawings under the aligned word they illustrate. A label starts 60 ms before its word; each scene's drawing finishes as its line lands.
  - Let the planner insert VO pre-rolls wherever drawing would run late, then loop: rebuild VO → re-offset words → re-plan, until no new pre-roll is needed. To tighten, reset pre-rolls to zero and re-converge (otherwise they only grow).
  - Most dead air comes from drawing a whole object *before* a word-synced label early in a line. Sync only the labels that matter, let the rest follow the drawing, and draw small repeated icons fast (up to 8,000 px/s).
  - Have the planner warn whenever a label starts after its word, and fix every warning.
- **Drawing hand (keep it; it's the genre's signature):** a flat illustrated hand holding a marker, never a photo, as a transparent 1024 px PNG shown at 512 CSS px. Measure the marker-tip offset from its alpha.
  - Drive it in screen space from the same plan: it rides the leading point of each stroke (one keyframe every ~9 px of stroke), eases between strokes, and leaves the frame when the scene holds.
  - AI reviewers tend to call it clutter and to misread it passing over a title as clipped text; ignore both.
- **Scene changes:** one long board of panels (2100×1250 px pitch, e.g. 3×3 for nine scenes). The camera pans 0.9 s (`power2.inOut`) after each scene holds finished; narration may start 0.45 s before the pan settles.
  - End with a 1.3 s pull-back to an overview of everything drawn, then an eraser block wiping the board in a zig-zag (a swath stroked with the board-texture pattern, 1.25 s), then the end card.

## Sound

- Synthesise marker foley locally (seeded) from the planner's event list: every stroke gets a felt-tip scratch with its own band-pass, grain and level, plus an occasional soft squeak. Lettering is lighter and brighter; fills get a zig-zag rhythm.
- A light pop when each colour fill lands (pitch-stepped up across a run), a whoosh for pans, an eraser rub.
- Duck the music ≥ 13 dB under the voice: an envelope from the line windows plus an adaptive extra duck per line, targeting 16 dB RMS.

## Verify

- **Draw-on audit, frame by frame:** render a no-hand copy of the final timing and compare consecutive frames wherever the camera holds still.
  - Ink never decreases (no backwards strokes).
  - No frame adds more ink than the pace allows; the biggest gain traces back to one fast stroke.
  - The planned hand tip lies on that frame's new ink (aim for ≥ 99 % of drawing frames).
- Step through every pan in the final file by eye: phase-correlation shift estimates are meaningless over blank board between panels.
- Drawings contain no stray text, extra objects or broken lines; labels are spelled correctly and inside the frame; fills sit under outlines and labels.
- Tooling pitfalls: some ffmpeg builds lack `drawtext` (render corner tags as PNGs with Pillow and overlay them); with the `tile` filter, `-frames:v N` counts output tiles, not input frames, so a tile may come from seconds later than you think.

## Limits

- Untested: recurring characters kept consistent across a film, 9:16 and 1:1 layouts, eraser wipes between scenes mid-film, a brand-kit accent colour, films over 2 minutes.
