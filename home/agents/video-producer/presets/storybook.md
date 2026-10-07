# Style preset: storybook

An illustrated picture-book film: painted, gouache-style spreads with gentle 2.5D parallax, the story's words set on the page like a book and revealed as they are read, real page turns between spreads, a warm storyteller narrator, a soft acoustic score, and small looping-feeling details that are actually pure functions of time (candle flicker, drifting leaves and petals, a butterfly, rising "Z"s, golden motes). The same characters appear on every spread. For children's stories, picture-book authors and publishers, libraries and schools, family brands, and faith storytelling.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition for a warm, expressive storyteller: one narrator with light character colour. Direction: "A warm, expressive storyteller reading a classic picture book aloud to young children at bedtime: gentle, smiling, unhurried, clear diction, natural storybook pauses. Give [character A]'s words a quick, cheeky, playful colour and [character B]'s words a slow, calm, kindly colour, while always staying the same narrator. Declarative sentences end with firm, falling intonation." Name your own characters and their colours in it |
| `music` | gentle, whimsical acoustic score: nylon guitar, felt piano, pizzicato, clarinet/flute, glockenspiel, no drums, 88–96 BPM, no vocals. Give each character a colour in the prompt (e.g. "a cheeky bouncy figure for the quick one, a slow bassoon line for the slow one"). Ask for a sleepy lull where the story rests and a resolved final chord, and state the length; a good take lands the lull right under the resting beat |
| `length` | 60–90 s for a short fable (about 160 words of narration at ~130 wpm), plus about 15% on top of the speech for the title page, page turns and the end page |

## Look

- **Illustration style:** classic picture-book painting, gouache/oil-like dry brush, warm daylight from the upper left, muted warm palette. One style sentence goes into every prompt (keep it in one file the scripts share). Other options in the same pipeline: soft watercolour over a procedural cold-press paper texture, coloured pencil, cut paper, ink-and-wash.
- **Spreads are layered, never cut out of one painting:**
  - a full-bleed **background** with no characters ("No animals, no people, no characters, no text");
  - each **character pose** as a transparent cutout;
  - a shared **foreground strip** of grass and flowers, also a cutout;
  - a **leaf/petal/butterfly sheet** split into pieces by connected components.
- **Composition rule for backgrounds:** "The upper third is calm, softly painted sky with generous empty space; the lower third is open ground with room for characters." The sky takes the page text, the ground takes the characters. Pass the first background as the image reference for the rest so lighting and palette match.
- **A storybook frame:** open and close on an open book on a table by candlelight (one painting with blank pages, reused for the title page and the moral / "The End"). Push into the right-hand page and dissolve to the first spread; dissolve back to the book at the end.
- **Book dressing on every spread:** a centre-fold gutter shadow (a soft multiply band at x = W/2), a soft inner page vignette, and a procedural paper-grain tile (overlay, 0.55). They live inside the spread, so they turn with the page.
- **Typography:** a soft old-style variable serif (e.g. Fraunces, `SOFT 100, WONK 0`): weight 430 for page text at 44 px, 520 for titles, italic for subtitles, "The End" and the source line. Ink `#3a2a1d`. Set page text in the sky, top right (x 1000–1850, y 66), over a soft cream radial glaze sized from the measured ink box (`radial-gradient(closest-side …)`, never a rectangle). The page shows exactly the narration's words; the build asserts it.
- **Resolution:** when the image model returns about 1536 px, take every layer through an AI upscaler (e.g. Real-ESRGAN x4plus) at 4× → Lanczos down to 2×, blended 60/40 with a plain Lanczos 2× (keeps the brush texture). Backgrounds become 3072×1728 JPG (q93), cutouts 2× PNG. Before upscaling, bleed the colour of transparent pixels from the nearest opaque pixel so the upscaler sees no black halo.
- **Alpha clean-up:** model cutouts can carry a faint alpha haze (alpha 1–10) over large areas; viewers that ignore alpha show it as a glow, and it can tint composites. Map alpha `(a − 12)/(255 − 12)` and drop specks under 0.2% of the largest component.
- **Thumbnail:** the most story-telling spread frozen mid-action, page text hidden, the title set big in the book face over the sky with a soft cream glaze. Pillow loads a variable font at its Thin instance: set the axes by name (`b"Optical Size"`, `b"Weight"` …) for burned-in text.

