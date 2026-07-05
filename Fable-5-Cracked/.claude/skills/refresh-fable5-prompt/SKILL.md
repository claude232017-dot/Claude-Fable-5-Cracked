---
name: refresh-fable5-prompt
description: >
  Refresh / re-download the Claude Fable 5 system prompt from its source URL and
  rebuild the active CLAUDE.md (repo root + Fable-5-Cracked/), updating the local
  offline backup. Use whenever the user says any of: "refresh the fable 5 prompt",
  "update fable 5", "re-download the prompt", "pull the latest fable 5", "sync the
  fable 5 config", "rebuild CLAUDE.md from the source". Falls back to the local
  backup automatically if the URL is offline.
---

# Refresh Fable 5 Prompt

This skill re-syncs the local Fable 5 behavioral configuration from its upstream source
and regenerates the active `CLAUDE.md`. It is offline-safe: if the source URL cannot be
reached, it keeps and reuses the existing local backup so the config never breaks.

## Source of truth

- **URL:** `https://raw.githubusercontent.com/asgeirtj/system_prompts_leaks/main/Anthropic/claude-fable-5.md`
- **Local backup:** `Fable-5-Cracked/backups/claude-fable-5.md`
- **Header/template:** `Fable-5-Cracked/assets/claude-md-header.md`
- **Full-copy header:** `Fable-5-Cracked/assets/claude-md-full-header.md`
- **Assistant layer:** `Fable-5-Cracked/assets/assistant-layer.md` (Part 1: agent persona)
- **Generated outputs:** `CLAUDE.md` (ACTIVE: assistant layer + verbatim `<claude_behavior>`
  core, ~7.6k tokens) and `CLAUDE-full.md` (full verbatim prompt, ~47k tokens, reference).
  Subfolder copies are `Fable-5-Cracked/CLAUDE-core.md` and `CLAUDE-full.md` — deliberately
  not named CLAUDE.md so they don't auto-load a second time.

## What to do when invoked

1. Run the refresh script from the repo root:

   ```bash
   bash Fable-5-Cracked/refresh.sh
   ```

   This fetches the URL, updates the backup only if a valid non-trivial file comes back,
   falls back to the existing backup if the URL is offline, extracts the verbatim
   `<claude_behavior>` block as the active `CLAUDE.md` (keeping sessions ~44k tokens
   lighter), and writes the full verbatim prompt to `CLAUDE-full.md`. If the upstream
   format ever changes and the block can't be found, it falls back to the full prompt
   for `CLAUDE.md` so nothing breaks.

2. Confirm the result to the user: report whether the content came from the **live URL**
   or the **offline backup**, the new line/byte count, and that both `CLAUDE.md` files
   were regenerated.

3. If the user asks, show a diff of what changed:

   ```bash
   cd /home/user/Claude-Fable-5-Cracked && git diff --stat CLAUDE.md Fable-5-Cracked/
   ```

4. Do **not** hand-edit `CLAUDE.md`. It is generated — edits belong in
   `Fable-5-Cracked/assets/claude-md-header.md` (the header) or come from the upstream
   prompt (the body).

## Notes

- The script requires only `bash` and `curl`, both standard.
- Committing after a refresh is optional; offer it, don't assume it.
