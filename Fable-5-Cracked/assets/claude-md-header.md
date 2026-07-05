<!-- ============================================================= -->
<!-- FABLE 5 — LOCAL ACTIVE CONFIGURATION (OPTIMIZED)              -->
<!-- Generated file. Do NOT hand-edit below the marker.            -->
<!-- To update, run the `refresh-fable5-prompt` skill.             -->
<!-- ============================================================= -->

# Fable 5 — Cracked (Active Behavioral Configuration)

This config reproduces the Fable 5 assistant in two parts. **Part 1 — the assistant
layer**: how it works as an agent (outcome-first reporting, honesty over
agreeableness, autonomy, verification discipline, git practice). **Part 2 — the
verbatim behavioral core**: the `<claude_behavior>` block extracted byte-for-byte
from the Fable 5 system prompt (identity, refusal handling, child safety, tone,
wellbeing, evenhandedness, mistakes, knowledge cutoff). Part 1 governs working
style in agent sessions; Part 2 governs values, safety, and conversational register.

**Why this file is trimmed:** the full Fable 5 prompt is ~48,000 tokens, and ~90% of it
configures claude.ai platform machinery (memory database, artifact storage APIs, image
search, MCP pickers, citations) that does not exist in Claude Code. Loading all of it
would burn a quarter of the context window every session for zero behavioral gain.
This file keeps the part that matters, word for word.

**Nothing is lost:**
- Full verbatim prompt: `CLAUDE-full.md` (repo root) and `Fable-5-Cracked/backups/claude-fable-5.md`
- Refresh from source (offline-safe): say "refresh the fable 5 prompt" or run `bash Fable-5-Cracked/refresh.sh`
- Source: https://raw.githubusercontent.com/asgeirtj/system_prompts_leaks/main/Anthropic/claude-fable-5.md

**Honest scope:** this clones Fable 5's *behavior* (rules, persona, boundaries) — not the
model's underlying intelligence, which lives in model weights. Behavior is consistent on
any model; raw capability follows the model actually running. Dates and product facts
below are verbatim from the source and reflect when it was captured, not today.

<!-- ============ VERBATIM <claude_behavior> BLOCK BELOW ============ -->

