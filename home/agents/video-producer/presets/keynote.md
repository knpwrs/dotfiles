# Style preset: keynote

A restrained, modern, cinematic presentation film built from a slide deck — the kind of film that plays before or instead of a talk (an annual update, a launch, a pitch, a report to supporters). Not a slide recording: every beat is designed motion in the deck's brand — generous whitespace, one idea per moment, confident typography, precise motion, honest data, and real product screens.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition for a warm, sincere, grounded narrator matching the requested accent (one fixed direction, e.g. "Warm, sincere, grounded narrator presenting an update to a room of supporters: clear and confident, conversational, unhurried, never salesy or theatrical; declarative sentences end with firm, falling intonation.") |
| `music` | a restrained two-cue score — warm, grounded, cinematic (felt piano, soft strings, low warm pads, a slow gentle pulse); no bouncy rhythms, no sparkly/glockenspiel/pizzicato textures, no chirpy major-key bounce. Cue A builds patiently through "what we built / growth"; cue B is intimate for the need and the ask and resolves under the close |
| `length` | what the deck needs (typically 3–6 min) |

## Content from the deck

- Extract the deck first: slide text, presenter notes (often below the slide on the same page), embedded screenshots at native resolution, fonts and colours (e.g. with PyMuPDF: `page.get_text()`, `page.get_images()` + `extract_image`, `page.get_fonts()`). Where the final deck and earlier notes differ, the deck wins.
- Follow the deck's content and order; light reordering or combining is fine. Keep every number exactly as given, approximations approximate ("about", "~", ">", ranges). Add no claims, features or numbers.
- Read before/after slide pairs as comparisons (e.g. an old design followed by a new one) and stage them as a clear, labelled Before → Today moment.
- Write a fresh narration from slides + notes: sincere, plain, grateful, confident — no hype, jokes or salesiness. The narrator speaks for the organization as "we"; lines that thank or ask the audience address them as "you". Fix small wording slips in the notes. Respell anything TTS gets wrong (e.g. "allusions" → "a-loo-zhuns") and verify by listening, since transcription can't tell near-homophones apart.
- Instead of platform copy, write `PRESENTER.md` for whoever plays the film: running order, total runtime, section start times, and which file to play.

## Look

- Two stages only: the brand's near-white (one huge, 4–5 % tint disc as the sole ornament) for statements and data, and a near-black stage with a soft brand-colour glow from the top for product screens. Switch between them only at section boundaries with a 0.8–1.0 s dissolve.
- The deck's own typefaces: its display face at 700/800 for statements (≥70 px at 1080p; hero numbers 160–300 px), its text face for captions (30–40 px). Force lining figures (`font-variant-numeric: lining-nums`) — many display faces default to old-style numerals. Kickers 20–26 px uppercase with 0.18 em tracking. One accent colour per sentence; the rest ink.
- The official wordmark as vector (from the organization's site or the deck).
- Product screenshots always in a browser frame (≈44 px chrome, three dots, a URL pill with the real domain), 18 px radius, deep soft shadow; on the dark stage the frame nearly fills the width. Recapture a screen live at high DPR if the deck's copy is too small for the target resolution. Blur or crop any third-party artwork on screen that an applicable content guide rules out.
- Thumbnail: the brand wordmark + title on the light stage, with a framed product screen.

## Motion

- One idea per moment: a statement, then clear it before the next. Stat panels never share the frame.
- Word reveals: a soft rise (20–26 px) out of an 8 px blur, keyed to the aligned word.
- Outline text in the browser: build the page with live text, then — before any tween is attached — replace every text node with SVG outlines at the browser's own per-character positions via `Range.getClientRects`, make the live text transparent, set `font-variant-ligatures: none` so layout and outlines use the same glyphs, then build the timeline. Track titles in by animating each glyph's x, never letter-spacing.
- Screenshots: a camera per shot (x/y/scale on an inner layer, clamped so the shot always fills its frame), 1.1–1.6 s eased pushes; focus with a spotlight (a dimming layer with a hole) plus a thin glowing ring, crossfading between focus areas rather than moving them; slow pans down long pages when the notes say "scroll".
- Highlights: measure every rect on the native screenshot (OCR word boxes for text, background-brightness profiles for pills/chips/cards, pixel extents for icons), draw it on a proof image first, then render it as SVG inside the screenshot's camera layer (same transform), revealed by opacity only; set stroke width for the zoom it is seen at (`vector-effect: non-scaling-stroke` ignores CSS transforms on ancestors).
- Demo gestures: a real pointer glyph counter-scaled against the camera zoom, a click pulse, then a dive into the clicked element that match-cuts to where it leads (preload/decode the destination; one moderate zoom and a single short crossfade).

## Data

- Numbers count up with before → after comparisons; bars start from a common zero on each stat's own honest axis; the "today" bar sweeps to last year's mark, then grows with the counter so bar and number always agree; growth badges land on the spoken percentage.
- Ranges as a solid bar plus a hatched band; gaps as dashed outlines; goals as a fill. Financial need is calm and legible — sobering, not alarming.
- Bars and hatched fills as SVG with user-space patterns, grown by width (a scaled striped CSS background makes its stripes crawl).
- Counters are drawn from glyph outlines as a function of timeline time and reserve the width of their widest state; the build fails if any state overflows its box or overlaps a neighbouring label or unit.

## Sound

- Adaptive ducking: hold the score ≥13 dB (RMS) under the voice on every line (a static duck alone leaves some lines too close).
- Land cue B's final chord under the end card (stretch it with pitch kept, or delay its entry if no pitch-preserving stretch is available); lift the music ~9 dB once the last line ends.
- Minimal UI foley: ticks for list steps (pitch-stepped), soft sweeps for bars, blips for rings and badges, one whoosh per frame move, a soft air swell per section; soft swells under money figures (zips read as a cash register).

## Verify

- Proof images for every highlight rect; jitter measured on rings, bars and moving text.
- Step through every screenshot transition frame by frame in the final file.
- AI reviewers on this style misread counting numbers as typos and crossfades as overlaps; check music for vocals one excerpt at a time.
