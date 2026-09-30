# Style preset: social-captions

Vertical clips cut from the client's own footage (podcast, talk, sermon, interview, founder video) with bold word-by-word captions, a hook in the first second, and punch-in reframes. For Reels, TikTok, YouTube Shorts and LinkedIn; usually ordered in batches.

*Proven once (Sep 2026: 3 clips + a 1:1 re-lay from a 47-min, 720p locked-off talk recording, single speaker at a pulpit; `videos/samples/social-captions-test/`, whose scripts in `gen/` are reusable). Not yet tried: two-person or multi-camera footage, handheld footage, music beds, emoji/sticker emphasis, 16:9 output, and sources at or above 1080p.*

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `script` | `as-is`: the speaker's own words; never rewrite what someone said |
| `voice` | `none` (the footage's own audio); an optional one-line narrated hook only on request |
| `music` | `none`, or a quiet bed under talk clips on request (ducked far under the speech). A single-speaker teaching clip did not need one |
| `length` | 15–60 s per clip (30–45 s proved a good middle); a batch picks the strongest moments |
| `formats` | `9:16` (1080×1920); `1:1`, `4:5` and `16:9` on request, each re-laid (re-cropped from source, not from the 9:16) |
| `thumbnail` | a cover per clip and format: the speaker's best still + the hook line in caption style (1080 JPG + 720 JPG) |
| `render` | 720-wide proxies (`--quality standard`), then 1080 masters (`--quality high --crf 12`) after self-review |

## Selecting moments

- Transcribe the whole source locally (faster-whisper large-v3; about real time on an M4 Pro CPU, so start it first and build the pipeline while it runs). Whisper is for **text only**.
- Read the entire transcript, shortlist about 10 moments, and pick a batch with **different shapes**: a personal confession that resolves on an action, a practical scenario that resolves on a rule, and the talk's thesis in one breath. Each must stand alone: start on the hook line (the first words must make sense cold), end on the resolution sentence, and make no reference to something outside the clip ("as I said", "this verse").
- Skip political asides, in-jokes and moments that lean on slides or on earlier context. Avoid ranges an earlier deliverable already used.
- Find the in/out points from forced alignment plus an RMS or spectrogram look, not from Whisper word times (they can be off by 0.3–0.5 s). Put in-points 0.15–0.25 s before the first phoneme and out-points 0.3–0.5 s after the last; quantise both to the source frame grid (29.97 fps sources: `round(t·fps)/fps`). Cut in room tone, never mid-word, with 15 ms audio fades.
- **Tightening:** long room-tone pauses *between sentences* (rhetorical pauses of 5 s or more) can be cut to about 0.7 s. Hide each join with a punch-in change (≥ 8–10% zoom difference). Keep pauses *inside* a sentence. A false start or filler that sits exactly at a join may be dropped. Log every join (source ranges) and every removal in `BRIEF.md`.
- Record each clip's source ranges in `BRIEF.md`.

## Text: getting the words exactly right (as-is)

- Cross-check each chosen clip with a second model (medium.en) and a prompt-free large-v3 pass on just that window. Settle every disagreement against the audio: align each competing text with the forced aligner and compare the **total log-likelihood** (sum of log p) of the disputed span, **not mean p**, because an extra weak word always lowers a mean and makes a real word look absent. Confirm borderline cases on a spectrogram (`showspectrumpic`): count vowel nuclei and look for fricative or plosive bursts.
- Known Whisper habits: it normalises "gonna"/"wanna" to "going to"/"want to" (the aligner then finds no "to", p ≈ 0), drops immediate repetitions ("Christ, Christ"), hallucinates on snippets under about 1 s ("Thank you."), and sometimes inserts "and"/"but". Caption what was said. Keep "gonna" when the acoustics say so.
- Numbers: the MMS aligner has no digits. Write `{119|one nineteen}` (display | spoken) and expect a low score on the number itself; judge it by its timing.
- Capitalise pronouns for God consistently across a batch (His/Him) when the brand or translation does (BSB). This changes case only, never words.
- After the render, transcribe the **final file's** audio and diff it word for word against the captions (`check_text.py`). Every remaining difference must be explained in `BRIEF.md` (e.g. a Whisper habit confirmed by the aligner and spectrogram) or fixed.
- Scripture and allusions (Christian content): a clip with a spoken reference gets a small reference chip showing the reference as spoken, and any verse card must match the translation exactly. When the speaker paraphrases or alludes (e.g. "instruction in righteousness"), the captions stay his words and nothing is presented as a quotation. Speakers often read with their own glosses ("O Yahweh" where the BSB has "LORD"), so verify before putting any verse text on screen.

## Look

- **Reframe:** full-bleed 9:16 from a face track (OpenCV YuNet on every frame, then median and Gaussian smoothing). Use a **dead-zone virtual camera**: hold still while the face stays within ±12% of the crop width of centre, then re-centre with a 0.9 s sine ease that targets the face's mean position over the next second. Eyes at about 36% of the frame height. This reads as an operated camera rather than a jittery follow. For two-person footage, cut between speakers on turns or use a stacked split (not yet tried).
- **Captions:** 1–4 words per card from a small dynamic-programming segmenter, not a greedy fill. Hard breaks at sentence ends and at pauses over 0.32 s. Costs: one-word cards (unless the word has 7+ letters), four-word cards, ending a card on a function word (a/the/of/to/and/my/your/that/is…), a comma inside a card, splitting "one | another" or a possessive from its noun, and cards that would flash for under 0.3 s. Breaking at a comma or a short pause is cheap. Measure widths with the real shaped text.
- **Type:** a heavy sans (Montserrat ExtraBold worked), mixed case, 88 px at 1080 wide (78 px on 1:1), white with a **16 px dark stroke** (paint-order stroke) plus a tight shadow and a soft 18 px dark glow, so it holds up over white shirts and blown highlights. The spoken word is filled with the accent (gold #FFC93C read well over grey and white). Draw every glyph as an outline: HarfBuzz for shaping and kerning, fontTools pens for SVG paths (`glyphs.py`). No live text reaches the DOM, so scale pops never wiggle.
- **Safe areas (9:16):** captions and plates inside x 60–1020, y 250–1560, with the caption centre around y 1330 (chest height, below the face). The build asserts each card box (glyph ink + stroke) lies inside its SVG and inside the safe area. 1:1: caption centre at y 850, headline at top y 64.
- **Hook headline:** the hook line (framing, not a quote; the speaker's wording where possible) on a dark rounded plate, 50 px, at the top of the safe area, visible on frame one and **faded out about 5 s in** (after the first sentence) in 9:16. Held for the whole clip it crowds the head, which is hidden on punch-ins. On 1:1 there is room to keep it.
- **Cover:** pick the still by eye from a labelled grid (every 2 s) of the reframed plate: face frontal, eyes open, mouth closed or neutral. Put the hook line large (104 px, 2 balanced lines) in caption style over a dark lower gradient.
- Optional (not yet tried): a progress bar, a handle or logo, and one emoji or sticker on a key word at most every 5 s.

## Motion

- **Punch-ins are hard cuts on sentence starts** (1.10–1.20x about the face), held until the next chosen sentence; no continuous zooming, and no eased zooms mid-sentence. Put one on the resolution line, and use them to disguise tightened joins.
- Caption cards: **opacity snaps on at the card's first frame** and only the scale pops (0.9 → 1 over 0.1 s, power2.out). With an opacity fade, a short first word such as "I" loses its highlight on the pop frame. There is no motion on individual words; only the fill changes.
- **Highlight timing:** each word turns accent 50 ms before its aligned start (the rule is 0–80 ms) and back when the next word starts. A card shows from its first word minus 50 ms until the next card or its last word plus 0.35 s. Very fast words get 2-frame highlights, which is accepted.
- B-roll or on-screen text only where it clarifies (a name, a number, a cited verse), each sourced.

## Low-resolution sources (the 720p limit)

- A 9:16 crop of 720p footage is **405 px wide**: 2.67x to 1080, and about 3.2x on a 1.2x punch-in. Tested on one frame:
  - Full-bleed, face-tracked, with SR: **chosen**. It looks native.
  - Tighter face crop (3.2x): too soft and cramped.
  - Stacked 8:9 medium crop over a blurred fill (1.69x): crisper, but it reads as a letterboxed repost with dead space. The fallback for worse sources.
  - Wide shot stacked (0.84x): sharp, but the speaker is tiny.
  - **4:5** (576×720 → 1.88x): a good feed alternative.
  - 1:1 re-lay (700×700 → 1.54x): holds well.
- **Upscaling that worked:** Real-ESRGAN compact `realesr-general-x4v3` (spandrel, MPS, about 0.14 s/frame) on the integer-padded crop, area-downscaled to the output, then **blended 60/40 with a Lanczos** resample of the same fractional window. Bake camera moves and punch-ins into this **single resample from the source** (write an H.264 CRF 10 intermediate plate; the composition only overlays type). RealESRGAN_x4plus looked plastic. Check temporal stability: frame-to-frame MAD on a static wall should match the Lanczos-only render (0.206 vs 0.195 here).
- State in `BRIEF.md` that 1080 masters from a 720p source carry roughly 720p-class detail, and don't offer 4K.

## Sound

- Speech chain (ffmpeg): `highpass=85`, `afftdn=nr=10:nf=-44`, −2.5 dB @ 250 Hz, +2 dB @ 3.2 kHz, `deesser=i=0.25`, `acompressor` 2.5:1 @ −22 dB, then two-pass `loudnorm` to −14 LUFS with an `alimiter` at 0.83 → **−14.0 LUFS / −1.6 dBTP** measured on the rendered file. For multi-segment clips, concatenate the raw segments (15 ms fades at joins) *before* the chain so loudnorm sees the whole clip.
- A speaker's quiet dramatic delivery (a softer punchline) is dynamics, not a fault; keep it.
- An optional very quiet whoosh on punch-ins was not needed.

## Verify

- From the **final files**, not the build: check the highlight position (at the middle of each word's window, the gold ink's centroid lies on that word's measured x; `verify_render.py`); the Whisper diff of the final audio against the captions; loudness and true peak; duration; and a frame-by-frame step through every join and punch.
- AI review (a video+audio model, one file per call, about $0.01 per clip) finds real issues (a missing "And", a repeated word, a false start at a join). About half its findings are false ("caption missing" when it is there, "gonna should be going to", Scripture-normalised wording). Verify each one against the aligner, spectrogram and frames before acting.
- Nothing essential under platform UI in any format; no mid-word cuts; the speaker's meaning unchanged by any tightening.
- Permission: the client owns or has rights to the footage and to every person in it. Without a signed release, label everything INTERNAL TEST.

## Pitfalls seen

- Greedy card filling produces "It discerns the | thoughts and…". Use the DP segmenter.
- Card-grouping width checks must happen *before* appending a word, and "carry the trailing function word forward" logic can overflow the next card. Assert the safe area in the build.
- BoundsPen bounds come back y-down once the glyph transform flips y; check ink against the box in the same space.
- Building a cover (or any variant) rewrites `index.html`, so never build while a render of that project is running.
- zsh: `set -- $var` doesn't word-split (use `${=var}`), and an unmatched glob aborts the whole `&&` chain.
- Keep the render lock in a wrapper script with a `trap` that removes it on exit; retry `mkdir` every 60 s.
