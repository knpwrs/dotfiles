# Style preset: watercolor

A gentle, hand-painted watercolor film on warm cotton paper: soft sky washes, misty hills, foliage in the corners, drifting leaves, friendly hand-lettered type, and painted data (bars, lines, counters) that looks brushed onto the page. Warm and calm, for community updates, nature and science explainers, wellness, education and small-brand stories. Developed by building two films (`videos/samples/watercolor-first-month`, `videos/samples/watercolor-water-cycle`); the bake-off, textures and engine live there.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition for a warm, unhurried narrator (previous winners: Gemini 3.8 Flash TTS `Sulafat` for a warm community/brand voice, `Algieba` for a patient teacher; include both). Direction e.g. "Warm, friendly, gently upbeat … sincere, conversational, unhurried, never salesy; declarative sentences end with firm, falling intonation." A slow teacher voice can take `atempo` 1.1–1.15 in the VO build |
| `music` | warm acoustic, felt piano, light strings (guitar, celesta, marimba/harp for water topics), gently upbeat, 84–96 BPM, no vocals; one continuous cue that starts on beat one and ends on a resolved chord (Lyria 3 Pro has hit the length within a few seconds when the prompt states it) |
| `length` | 60–75 s |
| `formats` | 16:9 + 9:16 (both laid out natively) |
| `thumbnail` | a frozen, fully built moment of the film (the settled chart, or the finished diagram) under the film's hand-lettered title and brush underline |

## Look

- **Palette** (from the client reference): paper cream `#F6EEDC`; ink slate `#3E4868` for type, muted `#69718F` for subtitles and axis labels; sky cerulean and butter-yellow washes; sage/olive foliage; periwinkle `#6872D6` for data washes; honey gold `#A7843A` for tags and highlights. Brand colours replace the data and accent colours; the paper, ink and landscape stay.
- **Layers, back to front:** paper (fixed) → sky washes (depth 0.35) → hills (0.6) → drifting leaves (0.9) → content → foreground foliage corners (1.25: a hanging branch top-right, a flowering clump bottom-left, a low bush bottom-right). The camera is a slow per-beat offset (≤ 60 px, eased over 2.4 s at beat changes) plus a ±10 px sine drift; each layer moves by `cam × depth`. Keep content clear of the corners (branch ≤ 420 px wide at 1080p; nothing in the top-right 480×420).
- **Paper is procedural, not generated:** a native-4K cold-press sheet from band-limited noise (tooth ~9 px at 4K lit from the upper left, cockle, felt mottling, faint fibres), seeded. It carries all the high-frequency detail, so the painted washes above it (soft, low-frequency) can be upscaled without looking soft.
- **Art model:** OpenAI `gpt-image-2.5-sunburst` won the bake-off (see below). Skies: opaque full-frame paintings ("sky washes strongest upper right, bottom third bare paper, no hills"), then colour-to-alpha against the painting's **own** paper tone (median of its bare bottom band, not the 99th-percentile white, or the paper tint becomes a yellow haze over your paper) with a soft alpha floor. Hills, foliage, props: native transparent cutouts ("ONLY ONE OBJECT … isolated on a fully transparent background, no paper, no shadow"); several small leaves in one image split by connected components. Pass an earlier layer as `input_references` so every layer shares the brush and palette.
- **Resolution:** the model returns 1536 px max. Large layers (skies, hills, foliage, landscape bands) get Real-ESRGAN ×4 → ×2, blended 60/40 with Lanczos ×2 (keeps granulation); the browser covers the last ≤1.25× at 4K. Cutouts shown ≤ ~500 px at 1080p stay native.
- **Type:** Gaegu (SIL OFL) 700 for titles and labels, 400 for subtitles/axes: the closest free match to the reference's friendly rounded hand lettering (Patrick Hand is the runner-up; Caveat and Kalam read too cursive). Latin subset lacks en dash and middle dot: use "-" and "|". All text is SVG glyph outlines (fontTools + HarfBuzz → `glyphs.json`), so it is rigid under drift and rises.
- **Brush underlines:** a procedural dry-brush stroke (broad soft band, ragged wavy edges, low-frequency bristle streaks, pooled darker edges, loaded start, dry broken tail), in pale blue/gold/sage, painted on with the bloom mask left to right (0.8–0.9 s).
- **Labels over busy painting** sit on a soft cream glaze (blurred rounded rect in the `cream` wash, 0.82) that blooms in just before the text.