## Characters and consistency

- **Image model criteria:** rich painted texture, natural animal anatomy (no animals standing upright unless the story asks), one pose per image, and clean native alpha rather than a painted ground or white background that must be keyed.
- **Method:**
  1. One **character sheet** first: every main character, each in a three-quarter and a side view, on plain paper, with clothing that anchors identity (e.g. a faded red knitted scarf, a blue waistcoat with brass buttons). Clothing does most of the identity work.
  2. Every pose is generated with that sheet as the image reference and a prompt that repeats the identity: "the same [character] from the reference character sheet (identical face, markings, proportions, colours and the same [clothing]), … ONLY ONE CHARACTER … Natural animal anatomy with exactly four legs … Isolated on a fully transparent background."
  3. A secondary character gets the sheet as a style reference only.
- **Pose list from the beats, before generating** (e.g. stand, smile, walk, rest; laugh/point, run, panic-run, sleep). Mirror a cutout to face the other way; don't regenerate for direction.
- **Check every cutout at full size** for legs, faces and stray objects; a good bake-off pose can go straight into the film.
- **Grade characters to the spread:** CSS filters per spread (`sepia(.18) saturate(1.12) hue-rotate(-6deg)` for golden evening, `brightness(.9)` in shade) plus a soft radial contact shadow under each character.

## Motion

- **One clock:** a single paused GSAP timeline with one linear tween on an accessor property whose setter calls `render(t)`; every layer, word, flap and mote is a pure function of `t` (seeded RNG, closed-form sines, modulo loops). Use the setter, not `onUpdate`: seeking suppresses callbacks by default, so snapshots and audits skip frames.
- **Parallax:** each spread is a world of items with a depth `d`. The camera is eased piecewise keys `{t, x, y, z}`; an item lands at `(p − C)·(1 + (z − 1)·d) + C + cam·d`.
  - Depths: background 0.3 (overscan 1.1), characters 0.62, leaves 0.85–1.2, grass 1.0 (1.18× frame width, bottom edge below the frame).
  - Pans are 40–110 px with zoom 1.0–1.12; keys follow the story, e.g. drifting toward the speaker on each line and following the walker.
  - With those numbers no layer edge enters the frame. Check the extremes.
- **Character acting:** small closed-form moves on the whole cutout.
  - Breathing: scaleY ±0.6%.
  - Laughing: a bounce plus a ±2° rock while the line is spoken.
  - Plodding: x at a constant 38–100 px/s, a |sin| bob of 4 px and a ±1.3° rock.
  - Dash: x eased by `u^1.35` off-frame, with a |sin| hop and lumpy dust puffs (multi-blob radial gradients) spawned along the path.
  - Change pose by a 0.9 s cross-fade (standing → asleep), with the shadow following.
- **Staging:** a figure walking "past" a sleeper at the same depth reads as standing on him. Put the sleeper higher (farther) and the walker lower (nearer), with ≤ 30 px vertical overlap, and lower the grass strip on that spread so the walker isn't buried. When several characters share a spread, spread them across the frame, and start an action on its verb ("raced"), not on the character's name.
- **Page turn (the signature):**
  - A fold line runs from the bottom edge to the top. The bottom corner leads, and the slant eases from ~520 to 220 px over 1.25 s (`power2.inOut`).
  - The outgoing spread is clipped to the half-plane left of the fold (`clip-path: polygon`).
  - The turning sheet's back is the frame-clipped right region reflected across the fold: an SVG polygon with a linear gradient from the fold outwards (shaded crease → cream → slightly darker edge), a grain pattern and a drop shadow.
  - A shadow strip on the revealed page sits just past the fold.
  - Compute the gradient direction from the flap's centroid so it points **into the flap**; the wrong sign paints the whole flap the first stop colour, a flat grey-tan.
  - The turn starts 0.12 s after a spread's last line ends, and the next line starts as it lands.
