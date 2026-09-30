# Style preset: ui-motion

A polished SaaS product film built from the product's own interface: real (or faithfully rebuilt) screens, a cursor that demonstrates, camera pushes onto the feature that matters, and short callouts that name the benefit. For launches, feature announcements, onboarding and landing-page hero videos.

*Status: proven on one real film (lets.church "Ask a question, find the sermon", 49 s, 16:9 + re-laid 1:1, live captures of a dark-theme web app). Not yet exercised: light-theme products, phone bezels / 9:16, screens rebuilt as HTML, products behind a login.*

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition: confident, friendly, modern narrator matching the brand's market; one fixed direction ("clear, upbeat, conversational product narrator; firm falling endings") |
| `music` | modern, light electronic or indie-pop bed with a steady pulse (95–120 BPM), no vocals; cut to length on the beat grid so its final chord lands under the end card |
| `length` | 30–90 s (feature: 30–60 s; product overview: 60–90 s). One narration line per UI action; ~95 words carry a 50 s feature film |
| `formats` | `16:9` (+ `1:1` or `9:16` cut-downs on request, each re-laid) |
| `thumbnail` | the product's hero screen in a tilted window, the logo, and a 3–5 word benefit headline |

## Sources and capture

- **Capture the live product with Playwright (Chromium), not screenshots of screenshots.** A 1600×900 CSS window at `deviceScaleFactor: 3` (4800 px) holds up to a 4K master with pushes to ~1.5× (tighter pushes sample ≤ 1.33× over native); keep a 2/3-size copy for 720p/1080p builds (much less decode memory). Use the product's own theme (e.g. `colorScheme: "dark"`), `animations: "disabled"`, `caret: "hide"`, and park the mouse off the UI before each shot.
- **Drive the real UI for every state** (type, click, open tabs, follow links) in one script (a `gen/capture.mjs` with one named state per page load) and save a **rects.json of DOM-measured boxes** (`getBoundingClientRect`, elements found by text / aria-label / href) for every element the film points at. DOM rects beat OCR: exact, and they survive re-captures.
- **Find each page's scroll containers** (walk up from the element to the ancestor with `overflow-y: auto|scroll` and `scrollHeight > clientHeight`). Many apps scroll a `<main>` or a side column, not the window: `window.scrollBy` does nothing and `fullPage` screenshots show nothing new. Capture a container's full content by setting its `scrollTop` to several offsets, screenshotting its clip box each time, and stitching; assert the overlaps are pixel-identical. Sticky elements (a footer bar, a sticky panel) break the overlap check: find them from the diff and keep them as fixed overlays.
- **Never trust one very tall screenshot at high DPR**: a 1600×5200 page at DPR 3 silently dropped raster tiles (a blank band mid-page). Stitch from window-height captures instead.
- **Typing:** capture every keystroke (the product's own palette/suggestions update as you type). Split each frame into horizontal bands (input row / first result row / lists), de-duplicate bands by hash, and lay them back per keystroke. Draw the caret yourself (screenshots hide it) at the measured right edge of the typed text; steady while typing, blinking after. Human cadence: ~13 characters/s, +50 ms after spaces and before punctuation, seeded jitter.
- **Hover states:** capture the hovered element as a small clip (its rect + padding) and show it on top of the base while the cursor rests there. Many hover states are subtle or identical; that is honest.
- **AI features are often rate-limited**: repeated identical searches returned "You're asking a little too quickly". Capture each AI-backed state once, in a single page load, and check the page text before accepting the shot.
- If screens must be rebuilt (private app, unreleased feature), rebuild them as HTML from the client's screenshots/Figma, pixel-matched, with obviously placeholder data labelled "Illustrative".
- Never show a real customer's data without permission. When the product shows third-party content (channels, customers, users), pick a query whose results come from few sources, list every name visible in any frame (OCR the typing frames too), and flag them for permission before public release. Audit third-party thumbnails at full resolution against any content guide and blur what it rules out.

## Look

- A calm stage in the brand's neutral (dark UI → near-black stage with a soft brand glow), one accent colour, the window filling most of the frame (16:9: a 1600×900 viewport at x 160, y 112; 1:1: a 1000×800 viewport, centred); the product is the hero.
- Browser chrome: 44 px bar, three dots, a URL pill showing the real address of each state (truncate long queries with "…"; switch it on the navigation cut).
- Callouts: 2–5 word benefit pills (brand-tinted border, a small accent dot) with a leader that ends on the element; never more than one or two on screen. Place them automatically: an anchor point on the element plus a side (above / below / left / right) at ~60 px, computed through the camera at the hold and clamped inside the window. Put a spotlight behind any callout that must sit over other UI, so it covers dimmed content only.
- Brand typefaces for callouts and cards, drawn as glyph outlines so their rises don't wiggle; UI text stays the product's own pixels. End card on the ground the logo art is made for (a dark-type mark → a light card).

## Motion

- **One window layer for all captures.** Every capture of the same 1600×900 window is an `<img>` in one layer that the camera transforms; rings, spotlights, hover clips, typing bands and the cursor's target points all live in that coordinate space, so they can't drift from the UI. Swap captures by z-index + opacity (keep hidden ones at opacity 0.001 so they stay decoded). Give every element that reveals later an initial CSS `opacity: 0` (a `fromTo` with `immediateRender: false` leaves it at its CSS value before it starts).
- **Evaluate motion as pure functions of time.** Camera (view centre + zoom, zoom interpolated geometrically, clamped per frame so the window always fills the viewport), cursor path, scroll offsets and callout leaders are keyed tracks evaluated in one clock tween's `onUpdate`; throw at build time if two moves on a track overlap. Measure nothing in that callback (cache element sizes at build time; lint flags DOM measurement in callbacks). Play the timeline through once before registering it. Derive anything that depends on the camera (stroke widths, click-pulse positions) after the whole camera track is built.
- **Camera:** 1.0–1.4 s eased pushes onto the element being described (legible UI text needs ~1.5–2× on a 1600 px window at 1080p); a slow 2–3 % drift while holding; one move at a time. Pull back to full view when the result of an action spans the page. Re-frame every region for 1:1 rather than cropping the 16:9 view.
- **Cursor:** an arrow glyph at constant stage size (outside the camera transform, placed from its window point through the camera), moving on quadratic arcs that alternate their bow, arriving ≥ 0.1 s before its click; click = a 0.07 s press (scale 0.88) + an expanding ring + the UI's real state change. Aim at the element's label, not its box centre (an icon + text button's centre can sit on the icon). Hide it while the user types.
- **UI state changes are hard cuts** (the app updates instantly); a crossfade between two layouts reads as a double exposure. Dissolve only a loading skeleton → loaded page (~0.25 s).
- **Match cuts for navigation:** push fast into the clicked element (0.4–0.5 s, `power2.in`, to ~2.5–3×), cut (a 0.12 s dissolve) to the destination framed tight on its matching element (a result title onto the page title; a verse link onto the verse), then ease out (0.9–1.3 s, `power3.out`).
- **Scrolling:** slide the stitched strip inside the container's real clip box (sidebar and sticky panels stay put), 1.0–1.3 s `power3.inOut`. Draw rings for scrolled content inside the scrolling layer and anchor callouts to page points (`[x, y − scroll(t)]`), so both stay locked to their entries mid-scroll. Anything drawn in window coordinates must fade out before a scroll or camera move.
- **Focus:** spotlight (a dimming path with a rounded hole) plus a thin ring (2.6 px + a 9 px soft halo, stroke widths divided by the zoom the ring is seen at), both from measured rects.
- Build-ups land on aligned narration words, ~60 ms early.

## Sound

- UI foley, synthesised or CC0: a soft mouse click on every click, key ticks while typing, a soft scroll swell, a blip per ring, a pop per callout (step its pitch through the film so no two are identical), a whoosh only on big moves (the open, the dives), a warm logo hit. Keep foley well under the voice: key ticks peaking ≈ −27 dBFS, clicks and pops ≈ −20 dBFS peak in a −14 LUFS mix; low-pass the foley bus around 9–10 kHz (a reviewer heard brighter hits as "piercing" and a louder run of scroll detents as "typing").
- Music ducked ≥ 13 dB under every line (adaptive per line). Cut the cue on the beat grid — remove whole bars, splice ~20 ms before a downbeat with a 60 ms equal-power crossfade — so its ending lands under the end card, and bloom it after the last word. −14 LUFS / ≤ −1.5 dBTP; remux the master mix onto the render (the renderer's AAC read −1.4 dBFS).

## Verify

- Every ring, callout anchor and cursor target comes from measured rects; proof them on snapshots at the hold and mid-move.
- Scan the final file for flash frames (a frame that differs from both neighbours while they agree) and look at frames around every cut, scroll and click.
- AI video reviewers are useful but noisy: in the first film they caught a real double exposure and loud foley, and also invented a wrong timestamp, a leader "to the progress bar", an "audible music edit" and a "click at the end". Verify every finding on frames or waveforms (beat-track the edited cue; measure the last 20 ms) before acting.
- No real personal data; third-party names listed; placeholder data labelled; text legible at the smallest delivered size.
