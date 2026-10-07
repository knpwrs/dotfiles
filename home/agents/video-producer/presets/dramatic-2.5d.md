# Style preset: dramatic-2.5d

A serious, cinematic narrative explainer: painted scenes with real depth, slow camera moves through the layers, atmosphere, and scripture or key phrases set as elegant typography in the space. Dramatic narrative devices and short, weighty set-piece lines are welcome. For sermon and Bible-teaching films, church history, and long-form narrative explainers.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition for a British scholarly documentary narrator, one fixed direction for every line: "Speak with a refined British Received Pronunciation accent (British vowels throughout, e.g. a rounded short o in 'God'), in a slightly deeper, lower, fuller chest register, as a scholarly documentary presenter: serious, grave and measured, yet warm and welcoming, a storyteller drawing the listener in; unhurried natural pacing; every declarative sentence ends with firm, falling intonation." To change a voice's register, re-perform with a new direction; never pitch-shift |
| `music` | orchestral cues (strings, low brass, piano, sparse choir), several cues placed per section; time-stretch lightly so a cue's hit lands on a set-piece line; transcribe every cue locally and reject any with sung or spoken words |
| `length` | what thorough treatment needs (often 5–15 min) |

## Look

- Painterly, Rembrandt-lit oil style; cohesive palette and light direction per scene; film grain and vignette.
- Every scene gets its own composition; no painting is reused anywhere in the film.
- Typography: scripture in an old-style italic (e.g. EB Garamond italic), references in gold engraved small caps (e.g. Cormorant SC), set word by word on aligned times.
- Highlights: the highlight colour applies to letters only (quotes, commas, periods and dashes keep the base colour); a highlighted phrase stays on one line (re-balance line breaks); highlight whole meaningful phrases, several per long verse when it helps.
- Thumbnail: a single striking painted frame, or a split frame of two contrasting scenes, with a short thesis in the gold small caps (e.g. two opposing phrases, one per side, with the verse across the top).

## Layers built for parallax

Generate each scene as separate, complete layers; never cut layers out of a finished painting (that produces detached heads, split handles, stretched surfaces):
1. **Far background**, full-frame and opaque, with no foreground objects, from the model that wins the bake-off for painterly detail and architecture.
2. **One or two midground layers** and **a foreground layer** as whole, intact objects on transparent backgrounds (from the model that wins for clean cutouts), each generated with the scene's background as the style/lighting reference so they composite as one painting: entire figures including heads, whole jugs with handles, whole lamps.
3. Mid/foreground layers sit flat at a single depth (no mesh displacement, so no stretching); the background may take only a gentle, heavily smoothed depth ramp. Remove pale glow fringes on cutouts; scale any layer that touches a frame edge so its edge never enters the frame. Every layer is complete, so nothing is ever uncovered and no hole filling is needed.

## Camera and motion

- One continuous, eased camera move per scene in a single direction (lateral + slight rise + a dolly-in where near layers grow and far ones don't); ramps of ~1.5 s at each end, constant between; directions alternate from scene to scene.
- Parallax must be clearly measurable: near layers move several times faster than far (≥ 3×, ideally ≫).
- Atmosphere on its own planes: fog between depth layers, dust in front, light rays.
- Scene windows come from the VO line layout with gaps of ≥ 1.8 s between sections; paintings dissolve into each other over the gap.

## Renderer

- One shared WebGL2 canvas (`preserveDrawingBuffer: true`) under the HTML text layer, redrawn on every seek from the timeline time (never a free-running animation loop).
- Each scene's layers are textured quads drawn far → near with premultiplied alpha. Each layer has a depth weight `w` (far 0 → near 1, normalised per scene from its depth range).
- Camera at time `t` is a pure function of the scene's eased progress: screen offset = `pan · w` (plus `rise · w`), scale = `1 + push · w` (far layers stay still and unscaled, near ones travel and grow), with per-layer overscan so edges never show.
- Fog quads are drawn between layer indices; dust and light rays are HTML/CSS planes in front.
- Loading: preload and decode every texture before the first capture (wait on `img.decode()`), never build a texture from an unloaded image, keep at most two scenes' textures resident, skip mipmaps, and on out-of-memory free textures and retry.

## Scene containment

Every overlay (text, cards, props) is fully gone before the next scene's dissolve begins; dissolves are painting-to-painting only. Dump an element → scene window → in/out table from the build and check every transition has zero violations.

## Sound

Synthesised low booms under set-piece lines, soft hits on cards, whooshes on dissolves, ambient wind/fire beds; music ducked under the VO.

## Verify

- Parallax: measure with optical flow on representative scenes (e.g. OpenCV feature tracking with a forward-backward check, bucketed by layer depth; median px/s at 1920 width over 3 s, near vs far bands).
- Scan the final file for banding, glitches and black frames; step through 1-second clips at layer edges frame by frame.
