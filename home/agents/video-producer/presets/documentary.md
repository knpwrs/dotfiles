# Style preset: documentary

A history-documentary short built from real archival material: slow, motivated Ken Burns moves on photographs (2.5D parallax only where a photograph separates cleanly), documents and newspaper clippings with highlighted lines, an animated map that hands over to a period map, typewriter captions for dates and places, grain and gate weave, and a measured narrator. For history and faith channels, museums, anniversaries, archives and organisational histories.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition for a measured, warm documentary narrator: low register (around 100 Hz), wide melodic range, about 135 wpm. Direction: "Narrate as a measured, warm documentary narrator in the tradition of public-television history films: calm and unhurried, a low, warm, resonant register, gentle gravitas with a sense of quiet wonder, natural pauses at commas, clear diction; every declarative sentence ends with a firm, falling intonation." Match the accent to the subject (American for American history, British RP for British history, and so on). Voices that read at 175–190 wpm are too brisk for this style |
| `music` | period-flavoured and restrained: solo piano and/or a small string ensemble, harmony of the era (parlour, hymn, folk), no drums, synths or vocals; one cue whose swell lands under the key photograph. Short-clip music modes often return only about 26 s, so ask for the full length. Delay the cue's entry so its swell and final chord fall where you want them |
| `length` | 60–120 s for a short; long-form when the material carries it |

## Sourcing and rights

- **Archives first, in this order:** Library of Congress (Prints & Photographs, manuscript collections, Chronicling America newspapers), the National Archives, NASA, NOAA (Historical Map & Chart Collection), USGS, the Smithsonian (Open Access **CC0 items only**), national libraries and archives elsewhere, then Wikimedia Commons items marked PD (record the original archive behind them too). Ask the client for their own archive (organisational histories, churches, museums), and get written permission for anything they don't own.
- **For every item, record** the title as the archive gives it, the creator, the date, the archive page URL, the direct download URL, the **verbatim rights statement**, the native pixel size, and what it is used for, in `assets/archive/manifest.json` and a BRIEF table. Read the rights on the item's own record; when it has none, quote the collection's statement and say so (a "dedicated to the public" line may live only on the collection page).
- **Download the largest scan** (LoC: the `…u.tif` grey master, about 5000 px, or the 16-bit `…a.tif` glass-negative scan, about 7500 px; Chronicling America: the page JP2, about 6500×8500; NOAA charts: about 14000×19000 JPG). Keep the originals in `assets/archive/`; the build uses cropped working JPEGs at native resolution.
- **loc.gov access:** its HTML pages return Cloudflare 403 to fetch tools; the `?fo=json` item API and `tile.loc.gov` downloads work, until HTTP 429 rate limiting after many requests. Pace the requests.
- **Never fabricate historical imagery.** No AI-generated photographs, people, documents or newspaper pages; no AI "restoration", colourisation or upscaling of a historical photograph; no generative fill. Classical inpainting is allowed only for a parallax plate, only behind the separated subject, and only where the camera reveals it as a sliver beside the subject.
- **Resolution comes from scans, not upscalers:** record every item's native size and the pixels per output pixel at each push, and limit the push to what the scan holds. AI upscaling invents grain and detail, which on a historical photograph is fabrication; use plain Lanczos at most, and only for the last 1.3× of a push.
- **Illustrations must read as illustrations:** maps and diagrams are drawn in code from public data, in a clearly graphic style, with an on-screen label ("Map illustration: modern state lines, route schematic"; "DIAGRAM · DISTANCES TO SCALE"). A period map is shown as itself, credited.
- **Caption what the picture is, not what the narration wishes it were.** Read each item's archive title before placing it: a photo of damage from one event can't illustrate a different event in the narration. When no honest picture exists for a beat, change the beat. A photo of something else may sit under a line only if its credit says exactly what it is ("The machine, front view").
- **Credits:** a small credit line while each item is on screen (title, date, archive), every archive again on the end card, and AI narration and music disclosed there ("Narration: AI voice · Music: AI-generated score").

## Facts and quotations