## Motion

- **Everything is a function of timeline time.** One paused GSAP timeline holds a single linear clock tween on an **accessor property**; its setter runs every updater (`render(t)`). Never use `onUpdate` for this: `TL.seek()` suppresses callbacks by default, so thumbnails and audits silently skip frames. No free-running loops; leaves, sway, rain and drift are closed-form in `t` with seeded constants. Thumbnails freeze the clock at one moment (`clock(TL, total, freezeT)`), since the snapshot tool seeks on its own.
- **Bloom reveals (never a hard wipe):** each element sits in an untransformed wrapper `<g>` masked by an alpha `<mask>` whose image is a pre-rendered **bloom field** (fbm-perturbed distance: `radial`, `lr`, `bu`, `dot`, plus 4:1 `lrw`/`buw` variants chosen automatically for wide boxes — a square field stretched onto a wide text line turns into horizontal streaks). An `feComponentTransfer` thresholds it: `feFuncA slope = 1/soft`, `intercept = (p·(1+soft) − 1)/soft`, `soft` 0.16–0.3. Remove the mask when complete. The mask must go on an untransformed wrapper: `maskUnits="userSpaceOnUse"` is the referencing element's own space, so a mask on a scaled glyph group lands in font units and hides the text until the bloom ends.
- **Opening:** sky blooms radially from the upper right (0.15–2.4 s), hills bloom left to right, foliage blooms up from the frame edges; the first line starts ~1.7 s.
- **Beats:** each beat blooms in on its own words and fades out (0.7 s) 0.95 s before the next beat's first line; the landscape stays. Word-synced reveals (value labels, specimen blooms, subtitle words) land 0–80 ms before the word; titles may bloom ahead of their words.
- **Parallax/sway:** branch rotates ±1.1° about its attach point (6.3 s + 2.7 s sines); flowers sway ±0.5°. Leaves: seeded paths from the upper right (x ≈ 0.6–0.9 W), ~30–50 px/s left, flutter via `scaleX = 0.3 + 0.7|cos|`, and faded out below ~40 % of the frame height so they never cross labels.
- **Diagram films:** one continuous painted landscape band (feathered edges with smoothly upsampled noise; blocky `np.kron` noise shows as a stepped edge), with the diagram accumulating beat by beat: wavy vapour arrows drawn on, droplet dots blooming, a cloud blooming and drifting, rain streaks and snow as closed-form falling marks, a river arrow along measured landscape coordinates (`M(nx, ny)`), then labels dimming to 0.5 as the next beat begins. For a chart beat, dim the painting to ~0.28 instead of cutting away.

## Data

