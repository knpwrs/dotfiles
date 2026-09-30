# Style preset: dramatic-2.5d

A serious, cinematic narrative explainer: painted scenes with real depth, slow camera moves through the layers, atmosphere, and scripture or key phrases set as elegant typography in the space. Dramatic narrative devices and set-piece lines ("The cross was not defeat.") are welcome.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition for a British scholarly documentary narrator (previous winner: Gemini TTS `Alnilam` — include as a candidate), one fixed direction string for every line: "Speak with a refined British Received Pronunciation accent (British vowels throughout, e.g. a rounded short o in 'God'), in a slightly deeper, lower, fuller chest register, as a scholarly documentary presenter: serious, grave and measured, yet warm and welcoming, a storyteller drawing the listener in; unhurried natural pacing; every declarative sentence ends with firm, falling intonation." Pick takes on objective measures (alignment confidence, falling sentence-final pitch, pace) — the AI listener has shown position bias, so run any A/B in both orders. Never pitch-shift a voice to change its register; re-perform instead. |
| `music` | orchestral cues (strings, low brass, piano, sparse choir), several cues placed per section; time-stretch lightly so a cue's hit lands on a set-piece line; transcribe every cue locally and reject any with sung or spoken words |
| `length` | what thorough treatment needs (often 5–15 min) |
| `upscale_tolerance` | 7 |
| `thumbnail` | two-sided or single striking painted frame with a short thesis in Cormorant SC (e.g. split frame "THEY MEANT EVIL | GOD MEANT GOOD" with the verse across the top) |

## Look

- Painterly, Rembrandt-lit oil style; cohesive palette and light direction per scene; film grain and vignette.
- Every scene gets its own unique composition — no painting is reused anywhere in the film.
- Typography: scripture in EB Garamond italic, references in gold Cormorant SC small caps, set word by word on aligned times. Highlight colour applies to letters only (punctuation — quotes, commas, periods, dashes — never takes it); a highlighted phrase is never split across lines (re-balance line breaks); highlight whole meaningful phrases ("Master who bought them"), several per long verse when it helps.

## Layers built for parallax

Generate each scene as separate, complete layers — never cut layers out of a finished painting (that produces detached heads, split handles, stretched surfaces):
1. **Far background**, full-frame and opaque, with no foreground objects — from the bake-off winner for painterly detail and architecture (gpt-image-2.x upscaled is a strong candidate; a native-4K model such as Gemini 3 Pro Image is an option).
2. **One or two midground layers** and **a foreground layer** as whole, intact objects on transparent backgrounds (from the model that wins the bake-off for clean cutouts; previous winner: gpt-image with transparent background), each generated with the scene's background as the style/lighting reference so they composite as one painting. Entire figures including heads, whole jugs with handles, whole lamps.
3. Mid/foreground layers sit flat at a single depth (no mesh displacement → no stretching); the background may take only a gentle, heavily smoothed depth ramp. Remove pale glow fringes on cutouts; scale any layer that touches a frame edge so its edge never enters the frame. Every layer is complete, so nothing is ever uncovered and no hole filling is needed.

## Camera and motion

- One continuous, eased camera move per scene in a single direction (lateral + slight rise + a dolly-in where near layers grow and far ones don't); ramps of ~1.5 s at each end, constant between; directions alternate from scene to scene.
- Parallax must be clearly measurable: run an optical-flow check (near vs far bands, median px/s at 1920 width over 3 s) on representative scenes — near should move several times faster than far (≥3×, ideally ≫).
- Render the layers in WebGL (or equivalent) driven only by the seek time; load and decode every texture before capture; cap GPU residency; verify with a band/glitch scan of the final file.
- Atmosphere on its own planes: fog between depth layers, dust in front, light rays.

## Scene containment

Every overlay — text, cards, props — is fully gone before the next scene's dissolve begins; dissolves are painting-to-painting only. Dump an element → scene window → in/out table from the build and check every transition has zero violations.

## Sound

Synthesised low booms under set-piece lines, soft hits on cards, whooshes on dissolves, ambient wind/fire beds — following the Sound variety rule; music ducked under the VO; −14 LUFS.

## Christian / Reformed content

Apply `../guides/christian-content.md` (Scripture quoting and second-commandment rules) to every image, layer, prop, silhouette and metaphor.

## Implementation notes

- **Renderer:** one shared WebGL2 canvas (`preserveDrawingBuffer: true`) under the HTML text layer, redrawn on every seek from the timeline time (never a free-running animation loop). Each scene's layers are textured quads drawn far → near with premultiplied alpha; each layer has a depth weight `w` (far 0 → near 1, normalised per scene from its depth range). Camera state at time `t` is a pure function of the scene's eased progress: screen offset = `pan · w` (plus `rise · w`), scale = `1 + push · w` (far layers stay still and unscaled, near ones travel and grow), with per-layer overscan so edges never show. Fog quads are drawn between layer indices; dust and light rays are HTML/CSS planes in front.
- **Loading:** preload and decode every layer texture before the first capture (wait on `img.decode()`), never build a texture from an unloaded image, keep at most two scenes' textures resident, skip mipmaps, and retry after freeing textures on out-of-memory.
- **Scene timing:** scene windows come from the VO line layout with gaps of ≥1.8 s between sections; paintings dissolve into each other over the gap; overlays fade out before the dissolve starts.
- **Checks:** measure parallax with optical flow (e.g. OpenCV feature tracking with a forward-backward check, bucketed by layer depth); scan the final file for banding/black frames; step through 1-second clips at layer edges frame by frame.
