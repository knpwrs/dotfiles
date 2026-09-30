# Style preset: isometric-explainer

A clean B2B architecture explainer: one coherent isometric world of blocks and conduits showing how a product or system works end to end — data flowing in, being processed, decisions or outputs flowing out — with a smooth camera moving stage by stage. Crisp, precise, on-brand; built for technical buyers.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | `audition` — confident, clear, warm, modern American narrator (either gender), one fixed direction for every line (conversational, firm falling intonation); pick on objective measures plus an order-swapped listen |
| `music` | minimal, confident electronic/ambient bed with a subtle pulse, no vocals, carved out of the voice band and ducked |
| `length` | 75–120 s |
| `palette` / `branding` | the client's brand kit (see Brand) |
| `thumbnail` | a wide isometric hero frame + the logo, an eyebrow label and a short headline in the brand fonts |

## Brand

- Load the client's brand guidelines first (colours, fonts, logo files, tone). Use the official logo files only — never redraw, recolour, stretch, or separate mark from wordmark.
- Colour: mostly the brand's neutrals, one general accent colour, and domain/use-case colours only on the objects that belong to that domain.
- Typography: the brand's typefaces (download OFL/Google Fonts versions into `assets/fonts`); eyebrow labels in the brand's style (e.g. uppercase mono in the accent colour).

## Honesty on screen

- Every claim, number, integration, certification and product name comes from the client's own site or materials — list each with its source URL in `BRIEF.md`.
- No customer or partner names/logos and no outcome statistics unless the client provides them with permission.
- Illustrative UI data (case IDs, scores, summaries, prompts) is obviously placeholder and labelled "ILLUSTRATIVE EXAMPLE" on screen.
- Spell out numbers, units and acronyms in the narration text the way they should be spoken ("three hundred sixty-degree view", "A-M-L", "SOC two", "I-S-O twenty-seven-oh-oh-one"), while the screen shows the written form (360°, AML, SOC 2).

## The world

- One SVG world in true 2:1 isometric: x is the flow axis, y lateral, z height; projection `[(x − y)·u, (x + y)·u/2 − z·h]` with `h ≈ 1.22·u`. Vector geometry and web fonts only — no raster art — so any render size up to 4K is crisp at no cost.
- Blocks: three faces shaded from brand neutrals (top lightest, right darkest), a hairline top edge, one soft blurred ground shadow. Depth-sort everything back to front; split rings/loops into far and near halves so they pass behind blocks correctly.
- Layer order: floor → shadows → conduits → ground packets → blocks → floating effects → labels and UI (topmost). A block hides any conduit or packet on the ground behind it.

## Conduits and packets

- Each route is one continuous path (round joins and caps), running along grid axes and ending at the visible face of the block it feeds, at port height — never behind or across a block.
- Draw the whole network in two passes — every outline first, then every inner fill on top — so bends, T-junctions and shared runs merge into one clean channel with no seams.
- Routes draw on with dash offsets. A packet may exist on a route only after that route has fully drawn; emission from a block starts only once its outgoing conduit is complete (make sending on an undrawn route an error). Packets always travel along a conduit, never over bare floor, and stop/fade at the destination port.
- Pooled glowing packets move at constant speed and keep flowing once a route is built, so the world stays alive.

## Camera

- The camera is the SVG `viewBox` only, driven by GSAP `fromTo` tweens that never overlap.
- Frame each stage by fitting its blocks' projected bounding box into a screen rectangle that keeps clear of the stage-title card and any UI-card column; balance the composition (no content crammed into a corner or cut by the frame edge).
- One eased move per stage (1.2–2.3 s, scaled by distance), then a slow 3–5% push that ends exactly when the next move starts; end with a pull-back to the whole world.

## Labels, titles and UI

- Billboard tags live in the topmost layer; guide/leader lines stop at a label's edge, never run through it.
- Labels that move with the world are pre-outlined glyph paths (the brand fonts' outlines with pair kerning) placed in world coordinates under the same camera — live SVG/HTML text is hinted and pixel-snapped by the browser and visibly "dances" during camera moves. Size tags for legibility at the smallest render (≈15–16 px at 1080p; scale up for 720p proxies).
- Stage titles: an eyebrow + title on a white card, one element per stage, measured to its text and unrolled with `scaleX`; fade text out rather than sliding it out of clip boxes; never show a title clipped.
- UI cards (decision card, score gauge, queue, policy editor) in the client's product look (e.g. white, 8 px radius, no border or shadow), screen-anchored through the stage camera.
- Build-ups (blocks dropping, connections drawing, counters, tags, typing) land on aligned narration word times, visible ~70 ms before the word.

## Sound

- The timeline registers its own SFX cues and a headless page dump exports them to the mixer.
- A synthesised UI kit (ticks, blips, pops, chimes, whooshes, zips, locks) with 3 round-robin variants per kind; pitch-step every sequence (sources connecting, layers stacking, packets arriving, counters); typing and ticks soft (≈ −30 dB under the voice); a whoosh on each camera move.

## Verify

- Snapshot every stage settled and mid-move at 4K; zoom into conduit junctions, block/conduit intersections and labels.
- Measure label jitter against the labelled block during a camera move (it should sit at the rigid-block noise floor).
- Treat AI reviewer findings as leads; check each against frames and waveforms before acting.