- **Painted bars (the signature):** SVG, never CSS backgrounds. Each bar is a clip path of a wobbly bar outline (side wobble is a function of the page y, so it doesn't crawl as the bar grows) holding a rect filled with a `patternUnits="userSpaceOnUse"` wash texture (procedural pigment density: pooling + flocculation + faint granulation, 1024 px), a darker dried rim (the same outline stroked 4–7 px, blurred, clipped inside so only the inner half shows), and a pale blurred "wet bead" at the leading edge. It grows by geometry (the outline's length) with `power3.out`; after it lands the bead fades and the rim darkens over 0.7 s ("drying"). Alternate two wash colourways and vary opacity 0.84–1.0 bar to bar. Measured shimmer on settled bars: 0.06–0.09 mean |Δ| per frame, below the drifting sky behind them (0.15).
- **Honesty:** bars start at zero on a labelled axis with round ticks (0/250/500/750/1,000); a visible "Sample data" tag (gold wash label) or a source line on every chart; percentages as "about …" and "Figures rounded." with the source named on screen. Values named in the narration get labels; the one that grows while spoken gets a counter riding its top that is computed from the same eased progress as the bar, so bar and number always agree.
- **Axes:** hand-drawn pencil lines (seeded wobble, static `feTurbulence` grain + displacement filter, never re-seeded) drawn on with `pathLength=1` dash offset; ticks and tick labels bloom with the `dot` field in a quick stagger; weekly date labels (e.g. every Saturday) read better than every-third-day.
- **Painted line chart:** a textured stroke (`stroke` = wash pattern, 12–13 px) over a blurred darker edge stroke, drawn on by dash offset over the true path length; a pale glaze of the area under it blooms left to right on the same clock; the counter reads the value at the tip, so the line and the big number agree and land on the exact total.
- **Stacked horizontal bars** for shares of a whole (e.g. oceans / other salty / fresh), with pencil "zoom" lines from a sliver to a second full-width bar that breaks it down. Label segments above the bar (icon + name + %), tiny segments below-right in the muted colour.
- Every figure comes from a data file (`data.json` generated in code, or `figures.json` from the source) injected by the build; the build fails if a named figure appears as a literal in `film.js`.

## Sound

- Soft, organic, synthesised foley ($0, deterministic): `wash` (filtered swell under blooms), `brush` (dry brush drag under underlines and wide bars), `pencil` (graphite under axes), `plink` (kalimba-like pluck, pitch-stepped ~1.5 semitones every third bar in a sweep), `chime` (celesta bell for peaks, finds and the end), `rustle` (paper at beat changes), plus `drop`, `rain`, `air` and `sparkle` for water topics. Round-robin variants with small seeded pitch nudges; felt more than heard (gains 0.07–0.3 of full scale).
- Music ducked from the VO windows plus adaptive ducking to hold ≥ 13 dB under every line; lift ~5 dB after the last line so the final chord rings out; two-pass loudnorm to −14 LUFS / −1.5 dBTP.

## Verify

- Build-time audit (`gen/audit.py`): at each text element's fully revealed moment it must be visible, unmasked, inside the frame (and the 9:16 safe area x 60–960, y 250–1560), and hold ≥ 0.6 s before its beat fades.
- Frames from the final file: every beat settled **and** mid-bloom; step through a title bloom every 3rd frame (the wet edge should advance smoothly, with no streaks, and letters should never be hidden mid-bloom); a bar sweep and the peak bar mid-growth (counter riding the top); the line chart mid-draw.
- Jitter (`gen/jitter.py`): mean |Δ| per frame inside settled bars, counters and headings should sit at or below the background-drift floor.
- AI video reviewers read mid-bloom text as "truncated", counters as "jumping", and leaves as "stray artifacts". Verify each one on frames; the real finds were a leaf crossing a label and a glaze whose rectangle showed after its mask was removed (use soft-edged shapes such as radial-gradient ellipses for glazes, never a plain rect).

## Bake-off record (Sep 2026)

| Job | Winner | Others | Result |
|---|---|---|---|
| Full-frame sky/landscape wash | gpt-image-2.5-sunburst ($0.045) | gpt-image-2 (as good, 3× the price); gemini-3.1-flash-image 2K (copied the reference chart and its text; without a reference: muddier, greener); flux.2-pro (heavy paper, muddy palette); seedream-5-0-pro 2K (too faint) | closest to the reference palette and soft wet edges; returns 1536 px only (a `resolution` of 4K is ignored) |
| Transparent cutouts | gpt-image-2.5-sunburst (native alpha, ~$0.05–0.06) | gpt-image-2 (no transparency); flux.2-pro on white + colour-to-alpha (glaze-like but holes in the leaves) | clean alpha, consistent brush across layers with a reference |
| Sky as a transparent cutout | rejected | — | paints a floating "sky island" blob; use an opaque painting + colour-to-alpha instead |
| Paper | procedural native 4K | model paper (1536 px, needs 2.5×) | sharper at 4K, free, seeded |
