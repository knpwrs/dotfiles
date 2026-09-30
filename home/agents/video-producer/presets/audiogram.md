# Style preset: audiogram

A podcast or sermon audio clip turned into a shareable video: the show's cover art, a live spectrum driven by the audio,
word-by-word captions, and the episode title. For weekly, repeatable clips; usually ordered in batches.

*Proven once (Sep 2026: 2 sermon clips × 1:1 + 9:16, `videos/samples/audiogram-test/`, $0.06 of spend). Not yet tried:
16:9, two-speaker podcasts (speaker labels / turn colours), music beds, a supplied official cover file.* That project is the
reference implementation: `gen/cut.py`, `align.py`, `analyze.py`, `build.py`, `src/film.js`, `verify_sync.py` and
`verify_captions.py` can be copied and re-pointed.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `script` | `as-is`: the speaker's own words (false starts and repeated words stay in the captions) |
| `voice` | `none` (the source audio) |
| `music` | `none` (the episode's own audio); an optional quiet bed only under intros |
| `length` | 30–90 s per clip |
| `formats` | `1:1` and `9:16` (each re-laid), `16:9` on request |
| `thumbnail` | a cover frame per clip per format: the layout with the hook line in the caption style, one key word on the pill, bars frozen on a loud frame, no progress bar (1080-wide JPG + 2160-wide PNG) |
| `render` | proxies at 720 wide (`--quality draft`), masters at 1080 wide (`--quality high --crf 12`) |

## Selecting clips

- Transcribe the whole source locally for the text only (Whisper medium.en is fast enough: ~20 min for a 47-min talk on an
  M-series CPU), pick self-contained moments (a claim and its payoff line; Scripture read aloud plus the speaker's point makes
  a strong audiogram), then re-transcribe each clip range with Whisper large-v3.
- **Verify the text before aligning.** large-v3 still invents short phrases in pauses (a "There's a limit." that was never
  said) and mishears function words ("And" / "In"). Wherever the models disagree, cut a 2–5 s excerpt and ask two audio
  models (e.g. Gemini Flash and Qwen Omni via OpenRouter, ~$0.002 each) for a verbatim transcript "including false starts,
  repeated words and fillers", and "numbers written as spoken" for references (this gives the spoken form to align).
- Cut on pauses checked on an energy envelope (20–50 ms RMS), not on Whisper segment times: the start must clear the tail
  of the previous word. Asking an audio model "does this start/end with a partial word?" about the first and last 1.2 s is a
  good second check. Record source timecodes in `BRIEF.md`.
- Tightening long pauses (> 2 s) between sentences inside a clip (40 ms crossfades in room tone) reads much better on social.
  It is an edit inside the clip, so list each one in `BRIEF.md`, and keep a pause that is itself the beat (a joke's silence).

## Timing (forced alignment)

- torchaudio `MMS_FA` with `get_model(with_star=True)` / `get_dict(star="*")`, and a `*` token at both ends and after every
  punctuated word. Without the wildcards, long pauses, page turns and room noise pulled the CTC path and whole phrases scored
  ~0 with smeared spans. Scores stay low on reverberant or emphatic reading (Scripture references often score < 0.05) even
  when the times are right, so judge by independent checks, not by the score:
  - every word span contains speech energy (≥ 12 dB over the clip's pause floor);
  - every word after a pause starts where the energy rises out of it (a rise from < floor+8 to ≥ floor+14 dB, the one
    nearest the aligned start). Expect a median offset within ±10 ms.
- Whisper word times were 0.3–0.6 s early after pauses. Never use them, not even as a fallback.
- Display vs spoken tokens: `119:89{one hundred nineteen eighty-nine}.` shows "119:89." and aligns the spoken words. Keep the
  trailing punctuation on the display token so the wildcard follows it.
- Align the **final cleaned clip audio** (after the cuts), so the times are exactly what plays.

## Sound

- Chain: high-pass 85 Hz, `afftdn=nr=8:nf=-48:tn=1`, `deesser`, −1.5 dB at 250 Hz and +1.5 dB at 3.2 kHz, `acompressor`
  3:1 at −22 dB, then a **measured linear gain** to −14 LUFS and an `alimiter` guard at −2 dBFS (true peak lands at −1.9 to
  −2.0 dBTP). Two-pass `loudnorm` fell back to dynamic mode on speech with pauses (pumping), so don't use it for speech clips.
- Make the stereo (dual mono) before measuring: a mono file normalised to −14 plays at −11 once it is panned to two channels.
- Fades 0.05–0.1 s in (the first word is usually right there), 0.35–0.6 s out.
- After rendering, remux the mastered WAV onto the picture (`-map 0:v -map 1:a -c:v copy -c:a aac -b:a 320k`) and measure the
  file itself.

## Look

- The show's cover art (official file) large and sharp. With no official art, draw a clearly placeholder identity in code
  (SVG mark + wordmark, "SAMPLE SHOW" on the cover, a "SAMPLE PROJECT" pill in a frame corner). Use the show's colours for
  the background (a soft radial gradient plus a static seeded grain tile at 7 % soft-light) and one accent.
- **Audio visual:** a mirrored bar spectrum (64 bars = 32 bands × 2, lowest bands at the centre, rounded bars growing up and
  down from a faint axis, a horizontal gradient from the accent at the centre to a muted tone at the ends), plus two soft
  glows (behind the cover and behind the bars) whose opacity follows the RMS. Computed offline from the clip's final audio
  (`analyze.py`): per video frame, a 2048-sample Hann FFT centred on the frame's midpoint; 32 log bands from **150 Hz** to
  7.5 kHz (starting at 90 Hz, the lowest bands, which hold a male voice's fundamental under the high-pass, sat dead in the
  middle half the time); a per-band floor at the 35th percentile + 3 dB and a ceiling of 80 % per-band p98 + 20 % global p98
  (a global-only ceiling flattened the lows); gamma 1.25; a 3-tap blur across bands; a fast attack (0.75 of the rise per
  frame) and a 130 ms release. Stored as integers 0–1000 in `gen/viz/<clip>.json`.
- **Seek-safe drawing:** the timeline's own `onUpdate` draws frame `floor(t·30 + 1e-4)` by setting each bar's `y`/`height`
  (the runtime seeks with events on). A zero-motion tween spanning the clip keeps the timeline as long as the audio. No
  per-frame `tl.call` is needed.
- **Captions:** 2–6 words per card, chosen by a small DP over each run between sentence ends and pauses > 0.8 s. Cards of
  3–5 words cost nothing; a 1-word card costs +6; 2 or 6 words carry small penalties; a pause > 0.42 s inside a card +2.5; a
  break not at a comma +1 (−0.6 if it falls on a pause); a card ending on a function word +0.9; splitting a possessive
  ("God's / Word") or "one another" +2; a card on screen for < 0.8 s +1.5 to +5.5 (fast passages otherwise produce 1-frame
  cards). One or two balanced lines.
  - Figtree 800 at 60 px (1:1) / 66 px (9:16). Every glyph is a pre-outlined path (HarfBuzz advances + kerning), laid out
    from the glyph metrics with no DOM text at all, with typographic apostrophes.
  - Upcoming words in cream at 55 % opacity (42 % was flagged as unreadable), spoken words in cream, the current word in ink
    on a gold rounded pill (height 1.12 em, 12 px side padding).
  - The pill arrives LEAD = 50 ms before the word is spoken. Within a line it slides from the previous word over ≤ 90 ms,
    never before 60 % of the previous word's slot has passed, so each word keeps the pill for most of its slot; across lines
    it jumps. The word it leaves turns cream as the slide starts and the word it reaches turns ink as it arrives, so ink
    text is never left without its pill.
  - Card swaps are **sequential**, not cross-faded (a cross-fade read as ghosted double text). With `d = min(0.14 s, 40 % of
    the gap between the two words' light-ups)`, the old card fades out over the first 40 % of `d` and the new one fades in
    (with an 8 px rise) over the rest, fully in when its first word lights. The first card is on screen from t = 0.
- **Scripture:** a small chip ("Psalm 119:13 · BSB") above the captions, from the passage's reference until 1.2 s after its
  last word. Label it "· BSB" only when the speaker quotes verbatim, and make the build fail if those captions differ from
  the BSB text. When the speaker adapts a verse (e.g. says "Yahweh" for "the LORD", adds a phrase), caption what is said and
  drop the translation label. Inside quotations, captions keep the BSB's capitalised divine pronouns.
- Episode title (in a serif), show name (tracked caps in the accent) and speaker line: small and consistent.

## Layout (authored in CSS px; render size from the `#z` zoom)

- **1:1 (1080×1080):** cover 232 px at (72, 72) with show, title and speaker to its right (x 336, max 672 wide); bars centred
  at y 536 (half-height 118, x 72–1008); chip at y 690; captions centred at y 808; progress bar at y 966; corner label at
  bottom-right, y 994. Keep a 72 px margin.
- **9:16 (1080×1920):** everything inside x 60–960, y 250–1560 (platform UI covers the rest): label at top-right, y 262;
  cover 500 px at y 330; show, title and speaker centred under it (916–1070); bars at y 1210 (half 88, x 120–960); chip at
  1318; captions centred at 1428; progress bar at 1548. The bottom 360 px stay empty background.
- Cover frame: size the hook to fit between the bars and the progress bar position (at full caption size it wrapped to 3
  lines over the bar in 9:16).

## Motion

- Restrained: the spectrum moves, captions change, the cover art drifts 3 % (sine in-out) over the clip, and a thin progress
  bar (scaleX from its left end) runs across the bottom.
- Clamp every tween position to t ≥ 0. Tweens placed at negative times (the first word lights 50 ms before a word spoken at
  t = 0.02) silently broke the first card.
- Use explicit `fromTo` values with `immediateRender: false` everywhere; seek the timeline to the end and back once before
  registering it.

## Verify (on the rendered files)

- **Bars vs audio** (`verify_sync.py`): per frame, count the lit (warm) pixels in the bar band and correlate with the file's
  own audio RMS at lags −4…+4 frames. The peak must be at lag 0 (achieved 0.90–0.93; picture vs analysis JSON 0.97–0.99).
  For speech onsets out of pauses, the bars' jump lands on the same frame or the next.
- **Pill vs words** (`verify_captions.py`): for every word, take the frame in the middle of its hold, find the pill from a
  thin strip just inside its top edge (above every ascender; detecting it through the letters failed on wide glyphs), and
  compare its centre with the word's box (written by `build.py` with the same layout formula). Only sub-frame words may miss.
- Captions match the audio word for word, including names, repeats and references (listen, don't rely only on the
  transcript); nothing sits under platform UI; −14 LUFS / ≤ −1.5 dBTP measured on the final file.
- AI video review (single file, whole clip) catches real problems (ghosting, low contrast, a missed repeated word) but also
  invents words ("Turn to", "It's—") and reports "missing" captions that are on screen. Check every finding against frames
  and the energy envelope before acting on it.

## Pitfalls seen

- A shared machine can change under you (Homebrew upgraded x265 and broke ffmpeg mid-run). Keep a static ffmpeg/ffprobe
  (pip `static-ffmpeg`) in your own venv and put it first on PATH for the project scripts.
- `faster-whisper`'s PyAV loader failed (`metadata_errors`); read the WAV with `soundfile` and pass the array.
- `hyperframes snapshot` clears `snapshots/` on each run; copy frames out before the next one.
- `lint` warns `nested_structure_needs_subcomposition` for a single-section audiogram; it is harmless for rendering.
