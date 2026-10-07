# Style preset: lecture-look

A premium composited-lecture look made from a client's ordinary talk footage: a locked-off shot, the speaker matted out and set in front of a painted (or clean) set that a soft dry-brush and smoke edge reveals behind them, a slow 2.5D push, and typographic pull quotes timed word by word to what the speaker says. A footage-treatment service for speakers, teachers and preachers; sells as a single hero clip (45–90 s) or a short batch from one talk.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `script` | `as-is`: the speaker's own words |
| `voice` | `none` (the footage's own audio) |
| `music` | `none`; two very quiet synthesised air swells (the set reveal, a quote entry) are enough. A bed is optional, ducked far under the speech |
| `length` | 45–75 s per clip: one self-contained moment that starts cold on a hook and ends on a resolution |
| `formats` | `16:9`; `9:16` as a re-lay when the matte allows (see Formats) |

The resolution ceiling is the source's: 1080p masters from a 720p source carry 720p-class detail. Offer 4K only from a 4K source.

## Footage requirements (send this to the client before they shoot)

The look depends on the footage more than on anything done afterwards. Ask for:

1. **Tripod, locked off.** No zoom, pan or autofocus hunting during the talk. A static camera allows a clean plate and a difference key, which make the matte. Handheld footage can be rescued (see below), but never as well.
2. **Medium shot.** Waist or chest up, with the speaker filling 50–70% of the frame height and room at the sides for gestures. Not a wide room shot: a speaker smaller than about 400 px tall in 1080p mattes poorly.
3. **A plain wall behind the speaker,** 1.5–3 m behind them, in a mid-tone that differs from their clothes and skin (mid grey, beige or blue). No windows, no projector screen and nobody walking behind. Clear the wall of posters.
4. **Lighting.** Soft, even light on the speaker from the front or the side, and a little light on the wall. Avoid hard window light that blows out a white shirt: blown highlights bloom over the edge, which is the main giveaway of the composite. Ask the speaker not to wear pure white, fine checks or stripes (moiré), or green.
5. **Resolution and bitrate.** 4K if possible, 1080p minimum, at the camera's highest bitrate (at least 50 Mbps for 4K). A 720p, 1 Mbps source works for this look, but every edge is softer.
6. **Sound.** A lavalier mic on the speaker, recorded into the camera or a recorder, plus the room or desk mic as backup. A camera-only mic in a big room sounds distant.
7. **Release.** A signed release from the speaker (and from anyone else visible) that covers editing, compositing onto a new background, and the channels where the video will appear. Without one, everything is labelled INTERNAL TEST.
8. **Optional, but worth a lot:** 10 seconds of the empty set (the same framing, with the speaker out of shot) before or after the talk, which gives a perfect clean plate. If there's a lectern, leave it in place for those 10 seconds.

### Intake checklist (run it on every delivered file before quoting)

- [ ] Resolution, frame rate, bitrate (`ffprobe`), and the length of the talk.
- [ ] Locked off? Measure the drift of a static wall patch across the talk (phase correlation); more than 2 px means stabilise first.
- [ ] Speaker height in pixels at the chosen moments, and whether hands leave the frame.
- [ ] Wall: plain? its mid-tone against the shirt and skin? anything moving behind?
- [ ] Blown highlights on the speaker (a white shirt at 255) and where they touch the edge.
- [ ] Occluders: lectern, microphone stand, front-row heads. A static lectern takes a fixed mask. Moving foreground heads rule the look out for that shot.
- [ ] Audio: lav or room? Hum, HVAC noise, clipping?
- [ ] Release on file, and covering compositing.
- [ ] Run `hyperframes remove-background` on 10 s of the shot and look at the edge on a dark background at full size before quoting.

### When footage falls short

| Problem | What to do |
|---|---|
| Handheld or drifting camera | Custom lock-off: phase-correlation tracking of a static wall patch (Hann window) against frame 0, a σ = 2-frame Gaussian on the offsets, re-centred, with a 1.05x zoom to hide borders (generic stabilisers such as vidstab leave 0.3–0.4 px of jitter or a slow drift). Then key as usual (the clean plate needs the lock-off first). |
| No plain wall (a busy room) | Use the ML matte alone with the guided-filter and temporal refinement (no difference key), and pick a busier painted set with darker edges so the edge errors sink. Or use the break-in variant (next row). |
| Speaker too small (phone, wide room) | Don't composite the whole figure. Use the **break-in variant**: keep the real room, paint only across the top of the frame above the speaker's head behind a ragged brush edge, and put the quote over the painting. It needs no matte. |
| Blown white shirt | Expect a 1–2 px bright rim. Choke the bright edges harder (the bright-edge gamma below) and keep the set dark around the shoulders; the light wrap blends what remains. Say so in the brief. |
| 720p or low bitrate | Upscale the speaker 1.5x (recipe under Matte), keep the push under about 1.06, and offer 1080p only. |
| Lectern or other static prop | Make a fixed mask from the clean plate (colour threshold below the lectern's top edge, the largest component), then trim wall-coloured pixels (low saturation, mid grey) and fill row by row, not column by column: a column fill copies the capital's width down over an inset column and base, and grey wall shows beside them. Merge it into the alpha. |
| No release | Internal test only. Don't put it in a portfolio. |

## Selecting the moment

- Transcribe the talk locally (text only) and read the whole transcript. Pick a 45–75 s moment that starts cold (no "as I said"), ends on a resolution line, and contains one or two lines worth a pull quote: a passage read aloud, a definition, a crisp phrase.
- Find the in and out points from the forced alignment plus an RMS envelope; transcript word times can be off by over a second around a pause. Cut in room tone (0.15–0.25 s before the first phoneme, 0.3–0.5 s after the last), quantise to the source frame grid, and use 15 ms fades.
- Settle disputed words by forced alignment (compare total log-likelihood of the span) and a spectrogram. Speech-to-text drops repetitions ("There's, there's") and loses words at the edges of a cue.

## Look

- **Composite stack (back to front):** the real plate (visible only until the reveal covers it) → a dark warm smoke band masked by a soft fringe → the painted set masked by a dry-brush edge → the speaker layer (VP9 with alpha) → vignette → quotes. The set and the speaker sit in separate camera groups.
- **Set:** a generated painted place with no people, figures, statues or faces, and no text; places and objects only. It should be darker than the speaker, with its brightest light coming from the same side as the speaker's key light, and a vanishing point or calm wall behind the head. Dark, deep and warm (e.g. a library hall) reads best behind a lit speaker; for the break-in variant, a painterly look suits. Show it slightly soft (`blur(1.1px)`, brightness 0.9) like a background out of focus, and darken the quote area with a radial scrim inside the set layer. Generate a native 9:16 version with the 16:9 as a reference image, for consistency.
- **Speaker grade:** warm it slightly toward the set and roll off the whites (knee at 200, shoulder 0.6), ramped in with the reveal, so that before the reveal the speaker still matches the real plate.
- **Quotes:** an italic book serif (e.g. EB Garamond italic), 60–80 px, cream (#f4ecdc) with a soft shadow, left-aligned in the open wall beside the speaker, kept clear of the speaker's actual extent during the quote window (the alpha's bounding box per window). Attribution: a short gold rule, a small-caps reference, and an italic line (the translation, or how the line was framed: "as quoted in the talk"). The build asserts quoted text matches its source and speaker lines match what was spoken. One or two quotes per minute; more becomes a caption track.
- **Thumbnail:** a composited frame (speaker on the set, eyes open, mouth neutral) with the strongest pull quote in the quote type.

## Motion

- **Reveal:** at the start (within the first second, while the speaker's first words land), a ragged dry-brush edge with a smoke fringe sweeps top to bottom over 1.75–1.9 s (`power2.inOut`) and keeps travelling until the mask's lowest ragged row is below the frame. Both masks drift sideways at different rates for the whole clip. Make masks tall (2400 × 3600, edge at row 2400): shorter masks (edge at 1200) leave the top rows of the set transparent once the edge passes the frame bottom. The set settles from scale 1.05 to 1.0 under the reveal.
- **Brush edge:** give it enough large-scale raggedness or a tilt of a few degrees; a 55 px amplitude reads as a rigid horizontal band at 720p.
- **Push:** a slow 2.5D push across the whole clip: the speaker group scales 1.00 → 1.06 and drifts 36 px; the set scales 1.00 → 1.03 and drifts half as far (parallax), both about the bottom centre (the lectern stays planted). Don't push past about 1.06 on a 720p source. At 1.03 vs 1.06 the baked light wrap's slight misalignment by the end of the push doesn't show.
- **Quote words:** opacity plus an 8 px blur over 0.3 s, fully visible at the agent's word-reveal lead. The type layer never moves or scales, so live text stays rigid. The attribution fades in after the last word, holds ≥ 3 s, then the quote fades out over 0.7 s.
- **End:** a 0.45 s fade to black on the last syllable's tail, with the audio ending in room tone.

## Matte and stabilisation

1. **ML matte:** `hyperframes remove-background --quality best` on the locked-off segment (about 87 ms/frame at 720p). The raw matte has a soft white halo where a bright shirt blooms over the wall, misses the lectern, and swallows patches of wall between the arms and the body.
2. **Stage 1 refine (source resolution):**
   - **Clean plate:** the per-pixel median of every 12th frame where the dilated ML matte says the speaker is absent. Fill wall that is never seen (behind the torso) with a cubic surface fitted to the seen wall; inpainting smears the lectern's colour up into the wall and the difference key then keeps a brown triangle.
   - **Trimap band:** core = the ML matte eroded 14 px, reach = dilated 14 px. In the band, a **difference key** against the clean plate (max channel |I − B|, ramp 9 → 34 levels).
   - **Shadow suppression:** pixels darker than the plate (L < 0.93·L_B) with the same chroma (< 7%) are wall in the speaker's shadow. Remove them in the band, and in the core when they form blobs over 600 px after a 5 px opening (so a lanyard and mic stand stay). The core pass is needed because the ML matte swallows the shadowed wall between arm and torso.
   - **Guided filter** (r 3, eps 2e-4, the frame's luma as guide) snaps the alpha to real edges.
   - **Temporal 3-tap median** of the alpha wherever the image is still (frame difference < 6 levels), which stops edge boil without smearing moving hands.
   - **Choke:** a smoothstep levels curve (0.18 → 0.92).
   - **Lectern:** the fixed mask from the clean plate, merged in.
   - **Colour unmixing:** F = (I − (1 − α)B) / α (α clamped at 0.3), which removes the grey wall and the bloom tint from edge pixels. This is the main fix for the white-shirt tell.
3. **Stage 2 (output resolution):** edge extension (normalised convolution, so nothing garbage bleeds into the SR or the 4:2:0 chroma); a 1.5x upscale (a compact Real-ESRGAN model, e.g. `realesr-general-x4v3`, on the speaker crop, area-downscaled, blended 60/40 with Lanczos); a **bright-edge choke** (α^2.6 on edge pixels brighter than 205); a **light wrap** (about 20–22% of the blurred set mixed into a 2.5 px inner edge band; at 5 px / 42% it draws a peach outline around a white shirt); the warm grade; and a VP9 yuva420p encode (CRF 16). Expect a few fps on a laptop (about 13 min for 61 s).

Expected result on a 720p source: no white halo on the head, glasses or ear wire; a faint 1 px darker line on a blown shirt edge at 2x zoom; the lectern solid; the wall between arm and body removed in most frames. Fast hand gestures keep motion-blurred edges with some wall colour in them.

## Formats

- **9:16:** place the 1080p speaker layer unscaled (fg box −420, 840 in a 1080 × 1920 frame): the lectern spans the width, the face sits at about y 1290, and wide gestures leave the frame. Quotes go in the open space above (y 330–800, x 84–1000). Before the reveal, extend the real wall upward from the clean plate's top rows with a gentle falloff, so frame one is the real room. Rebuild stage 2 per format so the light wrap is baked against that format's set.
- **1:1:** the same approach: fg box scaled so the lectern fits the width, quotes above.
- A re-lay is allowed when the speaker is at least about 900 px tall in the output without further upscaling, and the face sits inside the format's safe area.

## Sound

- The footage's own speech: `highpass=85`, `afftdn=nr=10:nf=-44`, −2.5 dB at 250 Hz, +2 dB at 3.2 kHz, `deesser`, `acompressor` 2.5:1 at −22 dB, then the loudness master with an `alimiter` at 0.83.
- A very quiet synthesised air swell (brownish noise through a sweeping band-pass, about −30 dBFS peak) under the reveal, and a darker, falling one (−33 dBFS) under a later quote's entry, so no two sound alike. No foley per word: it would fight the speech.

## Verify

- Matte, at full size, frame by frame through the fastest gestures: hands, the head and hair, the shirt edge against the darkest part of the set, the gap between the arm and the body, the lectern's top edge, the mic stand and lanyard. Compare against the raw matte on the same frames (a side-by-side crop sheet).
- The reveal: step through it frame by frame. No plate edges show, the set ends fully unmasked, and the speaker's grade doesn't jump.
- Quote timing: check the first word against the RMS onset too (the aligner can place a short first word like "I" ~140 ms late).
- Text clearance: the quote box against the speaker's alpha bounding box in that window, through the push.
- Sets audited at full size for stray figures, faces or text.
- Permission: without a signed release from the speaker (and the host), label everything INTERNAL TEST.

## Pitfalls

- Running two heavy jobs at once (a matte stage and a render) can kill one silently. Log each stage to a file and check the frame count of every output (`ffprobe -count_packets`).
- zsh: avoid one-letter helper function names (e.g. `g`); they collide with common aliases.

## Limits

- Untested with 1080p or 4K sources, a lav-mic source, a speaker without a lectern, hair longer than a crew cut, handheld footage end to end, two speakers, a music bed, and more than one set change per clip.
