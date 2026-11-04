# video-scout

A [Claude Code](https://claude.com/claude-code) skill that finds, evaluates, and ranks high-quality public videos from TED/TEDx, YouTube, universities, and other reputable sources. It discovers videos only; it never downloads or edits them.

## Install (one line)

```bash
git clone --depth 1 https://github.com/encoreshao/video-scout ~/.claude/skills/video-scout
```

Restart Claude Code, then run `/video-scout`. To update later: `git -C ~/.claude/skills/video-scout pull`.

To install for one project only, clone into `.claude/skills/video-scout` instead.

## Use

```text
/video-scout                          # topic-free: a diverse shortlist
/video-scout "AI agents"              # best videos on a topic
/video-scout "startup strategy" --top 15
/video-scout --source ted             # TED/TEDx only
/video-scout --exclude "politics, celebrity"
/video-scout --sort trending --since 2026-10-01
/video-scout https://www.youtube.com/watch?v=VIDEO_ID   # evaluate one video
```

Plain English works too: "find me good talks about creativity".

| Flag | Meaning | Default |
|---|---|---|
| `--top N` | Number of results (fewer if fewer meet the quality bar) | 10 |
| `--sort` | `quality`, `popularity`, `engagement`, `trending`, `recent` | `quality` |
| `--source` | `youtube`, `ted`, `all` | `all` |
| `--since` | Publication-date filter | none |
| `--language` | Preferred spoken language | none |
| `--duration` | `short` (<10 min), `medium` (10–30), `long` (>30) | none |
| `--exclude` | Topics, people, or channels to skip | none |

## Optional setup (better data)

It works out of the box using web search and page fetches, but coverage is better with either of these:

```bash
brew install yt-dlp        # or: pip install yt-dlp
export YOUTUBE_API_KEY=... # optional, YouTube Data API v3
```

With neither, more metrics show as `N/A` and scores are capped at "Good" because they rest on metadata only. Keep API keys out of this folder, and never commit them.

## What you get

Files are written to `video-scout-reports/` in your project and never overwrite earlier ones:

- `report-YYYY-MM-DD.md`: the readable shortlist with links, scores, and reasons.
- `catalog-YYYY-MM-DD.json`: structured data for other tools, including `handoff_ready`.
- `catalog-index.json`: videos already recommended or rejected, so later runs don't repeat them.

## How videos are ranked

Quality first, popularity last. Seven weighted dimensions: content depth (30), production quality (25), speaker credibility (15), presentation (10), engagement (10), popularity (5), recency (5). Missing data is never guessed, and every score shows its evidence level and confidence. Videos scoring below 70 are excluded. Details: [`references/quality-scoring.md`](references/quality-scoring.md).

## Good to know

- Metrics and captions are read only. Nothing is downloaded.
- Licenses are reported only as stated by the source, otherwise `unknown`. Check them before editing or translating anything. TED talks in particular often carry no-derivatives terms.
- To make short videos from a result, pass its URL to a separate tool such as [`inspire-video`](https://github.com/encoreshao/inspire-video/).

## Repository layout

```text
SKILL.md                      skill entry point
references/data-access.md     how metadata, captions, licenses are fetched
references/quality-scoring.md rubric and adjusted score
references/research-guidelines.md  discovery and screening rules
references/output-format.md   report layout and JSON schema
evals/test-prompts.md         manual check prompts
```

## License

[MIT](LICENSE)