- **Push-in from the book:** fade the title page's text and characters out first (0.45 s), then dissolve the empty page into the painting; otherwise ghost characters show through.
- **Page text:** words fade and unblur (3 px → 0) over 0.27 s, fully visible 50 ms before each spoken word, on a layer that never moves or scales. When a spread holds two lines, the first fades out (0.4 s) before the next begins.
- **Showing spreads:** set items' `visibility` to `""` (inherit) when shown, never `visible`, which overrides a hidden parent spread and lets old spreads show through.
- **Deterministic ambient details:**
  - **Candle:** three screen/soft-light radial glows whose opacity and scale follow a sum of four incommensurate sines.
  - **Leaves and petals:** seeded drift paths that repeat on a period, with the jitter re-seeded per loop and a scaleX flutter. Leaf-sheet indices follow connected-component order: look at the split pieces before assigning the butterfly.
  - **Butterfly:** scaleX `0.3 + 0.7|cos 9.4u|` flapping on a meandering path.
  - **Sleep "Z"s:** capital Z in the book italic at 70–100 px; a lowercase z is too small.
  - **Motes:** dust in shade, gold at sunset.
  - Every drifting thing fades out near the characters' boxes (at their current offsets) and the text block; a leaf crossing a face reads as the animal eating it.

## Narration

- About 160 words for 60–90 s; one line per beat, 1–2 lines per spread. Retell faithfully from a named public-domain translation and keep its key phrases. Set the traditional moral on the final page as an exact quotation with its source line.
- Take selection: 3 takes per line. Pick on forced-alignment confidence, transcription match and **sentence-final register**: the last word's median f0 against the preceding 1.2 s, where −3 to −7 st is a firm fall. In-word slope is unreliable on short words.
- Storyteller reads often come in slow (~118 wpm): `atempo` 1.1 brings them to ~130. Gaps: 1.5 s between spreads (the turn), 0.7 s within one.

## Sound

- Synthesised foley, free and deterministic (3 seeded variants per kind, round-robin with small pitch nudges):
  - `turn`: a band-swept paper swish with fibre crackle and a soft landing thump, pitch-stepped per turn.
  - `air`: a swell for the push-in and the dissolve back to the book.
  - `candle`: a quiet crackle bed on the book pages.
  - `bird`: FM chirps in outdoor spreads.
  - `plod`: a soft felt thud per step of a slow walker, alternating 0 / −1 / −2 / −1 st.
  - `whoosh`: a dash.
  - `pluck`: a pizzicato bounce under a laugh.
  - `flag`, `snooze` (two drowsy glockenspiel notes), `scamper` (paw taps).
  - `bell`: at a finish or arrival.
  - `shimmer`: a glockenspiel arpeggio under the moral; `chime` for the title and "The End".
  - Keep it felt more than heard: bus gains 0.07–0.3.
- Leave vocal sounds (yawns, giggles) to the narrator; don't synthesise them.
- Music held 13 dB under every line (adaptive extra duck on top of the line windows), and lifted ~4 dB after the last line so the final chord rings.

## Formats

16:9 is native: a picture-book spread is a landscape double page with a centre fold. A 9:16 re-lay of 16:9 art is not worth it: the book-on-table frames don't fit a vertical frame (a page crop loses the candle), the backgrounds would be enlarged 1.22× at 1080p and miss a 4K ceiling, and every spread needs its own reframing. For a vertical deliverable, plan it from the start:
- generate 9:16 single-page backgrounds (sky top, ground bottom) and a portrait book frame;
- set the page text in the top band (y 250–560);
- put characters on the ground around y 1500;
- keep the same cutouts and engine, with every aspect-dependent value chosen through one helper.

## Verify

- **Build audit:** every page word is inside the frame, fully visible at its reveal, and held ≥ 0.6 s before its fade, turn or dissolve. The build fails if page text ≠ narration.
- **Snapshots** of every spread settled and mid-action: a dash, a walk past a sleeper, mid page turn, mid push-in.
- **Final file:** step through each page turn every 2nd frame: the flap is shaded (not flat), no tears at clip edges, no frame jumps. Check every spread's layer edges at the camera extremes.
- **Character check at full size** on frames from the master: same clothing, face, markings; correct leg count; nothing crossing faces.
- AI video reviewers misread depth overlaps (one character walking in front of another as "a duplicate on its back"); verify on frames.

## Limits

- Untested: a story longer than 2 minutes, human characters, a client's own illustrations, a brand-kit typeface, and a built 9:16 version.
