#!/usr/bin/env bash
# Refresh the local Fable 5 prompt from the source URL, with offline fallback, then
# regenerate:
#   CLAUDE.md       — ACTIVE config: verbatim <claude_behavior> block only (optimized;
#                     the rest of the prompt is claude.ai platform machinery that is
#                     inert in Claude Code and would waste ~44k context tokens/session)
#   CLAUDE-full.md  — full verbatim prompt (reference/fidelity copy)
# Both are also mirrored into Fable-5-Cracked/.
#
# Usage: bash Fable-5-Cracked/refresh.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

URL="https://raw.githubusercontent.com/asgeirtj/system_prompts_leaks/main/Anthropic/claude-fable-5.md"
BACKUP="$SCRIPT_DIR/backups/claude-fable-5.md"
HEADER_CORE="$SCRIPT_DIR/assets/claude-md-header.md"
HEADER_FULL="$SCRIPT_DIR/assets/claude-md-full-header.md"
TMP="$(mktemp)"

echo "→ Fetching Fable 5 prompt from source…"
if curl -fsSL "$URL" -o "$TMP" && [ -s "$TMP" ]; then
  if [ "$(wc -c < "$TMP")" -gt 1000 ]; then
    cp "$TMP" "$BACKUP"
    echo "✓ Source fetched and local backup updated ($(wc -c < "$BACKUP") bytes)."
  else
    echo "⚠ Fetched file looked too small; keeping existing backup."
  fi
else
  echo "⚠ Source URL unreachable — using existing local backup (offline mode)."
fi
rm -f "$TMP"

if [ ! -s "$BACKUP" ]; then
  echo "✗ No local backup available and URL unreachable. Aborting." >&2
  exit 1
fi

# Extract the verbatim <claude_behavior> block (the behavioral core).
CORE="$(mktemp)"
awk '/^`<claude_behavior>`$/{f=1} f{print} /^`<\/claude_behavior>`$/{f=0}' "$BACKUP" > "$CORE"
if [ ! -s "$CORE" ]; then
  echo "⚠ Could not find <claude_behavior> block in source (format changed?)."
  echo "  Falling back to the FULL prompt for CLAUDE.md so nothing breaks."
  cp "$BACKUP" "$CORE"
fi

build() { # build <header> <body> <out>
  cat "$1" "$2" > "$3"
  echo "✓ Wrote $3 ($(wc -l < "$3") lines, ~$(( $(wc -c < "$3") / 4 )) tokens)."
}

build "$HEADER_CORE" "$CORE"   "$ROOT/CLAUDE.md"
build "$HEADER_CORE" "$CORE"   "$SCRIPT_DIR/CLAUDE.md"
build "$HEADER_FULL" "$BACKUP" "$ROOT/CLAUDE-full.md"
build "$HEADER_FULL" "$BACKUP" "$SCRIPT_DIR/CLAUDE-full.md"
rm -f "$CORE"

echo "Done. Regenerated at $(date -u +%Y-%m-%dT%H:%M:%SZ)"
