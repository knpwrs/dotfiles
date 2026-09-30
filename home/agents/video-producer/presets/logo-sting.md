# Style preset: logo-sting

A short logo reveal: 3–10 s intro, outro or bumper built around the client's official logo, delivered in several variants and formats. An entry product and upsell path; usually a batch of 3 variants from one brief.

*Proven once (Let's Church, 2026-09: `videos/lets-church-logo-sting`, a wordmark-only logo, all three variants, 16:9 + 1:1 + 9:16 + ProRes 4444 alpha, pixel-exact settle). Not yet tried: a logo with a separate mark/symbol, a raster-only logo, a multi-colour logo, a spoken tagline, a music-model sting that beats synthesis.*

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | `none` (an optional spoken tagline on request) |
| `music` | a custom sting: a short designed hit or motif (1–4 s) that resolves exactly as the logo settles; no vocals. Local synthesis is the proven default (frame-exact, clean tail, free); run a small music-model bake-off only if the brief wants a produced/orchestral sound |
| `length` | 4–5 s (intro) with a hold ≥ 2 s, so the same file also works as an outro; up to 10 s for a hero reveal |
| `formats` | `16:9`, `9:16`, `1:1`; plus a version on a transparent background (ProRes 4444 or WebM with alpha) for editors |
| `render` | 720p proxies of every target first (`--quality draft`), then 1080p masters (`--quality high --crf 12`) |
| `thumbnail` | the settled logo frame |

## Logo rules

- Official vector logo files only (SVG/AI/PDF from the client or their site); never redraw, recolour outside the brand palette, stretch, or separate mark from wordmark unless the brand guide allows it. The groups inside the file (lines, mark, wordmark) are the only parts a variant may move independently.
- Copy the file into `assets/` byte for byte (`cmp` it) and have the build **read the path data out of the file**; never retype or re-export it.
- Keep the brand's clear space and minimum size; the settled frame must match the logo exactly.

## Build pattern (proven)

- **Measure first:** load the SVG in Chromium and record every path's `getBBox()` and `getTotalLength()`, each group's bbox and the ink bbox (`gen/geometry.json`). Everything (clip lines, landing points, origins, sheet and tape sizes) derives from these numbers.
- **Place by the ink, not the viewBox:** centre the measured ink bounds in the frame; snap the box origin to multiples of 3 CSS px so it lands on whole pixels at 720p (zoom 2/3), 1080p and 4K. Proven sizes: 16:9 840 px box (ink ≈ 40 % of width); 1:1 720 px (≈ 61 %); 9:16 840 px (ink inside x 60–960, centred at y 960). Author motion in logo units so each format re-lays by changing only the box.
- **Exact settle by swap:** animate inline copies of the paths; on the hit frame hide them and show the official file as an `<img>` at the box. The hold is then the file itself, with no residual transform, blur or filter possible. A `--ref` build (ground + the `<img>` only) is the reference for the pixel check.
- **One project per target:** HyperFrames lint rejects several root compositions in one folder (`multiple_root_compositions`), so build each variant/format into `build/<target>/index.html` with `assets/` symlinked to the shared assets, and render with `hyperframes render build/<target>`.
- **One timing file** (`gen/timing.json`) read by both the animation and the sound script, so every sound lands on its visual event by construction.

## Variants (offer three per brief)

1. **Clean:** each path's outline draws on (`stroke-dashoffset` over its own measured length, in the file's path order, staggered glyph by glyph; stroke ≈ 4 logo units so it survives a 720p proxy), then the fill floods in as the outline fades, completing on the hit (start the fill while the last outlines are finishing, or the reveal stalls); separate lines/parts drift apart and close into the lockup with an in-out ease that arrives on the hit.
2. **Kinetic:** pieces from the logo's own geometry on a beat grid (e.g. 120 BPM 16ths): letters rise out of their measured baseline or drop through their measured cap line (clipPaths from the bboxes), lines slide together and interlock on the hit, one small piece (an apostrophe, a dot, a spark in the mark) lands last on the lock; a sheen masked to the letterforms as the light flash, finished before the hold. Keep overshoot modest (back.out ≤ 1.2) and spins small for sober brands. Start any off-screen piece from a position computed from the frame edge and keep it hidden until its move, or it peeks in at the top of the frame.
3. **Textured:** in another preset's look (paper collage, watercolor bloom, isometric build) to match a video series. Proven: paper collage from the paper-collage kit (indigo paper ground + grain, cream torn sheet sized from the ink box, kit tape on the corners, the logo's groups as cut-paper pieces dropped on twos with lift shadows and 8 fps jitter, pressed flat and straightened on the hit). The logo stays flat brand colour during the hold (texture never goes on the logo); keep grain and vignette under the paper layers.

