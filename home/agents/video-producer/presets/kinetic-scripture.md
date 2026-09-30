# Style preset: kinetic-scripture

A typography-first reading of a Scripture passage: the words are the star, set word by word on the reading's aligned times over slow, atmospheric backdrops. Restrained, reverent, beautiful. No commentary — the reading is the content.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition for a reverent British reader (previous winner: Gemini TTS `Alnilam` — include as a candidate), one fixed direction for every line: "Speak with a refined British Received Pronunciation accent (British vowels throughout, e.g. a rounded short o in 'God'), in a slightly deeper, lower, fuller chest register, as a scholarly documentary presenter reading Scripture aloud with reverence, warmth and awe; unhurried natural pacing; every declarative sentence ends with firm, falling intonation." |
| `music` | one cue — sparse, luminous strings and piano, following the passage's movements (building, warm, hushed); time-stretch lightly so its final chord lands just after the last word |
| `length` | what the reading needs: about 2 words/s with ~2 s gaps between cards |
| `thumbnail` | the key verse in EB Garamond italic with its key phrase in gold and the reference in Cormorant SC, over the opening backdrop |

## Text

- Quote the chosen translation exactly — every word, punctuation mark, and the translation's capitalization (LORD, Law, pronouns). Store the source text in `gen/source/` and make the build compare every card against it and fail on any difference.
- Cite every passage on screen (reference in Cormorant SC small caps, e.g. "MATTHEW 10:8"); when references are spoken, use the compact form — book, chapter, verse, no "chapter"/"verse" words: "Matthew ten eight", "Romans eight thirty-two", "Second Corinthians nine fifteen" (write the TTS text in words).
- Include a psalm's superscription as a small title line when it has one.
- One card per verse (split a long verse only at its own poetic line break), 2–4 lines on screen, broken where the translation breaks its lines.
- Type: EB Garamond italic for the text (≈58–68 px at 1080), Cormorant SC for the title, reference and verse numbers; set LORD in the font's real small caps. Make verse numbers readable at 720p, not hairline-small.
- Ivory text on dark backdrops, dark ink on light ones, a soft wash behind the text block, and a measured contrast check on every card.
- Gold highlights on a few key phrases per verse, applied to letters only (never punctuation), never split across lines — the build fails if a highlight would wrap.
- Emphasis sparingly: a larger opening line, a slightly larger final line.

## Timing (the build checks all of these)

- Each word is fully visible 0–80 ms before it is spoken (≈70 ms lead works well), revealed as a soft rise out of a blur; highlights warm to gold just after their words appear.
- Word times come from forced alignment of the exact text, one time per occurrence, monotonic within a card; after alignment, pull any word that follows a pause back to its true onset.
- Every card finishes animating and holds ≥0.6 s (aim ≥1.2 s) before it lifts away; cards never overlap; backdrop changes happen only between cards.
- When text colour switches between light and dark, leave ≥3.4 s between cards so a dissolve never sits under wrong-coloured text.

## Backdrops

- One backdrop per movement of the passage, sharp at `asset_resolution` (generated or upscaled), each a calm, low-detail centre for the text, with one slow, eased drift in a single direction.
- Small effects only when they illustrate the text itself (e.g. the sun's glow crossing the sky on "it rises… runs its circuit").
- Apply `../guides/christian-content.md` (Scripture quoting and second-commandment rules) strictly: no people at all by default, and never illustrate a simile with a person (a bridegroom, a champion, a shepherd); show the sun only as the sun.

## Sound

- One clean take per card, all loudness-matched (≈ −21.5 LUFS), gentle 0.2–0.35 s fades at line ends, mouth clicks removed.
- Keep the voice ≥12 dB above the music; keep the SFX bus ≥10 dB under the music, its peaks ≥6 dB under the voice.
- Sparse, locally synthesized sound design in the music's key (shimmers, swells, breaths); step card-change sounds by ~2 semitones per card (rising through praise, falling through a closing prayer).
- Master with a −2 dBTP ceiling so the encoded file stays under −1.5 dBTP; −14 LUFS integrated.

## Review

- Pick takes on objective measures (alignment confidence, a transcription match against the exact text, falling sentence-final pitch, register); reject misreads.
- Judge music and takes as single files rather than A/B pairs — the AI listener has repeatedly just preferred whichever sample came last.
- Verify every AI finding against the signal or the frames before acting on it.

## Lessons from multi-passage readings

- Draw all text as pre-outlined glyph paths by default — the rise-out-of-blur reveal moves text sub-pixel and live text would wiggle. Use lining figures for references (Cormorant SC defaults to old-style numerals).
- Multi-passage readings: speak each reference after its passage, hold ~0.6 s after the spoken reference, dissolve the backdrop only once the card has fully gone (~2.9 s between passages), and end with a card listing every reference plus the translation credit.
- Verify spoken references with a local transcription, not just the AI listener.
- Generated music cues vary widely in loudness: set ducking from measured music-under-voice margins (≥12 dB) rather than fixed dB values.
- The image model sometimes paints a signature: check backdrop corners at full size and crop.
- Keep an unmatched quotation mark when the translation's quotation continues into the next verse, and flag it for the user.