- Verify every fact against primary or authoritative sources (the archive itself, the national museum, the park service, the agency) and save a verbatim supporting quote per fact (`gen/source/facts.md`). A research subagent does this well in parallel with the archive search.
- Where sources disagree on a figure (one gives a range, another a single number, a third a spelled-out value), leave the number out or give each figure with its source. Don't name people the sources give only as initials. Watch for known errors in the sources themselves (an agency calling a groundspeed a "top speed").
- Show a partial quote as the exact span with ellipses, and assert it in the build. If the original publication can't be confirmed, attribute it to where you verified it ("as quoted by the National Park Service").
- Documents shown on screen may contain errors. Footnote them rather than let them contradict the narration ("'57 minutes' was a transmission error. It was 59.").

## Look

- A dark, warm stage (#0d0b09) and photographs full frame. Grey scans take a gentle sepia tone (`sepia(.34) contrast(1.05) brightness(.97)`). Documents, newspapers and colour charts keep their own paper.
- **Leave archival damage visible** (emulsion blots, a broken plate corner). Frame around the worst of it, but don't retouch. Showing the whole plate or print as an object at least once (the close) is honest and beautiful.
- Studio portraits read well as mounted prints on the dark stage (560×747 frames with a 14 px cream mat and a soft shadow), side by side for pairs, each with its name typed underneath.
- Typography: a typewriter face (e.g. Courier Prime) for typed captions and credits, engraved small caps (e.g. Cormorant SC) for titles and diagram headings, an old-style italic (e.g. EB Garamond italic) for quotations. Cream (#f2e8d5) with a soft dark shadow over photographs, and a 0.62 bottom scrim behind lower captions. Over light maps, credits switch to dark ink.
- Thumbnail: the key photograph, toned, with the title in dark ink across a light sky or in cream on a dark band, plus a short dated line ("A measure · Month Day, Year").

## Motion

- **Ken Burns:** one slow, eased (sine in-out) move per photograph, motivated by the line: push toward what the narration names, or drift across a scene. The view is `[cx, cy, w]` in image pixels; zoom interpolates geometrically, the centre linearly; the move runs through the whole scene window, including both dissolves. Typical pushes are 1.15–1.8× over 8–15 s. Clamp every view inside the scan.
- **Cuts and dissolves:** 0.9 s dissolves between photographs, incoming scene on top. Derive scene windows so `end ≥ next start + dissolve` and assert it: an outgoing scene that ends mid-dissolve vanishes under the part-opaque incoming one, a visible jump. Hard-cut a set-piece: the shutter flash when the photograph "is taken" (0.07 s up to 92% white, 0.16 s exponential decay, the photo under it). A second set-up on the same document is a hard cut too (the newspaper's dateline, then its headline).
- **2.5D parallax, only where it separates cleanly:** a subject against a plain or low-contrast background (studio portraits, a figure against sky). It fails on wire-braced machines, foliage or crowds over a textured horizon; inspect the full-resolution crop first. Recipe:
  - Matte: a background-removal matte (e.g. `hyperframes remove-background`, u2net) on the full-res scan, rows with plate damage zeroed, the largest component kept, refined with a box-filter guided filter on the scan's luma, then a levels choke. Crop the print so the matte's cut-off rows stay outside it.
  - Plate: the dilated subject region filled with OpenCV Telea inpainting at 1/4 res, blurred, upscaled, with grain matched to the backdrop's high-pass standard deviation.
  - Camera: the figure layer gets the same camera plus an extra push (about 6.5%) **anchored where the subject meets the frame or the ground**, so the body never slides against what it touches. Only a sliver of the fill ever shows, beside the head.
- **Documents:** push toward the line, then a marker highlight in image coordinates (`rgba(240,196,70,.5)`, multiply, 6 px radius) that grows left to right per word, 60 ms before each spoken word (contiguous rects across the spaces), or per line for headlines (0.3 s apart). Measure line and word boxes on the scan (Tesseract TSV for typed text, plus a gridded crop to read large display type), never by eye on the final frame.
- **Maps:** an illustration first (public boundary shapes, e.g. Natural Earth, projected in Python; dashed state lines, an ink coastline, engraved "water-lining" rings offset into the sea, labels as glyph outlines, `vector-effect: non-scaling-stroke`). Hold it wide while a dashed route draws on (rebuild the polyline from the time; no DOM measurement), pins and city labels in stage pixels placed through the camera, then push toward the destination as a period chart dissolves in, framed on the place. Finish with a hand-drawn red ink ring (seeded wobble, about 380° of sweep, drawn on with dash offset) around the chart's own label. Fade state labels out before they grow huge.
- **Diagrams:** a paper card over the dimmed photograph (0.5 black), typewriter rows, ink bars to scale growing on the spoken figures, values riding the bar end, and a source footer. Card and dim fade out before the next dissolve.
- **Quotations:** the close can move the photo aside (an eased slide over 2 s) and set the quote word by word (opacity plus a 6 px blur over 0.25 s, fully visible 50 ms before the word). Time the attribution from the quotation's start, not its last word, so it is on screen ≥ 4 s.

## Captions

- Typewriter captions for date, place, time and measures ("March 3, 1871", "a town, a state", "10:35 a.m.", "120 feet"), bottom left, 40–52 px. Each chunk starts 60 ms before its spoken word and types at about 17 characters per second with seeded jitter; write the same keystroke times to the SFX cue sheet. One idea per line, stacked; they leave together ≥ 0.45 s before the next dissolve.
- Typing takes time (70 characters at 17 cps is 4 s). Long notes such as a footnote don't type: fade them in whole on a dark band and give them ≥ 4 s.
- Names under portraits are typed on the spoken name.
- Captions are live text on a static layer (opacity only). Anything riding a camera (map labels, city names) is drawn from glyph outlines. SVG `<text>` collapses leading spaces: use non-breaking spaces in composed labels ("120 ft · 12 s").

## Grain, weave and texture

- Grain: six seeded, seamless 640 px noise tiles (FFT-periodic blur, so no seams), cycled at 24 fps with random offsets, `mix-blend-mode: overlay` at 30% (14% on the end card). Grain and dust sit under the captions. Grain costs bits: expect a large master (about 1.1 GB for 90 s at 1080p, CRF 12).
- Gate weave on the photograph layers only: per-film-frame (24 fps) jitter of about ±0.5 px plus a slow ±0.7 px drift. Text never weaves.
- Exposure flicker 1–3.5% (a black overlay), rare single-frame dust specks (2–6 px, about 3.5% of frames, photographs only), a radial vignette, and a 0.7 s fade to black at the very end.
- Real archival film footage, if used, takes the same grade and grain and is cut on its own motion.

## Sound

- **Room tone:** a synthesised wind bed (band-passed brown noise with slow gusts, decorrelated L/R), weighted per scene: full on location photographs, about 0.2 under documents and maps. Ducked 3 dB under the voice.
- **Restrained foley, all synthesised:** typewriter keys under typed captions (3 variants, ±0.6 st nudges, very quiet at about 0.075 gain), the bulb shutter (two leaf clicks 60 ms apart plus a puff) on the flash, paper rustles when a document arrives, a pen nib under the ink ring, a pencil line under a growing bar, marker swipes stepped +1 st along a highlighted line, and diagram ticks stepped +2 st per row. No whooshes or booms. Foley bus: HP 60, LP 9.5 kHz, a touch of room.
- Music ducked ≥ 13 dB (RMS) under every line.

## Verify

- **Facts:** every claim and caption is in the BRIEF with its source and a verbatim quote; every quotation is asserted in the build; every caption describes its own picture (check against the archive title).
- **Rights:** every item has a verbatim rights statement in the manifest and the BRIEF, an on-screen credit while shown, and an end-card line.
- **Resolution:** pixels per output pixel at the tightest moment of each push, at the delivered size; aim for ≥ 1.0 (a newspaper headline at about 0.76 can hide under the scan's own softness and the grain; 4K needs tighter limits). Look at 100% crops from the master (type on documents, detail on machines, faces).
- **Containment:** a build-time audit that every caption, credit, diagram card and quotation is fully gone before the next scene's dissolve begins, and that every outgoing scene outlives the incoming dissolve.
- **The final file:** no flash frames (a frame that differs from both neighbours while they agree); frame-difference jumps only at intended cuts.
- **AI video reviewers** are a second opinion only: they catch truncated footnotes and unreadable attributions, but also invent typos, "lagging" highlights, and "lingering" prints that are intended dissolves.
- Judge maps in Chrome snapshots; ImageMagick's internal SVG renderer joins subpaths and draws stray lines across previews.

## Limits

- Untested: 9:16 and 1:1 re-lays, long-form (5–15 min) with chapter cards, colour photographs, an interviewee or on-camera speaker, real archival film footage, and a map with several legs or dates.
