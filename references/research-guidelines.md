# Research Guidelines

## Topic-free discovery

When the user provides no topic:
1. Search broadly across multiple subject areas.
2. Rotate categories to avoid repeatedly surfacing the same niche.
3. Consider AI/technology, science, business/startups, design/creativity, psychology, leadership, history/society, education, and practical skills.
4. Mix recent discoveries with evergreen talks.
5. Do not force a category quota if quality candidates are unavailable.
6. Avoid near-duplicates and over-representing a single channel (no more than 2 per channel/speaker unless the user asks).

## Topic-based discovery

Expand the requested topic into:
- adjacent concepts and subtopics;
- practical questions and use cases;
- relevant experts, institutions, and research groups;
- different formats such as talks, lectures, interviews, explainers, and demonstrations.

Search for original, complete sources wherever possible.

## Source preference

Prefer:
1. Original talks and uploads from TED/TEDx (official channels or ted.com).
2. Universities, research labs, conferences, and recognized professional institutions.
3. Established educational channels and identifiable subject-matter experts.
4. High-quality independent creators with transparent credentials and sourcing.

A famous platform or publisher does not automatically make every video high quality. TEDx events in particular vary widely; check the speaker, not just the label.

## Search funnel and budget

Follow the funnel in `data-access.md` (about 30–50 candidates, cheap metadata filter, deep inspection of about 12–15, report 5–10). Comment sampling is optional and should be done only for finalists.

## Candidate evidence checklist

For each candidate, capture:
- canonical URL, alternate URLs, exact title;
- source/channel and speaker;
- publication date and duration;
- available views, likes, comments, ratings, and the method/date used to get them;
- transcript or captions availability and language;
- expertise/provenance evidence;
- content and production observations;
- license/rights signals (as stated by the source);
- evidence level, score, confidence, and limitations.

Do not fabricate unavailable fields.

## Low-quality and risky content to screen out

Reject or strongly penalize, when observable from metadata, transcript, or playback:
- **AI-generated or faceless content farms**: synthetic voice-over over stock footage, generic scripts, no identifiable expert, mass-produced channel catalogs.
- **Recycled content**: reuploads, compilations, clip channels, and reaction videos when the original is available.
- **Sponsored or affiliate-driven content** presented as neutral advice; undisclosed conflicts of interest.
- **Misleading titles/thumbnails**, unverifiable claims, health/finance/legal advice without credentials or sources.
- **Outdated claims** in fast-moving fields (AI, medicine, policy, security): check whether the video's central claims still hold.
- **Mostly promotional** content with little educational value.
- Language/caption mismatch with the user's request.

Poor audio or resolution counts only when actually observed. Do not reject on suspicion alone; mark "needs manual verification".

## Availability

Verify each recommended URL as described in `data-access.md` (public, not deleted, not live/members-only/age-restricted/region-blocked where detectable).

## Comments (optional)

If comments can be inspected cheaply:
- sample a spread (top/relevant plus a few recent);
- look for substantive questions, corrections, experience-sharing, and discussion;
- distinguish these from spam, jokes, promotion, and fan reactions;
- do not quote usernames or expose personal details.

If not inspected, mark comment quality `N/A`.

## Short-video segment suggestions

Only suggest timestamps supported by video playback, a transcript with reliable timestamps, or trustworthy chapter markers.

Prefer a segment with a clear hook, one coherent idea, and a satisfying takeaway, roughly 20–90 seconds when the source allows. Do not force every video to have a candidate. Never invent timecodes or quote wording.

## Historical deduplication

Convention: reports are saved in the output directory (default `~/.video-scout/`) together with a cumulative `catalog-index.json` listing every video previously recommended **or rejected**, with `video_id`/URL, title, speaker, and date.

Before searching:
1. Look for `catalog-index.json` (and any previous `catalog*.json` / report files) in the output directory or a user-given path.
2. If found, load it and exclude by canonical URL, video ID, alternate upload, and same-talk clips.
3. Compare title and speaker as well for alternate uploads.
4. Avoid repeating prior picks unless the user asks or there is a meaningful reason to revisit. Do not re-evaluate previously rejected candidates unless the user asks.

After producing results, append the new picks and rejected candidates to the index. Do not overwrite existing reports.

Do not claim historical deduplication was performed if no history was found. Set `historical_deduplication_performed` to `false`.

## Report quality

Be selective. Explain why each video is worth the user's time. Link sources used to verify factual claims. Clearly separate verified facts from editorial judgment.
