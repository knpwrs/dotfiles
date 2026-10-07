# Style preset: data-story

A calm, precise film that tells one clear story with real data: animated bar, line and area charts, maps, rankings and counters, every figure computed from a saved source file and cited on screen. For nonprofit annual reports, thought leadership, analysts and journalists.

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition: measured, clear, neutral narrator; firm falling endings |
| `music` | restrained, light electronic or piano bed with a slow pulse; no vocals |
| `length` | 60–120 s |
| `formats` | `16:9`, `1:1` (charts re-laid for the square) |

## Data discipline

- Pull numbers from the primary source (an API or published table) and save the raw file under `gen/source/` with its URL and retrieval date.
- One data script parses the raw file and writes a figures file (every on-screen value, label, axis range and spoken number); the film and the narration read from it, so no number is typed by hand.
- A separate check script recomputes every figure from the raw file and fails the build on any mismatch between the data, the narration and the screen (including resting values per period and rank in a race).
- State what the data covers (units, geography, years, exclusions) in each chart's footer; say "about" wherever a figure is rounded, and round the screen to match the speech (e.g. two decimals in millions when the narration says "about seven and a half million"). No forecasts, causes or advocacy the data doesn't show.

## Look

- A light, quiet stage (off-white, one huge faint tint shape as the sole ornament) with a serif or grotesk headline that states the chart's point in words ("X passed Y in <year>."), a small uppercase kicker for the measure and range (20–26 px, 0.18 em tracking), and a source footer on every chart.
- Type at 1080p: headlines ≥70 px at 700/800 weight, hero numbers 160–300 px, captions and labels 30–40 px. Force lining figures (`font-variant-numeric: lining-nums tabular-nums`) — many display faces default to old-style numerals.
- One highlight colour per chart for the series the sentence is about; other series in muted tints; direct labels at line ends instead of legends where possible.
- Axes start at zero for bars and areas; light gridlines.
- One chart idea per moment; clear it before the next; stat panels never share the frame.
- Thumbnail: the key chart at its most telling moment + a short headline.

## Chart types and motion

- **Bars:** grow from the baseline with the counter so bar and number always agree; comparisons share one honest zero-based axis. For before → after, the "after" bar sweeps to the earlier mark, then grows on with the counter; growth badges land on the spoken percentage.
- **Ranges, gaps, goals:** a range is a solid bar plus a hatched band; a gap is a dashed outline; a goal is a fill.
- **Lines and areas:** draw on left to right with a leading dot; the value label rides the leading point; annotations (a crossing, a peak) appear as the line reaches them.
- **Rankings / bar-chart race:** positions interpolate smoothly between periods; labels never overlap (see Rankings).
- **Maps:** vector geography, choropleth fills that crossfade between periods, a legend with honest breaks (see Maps).
- **Counters:** drawn from glyph outlines as a function of timeline time, reserving the width of their widest state; the build fails if any state overflows its box or overlaps a neighbouring label or unit.
- All chart geometry is SVG. Hatched or textured fills use user-space patterns and grow by geometry (width/height), since a scaled striped background makes its stripes crawl.

## Maps

