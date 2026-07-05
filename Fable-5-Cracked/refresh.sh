#!/usr/bin/env bash
# Refresh the local Fable 5 prompt from the source URL, with offline fallback,
# then regenerate the active CLAUDE.md at the repo root and in Fable-5-Cracked/.
#
# Usage: bash Fable-5-Cracked/refresh.sh
set -euo pipefail

# Resolve repo root (this script lives in <root>/Fable-5-Cracked/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

URL="https://raw.githubusercontent.com/asgeirtj/system_prompts_leaks/main/Anthropic/claude-fable-5.md"
BACKUP="$SCRIPT_DIR/backups/claude-fable-5.md"
HEADER="$SCRIPT_DIR/assets/claude-md-header.md"
TMP="$(mktemp)"

echo "→ Fetching Fable 5 prompt from source…"
if curl -fsSL "$URL" -o "$TMP" && [ -s "$TMP" ]; then
  # Only overwrite the backup if the fetch produced a non-trivial file.
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

# Regenerate the active CLAUDE.md files: header + verbatim prompt.
build() {
  local out="$1"
  cat "$HEADER" > "$out"
  cat "$BACKUP" >> "$out"
  echo "✓ Wrote $out ($(wc -l < "$out") lines)."
}

build "$ROOT/CLAUDE.md"
build "$SCRIPT_DIR/CLAUDE.md"

echo "Done. Active CLAUDE.md regenerated from backup dated: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
