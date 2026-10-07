# Style preset: social-captions

Vertical clips cut from the client's own footage (podcast, talk, sermon, interview, founder video) with bold word-by-word captions, a hook in the first second, and punch-in reframes. For Reels, TikTok, YouTube Shorts and LinkedIn; usually ordered in batches.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `script` | `as-is`: the speaker's own words; never rewrite what someone said |
| `voice` | `none` (the footage's own audio); an optional one-line narrated hook only on request |
| `music` | `none`, or a quiet bed under talk clips on request (ducked far under the speech). A single-speaker teaching clip rarely needs one |
| `length` | 15–60 s per clip (30–45 s is a good middle); a batch picks the strongest moments |
| `formats` | `9:16` (1080×1920); `1:1`, `4:5` and `16:9` on request, each re-cropped from the source, not from the 9:16 |

## Selecting moments

- Transcribe the whole source locally with a large speech-to-text model (about real time on a laptop CPU, so start it first and build the pipeline while it runs). Use it for **text only**.
- Read the entire transcript, shortlist about 10 moments, and pick a batch with **different shapes**: a personal confession that resolves on an action, a practical scenario that resolves on a rule, and the talk's thesis in one breath. Each must stand alone: start on the hook line (the first words make sense cold), end on the resolution sentence, and make no reference to something outside the clip ("as I said", "this verse").
- Skip political asides, in-jokes and moments that lean on slides or on earlier context. Avoid ranges an earlier deliverable already used.
- Find the in/out points from forced alignment plus an RMS or spectrogram look (transcript word times can be off by 0.3–0.5 s). Put in-points 0.15–0.25 s before the first phoneme and out-points 0.3–0.5 s after the last; quantise both to the source frame grid (29.97 fps sources: `round(t·fps)/fps`). Cut in room tone, never mid-word, with 15 ms audio fades.
- **Tightening:** long room-tone pauses *between sentences* (rhetorical pauses of 5 s or more) can be cut to about 0.7 s. Hide each join with a punch-in change (≥ 8–10% zoom difference). Keep pauses *inside* a sentence. A false start or filler that sits exactly at a join may be dropped. Log every clip's source ranges, every join and every removal in `BRIEF.md`.

## Text: getting the words exactly right

- Cross-check each chosen clip with a second, smaller model and a prompt-free pass of the large model on just that window. Settle every disagreement against the audio: align each competing text with the forced aligner and compare the **total log-likelihood** (sum of log p) of the disputed span, **not mean p**, because an extra weak word always lowers a mean and makes a real word look absent. Confirm borderline cases on a spectrogram (`showspectrumpic`): count vowel nuclei and look for fricative or plosive bursts.
- Known speech-to-text habits: it normalises "gonna"/"wanna" to "going to"/"want to" (the aligner then finds no "to", p ≈ 0), drops immediate repetitions ("Christ, Christ"), hallucinates on snippets under about 1 s ("Thank you."), and sometimes inserts "and"/"but". Caption what was said; keep "gonna" when the acoustics say so.
- Numbers: the MMS aligner has no digits. Write `{119|one nineteen}` (display | spoken) and expect a low score on the number itself; judge it by its timing.
- Keep capitalisation conventions (e.g. pronouns for God) consistent across a batch, changing case only, never words.
- After the render, transcribe the **final file's** audio and diff it word for word against the captions. Explain every remaining difference in `BRIEF.md` (e.g. a transcription habit confirmed by the aligner and spectrogram) or fix it.
- A clip with a spoken reference gets a small reference chip showing the reference as spoken. When the speaker paraphrases, alludes or adds glosses while reading, the captions stay the speaker's words and nothing is presented as a quotation.

## Look

- **Reframe:** full-bleed 9:16 from a face track (a face detector, e.g. YuNet, on every frame, then median and Gaussian smoothing). Use a **dead-zone virtual camera**: hold still while the face stays within ±12% of the crop width of centre, then re-centre with a 0.9 s sine ease that targets the face's mean position over the next second. Eyes at about 36% of the frame height. This reads as an operated camera rather than a jittery follow. For two-person footage, cut between speakers on turns or use a stacked split.
- **Captions:** 1–4 words per card from a small dynamic-programming segmenter, not a greedy fill (greedy filling produces "It discerns the | thoughts and…"). Hard breaks at sentence ends and at pauses over 0.32 s. Costs: one-word cards (unless the word has 7+ letters), four-word cards, ending a card on a function word (a/the/of/to/and/my/your/that/is…), a comma inside a card, splitting "one | another" or a possessive from its noun, and cards that would flash for under 0.3 s. Breaking at a comma or a short pause is cheap. Measure widths with the real shaped text, and check width *before* appending a word (carrying a trailing function word forward can overflow the next card).
- **Type:** a heavy sans (e.g. Montserrat ExtraBold), mixed case, 88 px at 1080 wide (78 px on 1:1), white with a **16 px dark stroke** (paint-order stroke) plus a tight shadow and a soft 18 px dark glow, so it holds up over white shirts and blown highlights. The spoken word is filled with the accent (a warm gold such as #FFC93C reads well over grey and white). Every glyph is an outlined path (shaped and kerned, e.g. HarfBuzz + fontTools pens), so scale pops never wiggle. If the glyph transform flips y, bounds come back y-down; compare ink against boxes in the same space.
- **Safe areas:** 9:16 captions and plates inside x 60–1020, y 250–1560, with the caption centre around y 1330 (chest height, below the face). The build asserts each card box (glyph ink + stroke) lies inside its SVG and inside the safe area. 1:1: caption centre at y 850, headline at top y 64.
- **Hook headline:** the hook line (framing, not a quote; the speaker's wording where possible) on a dark rounded plate, 50 px, at the top of the safe area, visible on frame one and **faded out about 5 s in** (after the first sentence) in 9:16, since held for the whole clip it crowds the head and is hidden on punch-ins. On 1:1 there is room to keep it.
- **Cover/thumbnail:** one per clip and format. Pick the still by eye from a labelled grid (every 2 s) of the reframed plate: face frontal, eyes open, mouth closed or neutral. Put the hook line large (104 px, 2 balanced lines) in caption style over a dark lower gradient.
- Optional: a progress bar, a handle or logo, and one emoji or sticker on a key word at most every 5 s.

## Motion

- **Punch-ins are hard cuts on sentence starts** (1.10–1.20x about the face), held until the next chosen sentence; no continuous zooming and no eased zooms mid-sentence. Put one on the resolution line, and use them to disguise tightened joins.
- Caption cards: **opacity snaps on at the card's first frame** and only the scale pops (0.9 → 1 over 0.1 s, power2.out); with an opacity fade, a short first word such as "I" loses its highlight on the pop frame. Individual words don't move; only the fill changes.
- **Highlight timing:** each word turns accent 50 ms before its aligned start and back when the next word starts. A card shows from its first word minus 50 ms until the next card or its last word plus 0.35 s. Very fast words get 2-frame highlights, which is accepted.
- B-roll or on-screen text only where it clarifies (a name, a number, a cited verse), each sourced.

## Low-resolution sources

- A 9:16 crop of 720p footage is **405 px wide**: 2.67x to 1080, and about 3.2x on a 1.2x punch-in. Options, best first:
  - Full-bleed, face-tracked, with super-resolution: looks native. The default.
  - **4:5** (576×720 → 1.88x): a good feed alternative. 1:1 re-lay (700×700 → 1.54x) also holds well.
  - Stacked 8:9 medium crop over a blurred fill (1.69x): crisper, but reads as a letterboxed repost with dead space. The fallback for worse sources.
  - A tighter face crop (3.2x) is too soft and cramped; a stacked wide shot (0.84x) is sharp but the speaker is tiny.
- **Upscaling recipe:** a compact general-purpose Real-ESRGAN model (e.g. `realesr-general-x4v3`; the heavier x4plus looks plastic) on the integer-padded crop, area-downscaled to the output, then **blended 60/40 with a Lanczos** resample of the same fractional window. Bake camera moves and punch-ins into this **single resample from the source** (write an H.264 CRF 10 intermediate plate; the composition only overlays type). Check temporal stability: frame-to-frame MAD on a static wall should match a Lanczos-only render.
- State in `BRIEF.md` that 1080 masters from a 720p source carry roughly 720p-class detail, and don't offer 4K.

## Sound

- Speech chain (ffmpeg): `highpass=85`, `afftdn=nr=10:nf=-44`, −2.5 dB @ 250 Hz, +2 dB @ 3.2 kHz, `deesser=i=0.25`, `acompressor` 2.5:1 @ −22 dB, then the loudness master with an `alimiter` at 0.83 (lands ≈ −1.6 dBTP). For multi-segment clips, concatenate the raw segments (15 ms fades at joins) *before* the chain so loudness is measured over the whole clip.
- A speaker's quiet dramatic delivery (a softer punchline) is dynamics, not a fault; keep it.
- Punch-ins need no whoosh.

## Verify

- From the **final files**: the highlight position (at the middle of each word's window, the accent ink's centroid lies on that word's measured x); the transcript diff of the final audio against the captions; duration; and a frame-by-frame step through every join and punch.
- AI review (one file per call) finds real issues (a missing "And", a repeated word, a false start at a join), but about half its findings are false ("caption missing" when it is there, "gonna should be going to", normalised quotation wording). Verify each against the aligner, spectrogram and frames.
- Nothing essential under platform UI in any format; no mid-word cuts; the speaker's meaning unchanged by any tightening.
- Permission: the client owns or has rights to the footage and to every person in it. Without a signed release, label everything INTERNAL TEST.

## Pitfalls

- Building a cover (or any variant) rewrites `index.html`, so never build while a render of that project is running. Keep the render lock in a wrapper script with a `trap` that removes it on exit; retry `mkdir` every 60 s.
- zsh: `set -- $var` doesn't word-split (use `${=var}`), and an unmatched glob aborts the whole `&&` chain.

## Limits

- Untested with two-person or multi-camera footage, handheld footage, music beds, emoji/sticker emphasis, 16:9 output, and sources at or above 1080p.
