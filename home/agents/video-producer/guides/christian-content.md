# Content guide: Christian and Scripture content

Apply this guide whenever the subject is Christian (Scripture, theology, churches, ministries).

## Scripture

- Translation: the one the user names; if none, use the translation the source material uses, or ask.
- Quote exactly — every word, punctuation mark and the translation's capitalization (LORD, pronouns). Verify every quotation against the translation's published text (e.g. a public Bible text API such as `https://bible.helloao.org/api/<TRANSLATION>/<BOOK>/<chapter>.json`), keep a copy in `gen/source/`, and make the build fail if an on-screen quote differs. When a speaker reads a verse in their own wording, caption what they said and don't label it with the translation. Mark partial verses with an ellipsis; keep an unmatched quotation mark when the translation's quote continues into the next verse, and flag it.
- Cite every passage on screen. When a reference is spoken, use the compact form — book, chapter, verse, without the words "chapter" and "verse": "Matthew ten eight", "Second Corinthians nine fifteen" (write the TTS text in words). Credit the translation on the end card and in descriptions.
- Quote confessions and books against their original text; don't cite scholars unless asked.

## Second commandment (2CV)

For Reformed audiences in particular, audit every image, layer, prop, silhouette and metaphor (at full resolution, as layers and as composites) so nothing could be read as an image of God:

- No depiction of Christ in any form: no figure, face, silhouette, body on a cross, shadow, hands, feet, robe, or a figure standing in for Him. Crosses are empty (verify at full resolution). Show appearances of the risen Christ as shapeless light (e.g. the Damascus road: a glare with only Saul visible; no rimmed ellipse, cloud column or figure-like form in the light).
- No depiction of God the Father or the Holy Spirit: no figures, hands from the sky, eyes, faces in clouds, figure-like light columns, or a dove used as the Spirit.
- No human stand-ins for God or Christ: when the narration makes an image stand for God (the potter of Romans 9, a shepherd, a king on a throne, a master of the house) or Christ (the hen of Matthew 23:37, the bread of life), show objects or empty settings instead — an unattended wheel, an empty throne, an empty road. Never illustrate a simile with a person.
- Watch incidental figures in landscapes (a lone robed walker, onlookers, fishermen) and in third-party thumbnails or artwork shown on screen — remove, crop or blur any that could be read as Christ.
- Ordinary humans in the narrative (Joseph, his brothers, Pharaoh, Pilate, soldiers, Saul, crowds, believers) are fine.
- Record every change and every borderline call in `gen/AUDIT-2CV.md` for the user to judge.

## Churches and ministries

Real churches, ministries and people appear only as they appear in their own public material; flag anything that needs permission before public release.