- **Shapes:** public-domain vector boundaries (e.g. Natural Earth; for US states the Census Bureau's cartographic boundary files, `cb_<year>_us_state_5m`). The 5m (1:5,000,000) resolution is plenty for a full-frame national map at 4K; 20m is fine below 1080p. Save the file in `gen/source/` with its URL and date like the data. Drop territories unless the dataset's total includes them, and say so in the BRIEF.
- **Project once in Python, not in the browser,** and write path strings, label points and bounds to a geometry JSON the film reads. For a US map use a d3-compatible Albers USA. Lower 48: conic equal-area, parallels 29.5/45.5, rotate 96°, center (−0.6, 38.7), scale 1070 in a 960×500 frame. Alaska: rotate 154°, center (−2, 58.5), parallels 55/65, scale ×0.35, translate (−0.307k, +0.201k). Hawaii: rotate 157°, center (−3, 19.9), parallels 8/18, translate (−0.205k, +0.212k). Wrap longitudes into ±180° after rotation, or the Aleutians fly across the frame. Footer: "Alaska shown at reduced scale." Simplify (e.g. shapely, preserving topology) at about 0.1 frame units — well under a pixel at 4K.
- **Draw:** one `<g transform="translate scale">` per map, regions as `<path>` with a stage-coloured 1–1.2 px border using `vector-effect: non-scaling-stroke` (borders stay crisp at any size and hide simplification slivers). Group outlines are a buffered union of the members (`buffer(+0.25).buffer(−0.25)`) drawn in ink, 2.5 px.
- **Breaks and palette:** fixed classes for every period (one legend for the whole animation; never re-break per period), on round numbers, with zero as a class boundary for change data. Diverging, two hues, CVD-safe (orange arm for decline, blue arm for growth). Validate each arm with the dataviz validator in `--ordinal` mode (one hue, monotone L, light end ≥2:1 on the stage), then the whole ordered list for adjacent CVD and normal-vision separation (≥15). A 5-step arm on a light stage can't pass, so use ≤4 steps per arm; a set that passes on off-white: `#B04F08 #E59447 | #85B3DC #4383C3 #185396 #07254D`. Choose breaks so the top class is the set the narration talks about.
- **Animate by period:** fills are a per-frame pure function of time. Each period's colours land at a time, crossfade from the previous class colour over 0.5 s (RGB lerp is fine at that length), and hold ≥1.2 s (periods 1.6 s apart work). A big period label changes on the same frame. Start from a neutral grey map under the headline number, then colour it on the word that introduces the map. Label colour switches between ink and white per fill by WCAG contrast, crossfading with the fill.
- **Region labels:** short codes in the label sans (16:9: 18 px; 1:1: 15 px at 1080) at each region's pole of inaccessibility (e.g. shapely `polylabel`, plus its inscribed radius). A label sits inside only if its measured glyph box (advance widths + 2 px) fits the inscribed circle at the map's scale; allow one shrink step to 87%, never smaller. Otherwise it becomes a call-out: stack small coastal regions in one column just off the coast, spread to a 1.55×font gap; then swap adjacent slots until no two leader lines cross, and fail the build if any still cross. Island groups get their call-out beside the islands. **Fail the build on any inland call-out** — a label that misses the fit test by half a pixel lands its call-out on a neighbour. Leader dots get a stage-coloured ring so they show on dark fills. On a US state map at these sizes expect call-outs for VT, NH, MA, RI, CT, NJ, MD, DE, DC, HI.
- **Highlighting a claim:** dim the other regions' paths and labels to about 0.3 (a wrapper `<g>` per label, so the per-frame fill code and the dim tween never touch the same attribute), then fade in ink outlines of the named regions on the words that name them.
- **Overlap audit for map labels:** register every label and call-out box in a list checked at build time (no two in a scene within 2 px, all inside a 24 px safe margin). A DOM text audit doesn't see glyphs drawn inside the map SVG. If the reveal audit treats any opacity tween as a reveal, tag dims (e.g. `data: "dim"`) so it skips them.

## Rankings

- **Race lanes:** compute the rank at each whole period and interpolate lane positions between those ranks with the same eased progress as the values, so positions are exact at every period with no near-tie jitter (a continuous "sum of logistic steps" rank wobbles when two values sit 0.1 apart). Candidates are everyone in the top N+2 of any period; rows past the last lane fade out and stay parked just below it (an unparked row drifts off-frame and trips the safe-margin audit).
- **Steps:** about 0.9 s per period (0.28 s hold, 0.62 s eased move), pitch-stepped ticks on each landing and a soft shuffle on each move. Highlight named rows by tweening the bar's CSS `fill` (not the attribute), and dim the rest after the line that names them.
- **Values:** the value label rides its bar's end and interpolates with the bar during the move, resting on the published value at every period. A label that snaps to the next period while lanes are still moving makes still frames look mis-sorted.
- **No label overlaps while lanes cross:** a row that changes lane between two periods hides its name and value from 20% to 80% of the move (crossing rows are under 0.6 of a lane apart there) and fades them back as it lands; rows that keep their lane stay labelled. Fade fully — 0.15–0.3 opacity still shows ghosted labels stacked on each other. The overlap audit exempts race rows only while lanes move.
- **Decline / diverging bars:** a separate chart with its own zero-based axis covering only the negative range, bars growing leftward from the zero line, names right of the axis, values at the bar ends. Colour each bar with its map class so legend and chart agree.
- **Share call-out:** a full-width track = the total; the part's segment grows to its share, both segments are labelled inside ("<Part> nn.n%", "Rest nn.n%"), with the absolute numbers underneath.

## Sound

- Soft ticks for bars and points (pitch-stepped along a series), a gentle swell under a key reveal, soft sweeps for growing bars; soft swells rather than zips under money figures (zips read as a cash register).
- Hold the music ≥13 dB (RMS) under the voice on every line with adaptive, per-line ducking (a static duck leaves some lines too close).
- To land the cue's final hit on the end card, time-stretch with pitch kept, or delay the cue's entry if no pitch-preserving stretch filter is available.
- Lines that end on a number ("…eight percent.") often devoice the last word, and a pitch tracker then reads the stressed number as a rise. Check the contour by hand and with a focused single-file listen before regenerating.

## Verify

- The figure check passes; frames of every chart mid-growth and settled; no counter overflows its box; source footer present on every chart.
- Map and race overlap audits pass in every format; snapshot each race mid-move.

## Limits

- Untested with county or world maps, proportional-symbol / bubble maps, small multiples, a race with more than 10 lanes or over 10 periods, 9:16, and a dark stage.
