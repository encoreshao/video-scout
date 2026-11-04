# Output Format

Create a Markdown report and a JSON catalog. Do not invent unavailable data. Scoring rules live in `quality-scoring.md`; data methods in `data-access.md`.

## Files and location

Save in the user's chosen location. Otherwise use `video-scout-reports/` in the current project:
- `report-YYYY-MM-DD[-slug].md`
- `catalog-YYYY-MM-DD[-slug].json`
- `catalog-index.json` (cumulative dedup index; append, never overwrite)

Never overwrite an existing report; add a numeric suffix if the name exists. If file creation is unavailable, return the report and JSON inline.

## Markdown report

Sections, in order:
1. Discovery date, mode, and filters.
2. Search scope: sources checked, data-access methods used, history checked.
3. Short summary of the selection.
4. Ranked recommendations.
5. Potential short-video segments (only when supported).
6. Rejected or deferred candidates worth knowing about, and items needing manual verification.
7. Limitations and unavailable data.

Each recommendation includes:
- rank and exact title, with a clickable canonical URL (and the alternate URL if any);
- platform, channel/publisher, speaker; publication date; duration; language;
- views/likes/comments/ratings as available, with method and check date;
- adjusted score, grade, confidence, evidence level, coverage;
- a one-sentence rationale and the main uncertainty;
- key ideas;
- transcript/caption availability and language;
- segment suggestions with verified timestamps, if any;
- license/rights signal exactly as stated by the source, or `unknown`;
- `handoff_ready` status.

If fewer videos pass the 70 threshold than requested, return fewer and say why.

## `handoff_ready`

`true` only when all hold: the URL was verified available; captions or a transcript exist with a known language; a canonical URL and `video_id` (where applicable) are recorded. It does not imply the license allows reuse; read `license`.

## JSON schema

Valid JSON. `null` for unavailable scalars; empty arrays when no verified items exist. No comments in JSON.

```json
{
  "schema_version": "1.1",
  "generated_at": "ISO-8601 timestamp",
  "discovery_mode": "topic_free | topic_based | url_review",
  "query": null,
  "filters": {
    "sources": ["TED", "YouTube"],
    "excluded_topics": [],
    "since": null,
    "language": null,
    "duration": null,
    "sort_preference": "quality",
    "requested_count": 10
  },
  "search_coverage": {
    "sources_checked": [],
    "data_access_methods": [],
    "categories_covered": [],
    "candidates_considered": 0,
    "candidates_deep_inspected": 0,
    "historical_deduplication_performed": false,
    "limitations": []
  },
  "videos": [
    {
      "rank": 1,
      "video_id": null,
      "title": "Exact source title",
      "url": "https://canonical-source-url",
      "alternate_urls": [],
      "platform": "YouTube",
      "source_type": "ted | tedx | university | research_org | conference | educational_channel | expert_creator | other",
      "channel_or_publisher": null,
      "speaker": null,
      "published_at": null,
      "duration_seconds": null,
      "language": null,
      "availability": {
        "verified": false,
        "checked_at": null,
        "notes": []
      },
      "metrics": {
        "checked_at": null,
        "source_method": null,
        "views": null,
        "likes": null,
        "comments": null,
        "rating": null,
        "rating_scale": null,
        "comment_quality_observed": null
      },
      "transcript": {
        "available": null,
        "language": null,
        "timestamped": null,
        "auto_generated": null
      },
      "quality": {
        "evidence_level": "metadata_only | transcript | playback",
        "raw_score": null,
        "coverage": null,
        "total_score": null,
        "grade": null,
        "confidence": "low",
        "dimensions": {
          "content_depth_knowledge_value": null,
          "audio_video_production": null,
          "speaker_expertise_credibility": null,
          "presentation_storytelling": null,
          "audience_engagement_comment_quality": null,
          "popularity_signals": null,
          "recency": null
        },
        "structurally_unavailable_dimensions": [],
        "unassessed_dimensions": [],
        "rationale": "",
        "main_uncertainty": ""
      },
      "key_takeaways": [],
      "recommended_segments": [
        {
          "start_seconds": null,
          "end_seconds": null,
          "locator": null,
          "description": "",
          "short_video_potential": "high | medium | low | unknown",
          "reason": "",
          "timestamp_verified": false
        }
      ],
      "license": {
        "status": "known | unknown | needs_verification",
        "label": null,
        "source_url": null
      },
      "handoff_ready": false,
      "notes": []
    }
  ],
  "rejected_candidates": [
    {
      "title": "",
      "url": "",
      "video_id": null,
      "reason": ""
    }
  ]
}
```

`total_score` is the adjusted score from `quality-scoring.md`; `raw_score` is the pre-penalty normalized score.

## `catalog-index.json`

```json
{
  "schema_version": "1.0",
  "updated_at": "ISO-8601 timestamp",
  "entries": [
    {
      "video_id": null,
      "url": "",
      "alternate_urls": [],
      "title": "",
      "speaker": null,
      "status": "recommended | rejected",
      "reason": "",
      "first_seen": "YYYY-MM-DD"
    }
  ]
}
```

## Handoff notes

The JSON is meant to pass selected source videos to a workflow such as `inspire-video`. Preserve the original URL, alternate URLs, and verified segment timecodes. Check `license` before any editing or translation. The catalog is discovery metadata, not authorization to download, edit, or publish copyrighted material.
