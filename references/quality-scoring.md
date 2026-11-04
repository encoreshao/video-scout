# Quality Scoring

Single source of truth for the rubric, weights, adjusted score, grades, and confidence. `SKILL.md` refers here instead of repeating the numbers.

## Principle

Rank by demonstrated video quality and knowledge value. Popularity is a discovery signal, not a proxy for quality.

## Evidence levels

Every score is tied to the deepest inspection actually performed. Record it as `evidence_level` in the catalog.

| Level | Meaning |
|---|---|
| `metadata_only` | Title, description, channel, metrics, search snippets. |
| `transcript` | Transcript or captions were read (fully or in substantial part). |
| `playback` | Video/audio was actually inspected with a tool that exposes it. |

Never claim a higher level than was reached.

## Weighted rubric

Score each dimension 0–10. Contribution is `(score / 10) × weight`.

| Dimension | Weight | Required? |
|---|---:|---|
| Content depth and knowledge value | 30 | **Yes** |
| Audio/video production quality | 25 | No (needs playback; see below) |
| Speaker expertise and credibility | 15 | **Yes** |
| Presentation and storytelling | 10 | No (needs transcript or playback) |
| Audience engagement and comment quality | 10 | No |
| Popularity signals | 5 | No |
| Recency | 5 | No |
| **Total** | **100** | |

A candidate without both required dimensions assessed is **not rankable**: list it as "needs manual verification" instead of scoring it.

### Scoring anchors

- 0–2: Very weak, misleading, unusable, or no supporting evidence.
- 3–4: Below average; limited substance or significant quality issues.
- 5–6: Competent; useful but with notable limitations.
- 7–8: Strong; clear value and good execution.
- 9–10: Exceptional; unusually insightful, rigorous, polished, or authoritative.

Scores tend to cluster at 8–9. Reserve 9–10 for videos you could defend as the best available on the subject, and use the full range. If three videos in a run all score 9 on content depth, re-check whether you are discriminating.

## Computing the adjusted score

1. **Assessed dimensions.** Drop any dimension that could not be assessed.
2. **Raw score.** Normalize over the assessed weights:
   `raw = 100 × Σ(score/10 × weight) / Σ(assessed weights)`
3. **Structurally unavailable vs. unassessed.** Distinguish why a dimension is missing:
   - *Structurally unavailable*: the platform does not expose it (e.g. TED pages rarely expose comparable views/likes/comments; no public YouTube star rating). Exclude from both the raw score and the coverage calculation. **Do not penalize TED for what TED does not publish.**
   - *Unassessed*: the platform exposes it but the agent did not or could not check (e.g. YouTube comments not read, no playback tool). These reduce coverage.
4. **Coverage.** `coverage = Σ(weights of assessed dims) / Σ(weights of dims that are not structurally unavailable)`
5. **Adjusted score.** `adjusted = raw − 10 × (1 − coverage)`
6. **Evidence cap.** If `evidence_level` is `metadata_only`, cap adjusted at **79** (cannot exceed "Good"). If `transcript` without playback, no cap, but production quality should be `N/A` or conservatively scored.

Rank by adjusted score, then confidence, then content-depth score.

### Production quality (25%)

Score only with `playback`, or from reliable proxies the source explicitly exposes (e.g. a stated max resolution plus clear audio noted in a transcript quality flag). Otherwise mark `N/A` (unassessed); this lowers coverage and the evidence cap applies. Never infer from a thumbnail.

What to inspect: speech intelligibility and stable levels; noise, clipping, echo; image clarity, lighting, framing, stability; readability of slides and on-screen text; editing and pacing where relevant. Production quality is not production budget. A clean lecture recording can score highly.

### Content value

Specific ideas rather than generic motivation; evidence, examples, demonstrations, transparent reasoning; originality and depth; separation of fact, hypothesis, opinion, and prediction; lasting value after watching.

### Engagement and popularity

- Use views, likes, comment counts, and ratings only when verifiably available, and note the check date.
- Interpret counts against video age, channel size, and platform. Never compare raw views across platforms.
- Comment count is not comment quality. Judge comment quality only after sampling comments; otherwise `N/A`.

### Recency

Score only when freshness matters (fast-moving fields such as AI, medicine, policy, security, markets). For evergreen subjects mark it structurally unavailable (excluded), so older talks are not penalized. For fast-moving fields, also check whether the video's factual claims are now outdated.

## Grades

| Adjusted score | Grade | Use |
|---|---|---|
| 90–100 | Exceptional | Recommend |
| 80–89 | Excellent | Recommend |
| 70–79 | Good | Include only if useful and the list needs it |
| < 70 | Exclude | Do not pad the list. Return fewer than the requested count and say so |

These are editorial grades, not objective platform ratings.

## Confidence

- **high**: `playback`, or full-transcript reading, **and** coverage ≥ 0.85.
- **medium**: `transcript` evidence, or coverage ≥ 0.6.
- **low**: otherwise (typically `metadata_only`).

Report assessed vs. unavailable vs. unassessed dimensions, coverage, evidence level, and confidence next to every score. Do not present a metadata-only score as equivalent to one based on transcript and playback.
