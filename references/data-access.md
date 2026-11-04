# Data Access

How to obtain candidate metadata. Use the best available method and record which one supplied each fact. These methods read **metadata and captions only**. Do not download or store video or audio files.

Prefer tools already present in the environment. Do not install software or ask for credentials without the user's consent. Keep API keys outside the skill directory.

## Fallback ladder

Try in order; stop at the first that gives reliable data for the field you need.

| Need | 1st choice | Fallback |
|---|---|---|
| Discover candidates | Web search with several query formulations, `site:ted.com/talks`, `site:youtube.com` | YouTube search pages, channel/playlist pages of credible publishers |
| YouTube metadata (title, channel, date, duration, views, likes, comments, chapters) | YouTube Data API v3 `videos.list` (`snippet,contentDetails,statistics`) if a key is configured | `yt-dlp --dump-json --skip-download <url>` if installed; then the watch page via a fetch tool; then oEmbed (title/channel only) |
| YouTube captions | `yt-dlp --skip-download --write-subs --write-auto-subs --sub-langs "en.*,zh.*" --sub-format vtt` to a scratch directory | Transcript shown on the watch page; note that auto-captions are lower reliability |
| TED/TEDx metadata and transcript | The `ted.com/talks/<slug>` page (title, speaker, date, duration, transcript, language list) | The talk's YouTube upload on the official TED / TEDx channel |
| Comments (optional, costly) | YouTube Data API `commentThreads.list`, or `yt-dlp --write-comments` | Skip and mark comment quality `N/A` |
| Playback inspection | Only if a tool genuinely exposes audio/video (e.g. frame sampling plus an audio quality probe) | Otherwise `evidence_level` stays at `transcript` or `metadata_only` |

Do not use third-party "view count" aggregators or scraped stat sites as the metric source. If the only metric source is unofficial, mark the value `null` with a note.

## Canonical URLs

- TED talks exist on ted.com and on YouTube. Use the **ted.com** page as `url` when it exists, and store the YouTube URL in `alternate_urls`. Many downstream tools need the YouTube URL.
- YouTube: use `https://www.youtube.com/watch?v=<id>` with no tracking parameters. Resolve `youtu.be` and playlist-context URLs.
- Store `video_id` for YouTube.

## Availability checks (before recommending)

Confirm the URL resolves and the video is: public (not private/unlisted-only unless the user supplied it), not deleted, not live or premiere-pending, not members-only, not age-restricted, and not region-blocked where detectable. If you cannot verify, say so under `notes`.

## License and rights signals

Collect only what the source states, and quote the label, not a legal conclusion:

- YouTube: the "Creative Commons Attribution license (reuse allowed)" label in the description area, or `status.license` from the Data API (`creativeCommon` vs `youtube`).
- TED: the license/terms shown on the talk page or TED's terms. TED talks have historically been offered under a Creative Commons non-commercial, no-derivatives license for sharing, which does not generally permit editing or translating clips. Verify the current terms on the page and record the exact wording and URL.
- Everything else: `unknown`.

A permissive-looking label is not permission. The catalog is discovery metadata.

## Effort budget

Deep inspection is expensive, so use a funnel:

1. Gather roughly 30–50 candidates from varied queries and sources.
2. Cheap filter on metadata: provenance, duration, availability, obvious gate failures, duplicates.
3. Deep-inspect about 12–15 (transcript at least; comments optional; playback if available).
4. Score and report the top 5–10.

For `--top N` above 10, scale the funnel accordingly but do not lower the bar.
