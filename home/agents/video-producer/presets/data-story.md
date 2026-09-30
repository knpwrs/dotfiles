# Style preset: data-story

A calm, precise film that tells one clear story with real data: animated bar, line and area charts, maps, rankings and counters, every figure computed from a saved source file and cited on screen. For nonprofit annual reports, thought leadership, analysts and journalists.

*Builds on the keynote preset's Data rules and the EIA electricity sample (`videos/samples/eia-electricity-story/`); read that project's `gen/data.py` and `gen/figcheck.py` for the working pattern.*

## Defaults this preset sets

| Parameter | Default |
|---|---|
| `voice` | audition: measured, clear, neutral narrator; firm falling endings |
| `music` | restrained, light electronic or piano bed with a slow pulse; no vocals |
| `length` | 60–120 s |
| `formats` | `16:9`, `1:1` (charts re-laid for the square, not cropped) |
| `thumbnail` | the key chart at its most telling moment + a short headline |

## Data discipline

- Pull numbers from the primary source (an API or published table), save the raw file in `gen/source/` with its URL and retrieval date, and compute every on-screen and spoken figure from it in code; never type a number by hand.
- A check script recomputes every figure from the raw file and fails the build on any mismatch between the data, the narration and the screen.
- State what the data covers (units, geography, years, exclusions) in each chart's footer; say "about" wherever a figure is rounded; no forecasts, causes or advocacy the data doesn't show.

## Look

- A light, quiet stage (off-white, one faint tint shape) with a serif or grotesk headline that states the chart's point in words ("Gas passed coal in 2016."), a small uppercase kicker for the measure and range, and a source footer on every chart.
- One highlight colour per chart for the series the sentence is about; other series in muted tints; direct labels at line ends instead of legends where possible.
- Axes start at zero for bars and areas; light gridlines; tabular lining figures.

## Chart types and motion

- **Bars:** grow from the baseline with the counter so bar and number always agree; comparisons share one honest axis.
- **Lines and areas:** draw on left to right with a leading dot; the value label rides the leading point; annotations (a crossing, a peak) appear as the line reaches them.
- **Rankings / bar-chart race:** positions interpolate smoothly between periods; labels never overlap (reserve lanes).
- **Maps:** vector geography (public-domain Natural Earth or US Census shapes), choropleth fills that crossfade between periods, a legend with honest breaks.
- **Counters:** drawn from glyph outlines as a function of timeline time, reserving the width of their widest state.
- All chart geometry is SVG; hatched or textured fills use user-space patterns and grow by geometry (never scale a textured background).

## Sound

- Soft ticks for bars and points (pitch-stepped along a series), a gentle swell under a key reveal; music ducked ≥13 dB under the voice; −14 LUFS.

## Verify

- The figure check passes; frames of every chart mid-growth and settled; no counter overflows its box; source footer present on every chart.
