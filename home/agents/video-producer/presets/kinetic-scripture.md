# Style preset: kinetic-scripture

A typography-first reading of a Scripture passage: the words are the star, set word by word on the reading's aligned times over slow, atmospheric backdrops. Restrained, reverent, beautiful. No commentary — the reading is the content.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition for a reverent British reader, one fixed direction for every line: "Speak with a refined British Received Pronunciation accent (British vowels throughout, e.g. a rounded short o in 'God'), in a slightly deeper, lower, fuller chest register, as a scholarly documentary presenter reading Scripture aloud with reverence, warmth and awe; unhurried natural pacing; every declarative sentence ends with firm, falling intonation." |
| `music` | one cue — sparse, luminous strings and piano, following the passage's movements (building, warm, hushed); time-stretch lightly so its final chord lands just after the last word |
| `length` | what the reading needs: about 2 words/s with ~2 s gaps between cards |

## Text

- Quote the chosen translation exactly — every word, punctuation mark and the translation's capitalisation (LORD, Law, pronouns). Keep the source text in the project and make the build compare every card against it and fail on any difference.
- Cite every passage on screen (reference in small caps, e.g. "MATTHEW 10:8"). When references are spoken, use the compact form — book, chapter, verse, no "chapter"/"verse" words: "Matthew ten eight", "Romans eight thirty-two", "Second Corinthians nine fifteen" (write the TTS text in words).
- Include a psalm's superscription as a small title line when it has one.
- One card per verse (split a long verse only at its own poetic line break), 2–4 lines on screen, broken where the translation breaks its lines.
- Type: a classical italic serif for the text (e.g. EB Garamond italic, ≈58–68 px at 1080) and a small-caps display serif for the title, reference and verse numbers (e.g. Cormorant SC). Set LORD in the font's real small caps. Use lining figures for references (some small-caps faces default to old-style numerals). Make verse numbers readable at 720p, not hairline-small.
- Ivory text on dark backdrops, dark ink on light ones, a soft wash behind the text block, and a measured contrast check on every card.
- Gold highlights on a few key phrases per verse, applied to letters only (never punctuation), never split across lines — the build fails if a highlight would wrap.
- Emphasis sparingly: a larger opening line, a slightly larger final line.
- Keep an unmatched quotation mark when the translation's quotation continues into the next verse, and flag it for the user.
- Thumbnail: the key verse in the text face with its key phrase in gold and the reference in the small-caps face, over the opening backdrop.

## Timing (the build checks all of these)

- Reveal each word as a soft rise out of a blur, fully visible about 70 ms before it is spoken; highlights warm to gold just after their words appear. All text is pre-outlined glyph paths, since the blur-rise moves text sub-pixel.
- Word times come from forced alignment of the exact text, one time per occurrence, monotonic within a card; after alignment, pull any word that follows a pause back to its true onset.
- Every card finishes animating and holds (aim ≥ 1.2 s) before it lifts away; cards never overlap; backdrop changes happen only between cards.
- When text colour switches between light and dark, leave ≥ 3.4 s between cards so a dissolve never sits under wrong-coloured text.
- Multi-passage readings: speak each reference after its passage, hold ~0.6 s after the spoken reference, dissolve the backdrop only once the card has fully gone (~2.9 s between passages), and end with a card listing every reference plus the translation credit.

## Backdrops

- One backdrop per movement of the passage, each a calm, low-detail centre for the text, with one slow, eased drift in a single direction.
- Small effects only when they illustrate the text itself (e.g. the sun's glow crossing the sky on "it rises… runs its circuit").
- No people at all by default; never illustrate a simile with a person (a bridegroom, a champion, a shepherd); show the sun only as the sun.

## Sound

- One clean take per card, all loudness-matched (≈ −21.5 LUFS), gentle 0.2–0.35 s fades at line ends, mouth clicks removed.
- Keep the voice ≥ 12 dB above the music, set from measured music-under-voice margins (generated cues vary widely in loudness, so fixed dB ducking misses). Keep the SFX bus ≥ 10 dB under the music, its peaks ≥ 6 dB under the voice.
- Sparse, locally synthesised sound design in the music's key (shimmers, swells, breaths); step card-change sounds by ~2 semitones per card (rising through praise, falling through a closing prayer).
- Master with a −2 dBTP ceiling so the encoded file stays under −1.5 dBTP.

## Review

- Pick takes on a transcription match against the exact text as well as the usual voice measures; reject any misread.
- Verify spoken references with a local transcription, not just an AI listener.
