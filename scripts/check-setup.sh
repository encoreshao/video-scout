#!/usr/bin/env bash
# Check optional dependencies for video-scout and create the output directory.
set -u
OUT="${VIDEO_SCOUT_HOME:-$HOME/.video-scout}"
ok() { printf '  [ok]   %s\n' "$1"; }
warn() { printf '  [warn] %s\n' "$1"; }

echo "video-scout setup check"
if command -v yt-dlp >/dev/null 2>&1; then ok "yt-dlp found"; else warn "yt-dlp not found (optional): brew install yt-dlp  |  pip install yt-dlp"; fi
if command -v jq >/dev/null 2>&1; then ok "jq found"; else warn "jq not found (optional): brew install jq"; fi
if [ -n "${YOUTUBE_API_KEY:-}" ]; then ok "YOUTUBE_API_KEY is set"; else warn "YOUTUBE_API_KEY not set (optional)"; fi
mkdir -p "$OUT" && ok "output directory: $OUT"
echo "Items marked [warn] are optional: the skill works without them, with less metadata."