## Motion

- The logo settles on the sting's resolving hit and holds ≥ 1 s (outros ≥ 2 s) so editors can cut; a hold of ≥ 2 s lets one file serve both.
- Motion from the logo's own geometry (its paths, angles and counters), measured from the SVG; no generic particle bursts unless requested.
- Sub-frame-accurate: the settled logo is a static, exact copy (no residual scale or blur) for the whole hold.
- Parallel-render safe: explicit `fromTo`/`set` values, and `tl.progress(1).progress(0)` before registering the timeline.

## Sound

- A designed sting mixed to −14 LUFS short-term (the loudest 3 s window, which should be the one around the hit) with a clean tail (cosine fade to digital silence by the last frame); also deliver a silent version (`-an -c:v copy`).
- Proven synthesis kit (`videos/lets-church-logo-sting/gen/sting.py`): felt piano (inharmonic partials, double strings), glockenspiel and celesta (bar ratios), marimba, Karplus-Strong pizzicato with body modes, detuned-saw pad, a reversed copy of the hit chord swelling into the hit, STFT band-sweep risers, synthesised paper foley (crisp crack + fibre crackle, no sub thump; tape = adhesive crackle + tack), stereo STFT-shaped reverb. Master with a high shelf (+1.5–4 dB at 2.8 kHz) and a small 260 Hz dip for "warm and bright", then a 4x-oversampled lookahead limiter. Pitch-step like events 2–3 semitones up the scale.
- Limit the WAV to −2.2 dBTP: AAC encoding adds up to ~0.9 dB of true peak (the renderer's AAC took one sting from −1.7 to −1.3 dBTP). Measure the rendered files, and remux the mastered WAV with `-c:v copy` (AAC 320k) as standard practice.
- Music models (Lyria clip/pro) return 20–30 s through-composed cues, not stings; an excerpt needs a mid-phrase fade and its hit is not frame-placeable. Use one only when the brief wants that sound, and align the animation's hit to the take's measured onset.

## Deliverables and colour

- H.264 masters: 8-bit 4:2:0 BT.709 cannot carry the brand colour exactly (flat #6366F1 decodes as 97,101,238 even from a direct ffmpeg encode; edges carry chroma-subsampling error). Report this; the exactness proof is on lossless frames.
- Transparent master: `render --format mov` gives ProRes 4444 12-bit with alpha but a **BT.601 matrix and no colour tags**; NLEs assume BT.709 for HD and shift the colour. Re-encode BT.601 → BT.709 with `prores_ks -profile:v 4444 -alpha_bits 16`, then stream-copy remux with `-color_primaries bt709 -color_trc bt709 -colorspace bt709 -movflags +write_colr` (prores_ks alone does not write the tags). Ship the sting WAV alongside for editors.
- A sequential "all variants" review clip with burned-in labels (labels only in the review clip).

## Verify

- **Pixel for pixel:** HyperFrames snapshots (lossless PNG) at the start, middle and end of the hold vs the `--ref` page at the same size must differ in 0 pixels; also compare with an independent rasteriser (`rsvg-convert`, same size and offset; expect ink-mask IoU ≈ 0.99 with differences only on anti-aliased edges). On the final H.264 file report PSNR and split the error into interior / background / edge band. Textured: every pixel the SVG covers fully must be exactly the brand colour.
- **Hold stillness:** frame-to-frame difference inside the logo box across the hold in the final file (≤ 4 levels at crf 12).
- **Alpha:** composite on black and white at several moments; in the settled frame alpha is 0 outside and 255 inside, and opaque pixels decode (BT.709) to the brand colour.
- **Timing:** onset detection on the rendered file's audio vs the timeline's hit, and cross-correlation against the source WAV (lag should be 0).
- **AI reviewers:** single-file calls only; they misplace timestamps by up to a second and invent sync errors, hiss and "sheen", so confirm every finding with onsets, spectra or frames before acting. Their foley and "too cartoonish" notes were worth acting on.
