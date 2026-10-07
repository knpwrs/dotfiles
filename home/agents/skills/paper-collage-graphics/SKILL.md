---
name: paper-collage-graphics
description: Make social-media graphics (PNG posts, stories, thumbnails, banners) in the hand-made cut-paper collage style — taped paper cards, torn strips, ink stamps, handwriting, cut-paper props — with the paper-collage-kit. Use when the user asks for a "paper-collage post / graphic / story / thumbnail / announcement / quote card / verse card / event graphic / stat graphic" or any social graphic "for Let's Church" or "in the paper collage style", in one or many formats. Not for videos (use video-producer with the paper-collage preset).
---

# Paper-collage graphics

The kit lives at `/Users/knpwrs/Workspace/oscilar/oscilarvideo/paper-collage-kit/` (called KIT below).
Its `README.md` is the reference for the spec format, every template's fields, themes, formats, images
and the layout check. Read it before writing your first spec in a session.

A post is one JSON/YAML spec → `node tools/render.mjs <spec>` → PNGs for every format in `KIT/out/<id>/`.

## Steps

1. **Pin down the content.** Get the message, the brand (theme `lets-church`, `neutral`, or a new theme)
   and the formats (default: all six — square, portrait, story, landscape, landscape-hd, youtube).
   Gather every claim from a source (the user, the brand's site or materials, `posts/*.json` sources);
   never invent numbers, features, dates or quotes. Ask when a needed fact is missing.
   *Done when* each text field is either given by the user or traced to a source you can name.

2. **Choose a template** (fields in the README): `announcement` (news, a feature), `promo` (headline +
   label + mascot), `stat` (1–3 numbers), `event` (title + date/time/place), `list` (3–5 items),
   `quote` (exact words + attribution), `before-after`, `verse` (Scripture). Start from the closest
   example in `KIT/posts/`. Keep copy short: headline ≤ ~6 words, a 2–4 word handwritten aside, one label.

3. **Write the spec** in `KIT/posts/<id>.json` (or next to the user's files), with a `sources` list.
   Images: `prop:<name>` from `KIT/assets/props/`, `mascot:<pose>` (Let's Church: Wendell — default,
   wave, cheer, heart, listen, magnifier, point, scissors, think, basket), or a file path.
   *Done when* the template's required fields are set and every claim has a source entry.

4. **Render and check:** `cd KIT && node tools/render.mjs posts/<id>.json` (add `--formats a,b`,
   `--scales 1` for a quick pass). The command fails (exit 1, `-FAILED.png`) on clipped, covered,
   overlapping, off-canvas, out-of-safe-area or low-contrast text, a missing font, a missing required
   field, or a Scripture mismatch. Fix the copy (shorter words, fewer lines) or the spec — never
   loosen the check. `--debug` draws ink boxes and the safe area.
   *Done when* every requested format passes.

5. **Look at every PNG yourself** (open the 1× files; `node tools/contact-sheet.mjs` for an overview).
   Check hierarchy, legibility at phone size, that nothing important sits under platform UI, and that
   the composition suits each format. Re-render after changes.
   *Done when* you have viewed each format and would post it.

6. **Report** the output paths (1× for preview, `@2x` for upload), the spec path, and any claim or
   image that needs the user's confirmation.

## Content rules

- Claims only from sources; quotations exact and attributed (author + work/date when known).
- Scripture: follow `~/.agents/video-producer/guides/christian-content.md`. Use the translation the user
  names (default BSB), quote exactly (the render verifies against bible.helloao.org and caches the
  chapter in `KIT/sources/`), mark partial verses with `…`, cite the reference on the card.
- No depictions of God or Christ in any image or prop (no figures, faces, hands, silhouettes, a dove
  for the Spirit, a person standing in for God); crosses empty. Use objects (open book, sprout, sheaf).
- Let's Church marks (wordmark, Wendell, "Good News. No Ads.") are for Let's Church posts only.
  Real churches or people appear only as in their own public material; flag anything needing permission.

## Extending

- New brand: copy `KIT/themes/neutral.json`, add fonts to `assets/fonts/` and art to `brands/<brand>/`
  (README → "Themes").
- New art: reuse `assets/` and `asset-pack/` first. If truly needed, `tools/gen-image.py` (OpenRouter;
  key from env or `.env`, never print it; check `/api/v1/credits` and the user's budget first; costs go
  to `gen/cost-log.jsonl`), then `tools/prep-generated.py`. One object per image, no text in the art.
- New template or component: README → "Components"; run `npm run selftest` after touching `engine/check.js`.
- Files for other tools (Canva, Figma): `KIT/asset-pack/` (textures, torn paper, tape, stamps, badges,
  doodles, overlays, props, palette sheets, style guide, licences).
