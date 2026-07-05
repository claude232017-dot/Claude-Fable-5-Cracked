# Fable-5-Cracked

A permanent, offline-durable local install of the **Claude Fable 5** behavioral
configuration, plus the **LLM Council** skill, plus a one-command **refresh** skill.

## Honest scope (read this first)

This setup captures Fable 5's **behavior**, not its **brain**.

- ✅ **What's cloned & permanent:** the full system prompt — persona, rules, formatting,
  refusal boundaries, tool/search guidance, and the Fable 5 identity framing. Any model
  that runs this repo (Sonnet, Opus, Haiku, or Fable 5) reads it and behaves by it. The
  rules are identical every time, and they keep working even if Fable 5 is retired or the
  source URL disappears.
- ❌ **What a prompt can't do:** transfer the model's underlying intelligence / reasoning
  depth / "IQ." That lives in the model weights, not in any text file. So *behavioral
  consistency* is guaranteed; *raw capability* is still whatever model is actually running.

That's the truthful version of "works even if Fable 5 isn't available anymore": the
**configuration** is fully preserved and portable; the **capability ceiling** follows the
live model.

## Layout

```
<repo root>/
├── CLAUDE.md                         # ACTIVE config = assistant layer + verbatim core (~7.6k tokens)
├── CLAUDE-full.md                    # full verbatim Fable 5 prompt (~47k tokens, reference)
├── .claude/skills/
│   ├── refresh-fable5-prompt/SKILL.md   # "refresh the fable 5 prompt"
│   └── llm-council/SKILL.md             # "council this", "pressure-test this", …
└── Fable-5-Cracked/
    ├── README.md                     # this file
    ├── refresh.sh                    # fetch + rebuild both files (offline-safe)
    ├── CLAUDE-core.md / CLAUDE-full.md  # mirror copies (renamed so they don't double-load)
    ├── assets/
    │   ├── claude-md-header.md       # header for the active file
    │   ├── assistant-layer.md        # Part 1: the agent working persona
    │   └── claude-md-full-header.md  # header for the full reference copy
    ├── backups/
    │   ├── claude-fable-5.md         # VERBATIM offline backup of the Fable 5 prompt
    │   ├── llm-council-SKILL.md      # verbatim backup of the council skill
    │   └── llm-council-README.md     # verbatim backup of the council readme
    └── .claude/skills/               # self-contained mirror of both skills
```

## What "becomes the assistant" means here

The active `CLAUDE.md` has two parts. **Part 1, the assistant layer**, reproduces the
working persona of the Fable 5 agent: lead with the outcome, honesty over
agreeableness, act autonomously on reversible steps, verify before claiming, proper
git discipline. **Part 2** is the verbatim Fable 5 `<claude_behavior>` core (values,
safety, tone). Part 1 governs how the agent works; Part 2 governs what it stands for.
Where they conflict on formatting/workflow, Part 1 wins — the core was written for a
consumer chat app.

## Why CLAUDE.md carries the core, not the full prompt

`CLAUDE.md` loads into context at the start of every session. The full Fable 5 prompt is
~48k tokens, and ~90% of it configures claude.ai platform machinery (memory database,
artifact storage APIs, image search, MCP pickers, citations) that does not exist in
Claude Code — pure context-window tax with no behavioral effect. So the active file
carries only the `<claude_behavior>` block, extracted byte-for-byte verbatim: identity,
refusal handling, child safety, tone/formatting, wellbeing, evenhandedness, mistakes,
knowledge cutoff. The full prompt is always available in `CLAUDE-full.md` and
`backups/claude-fable-5.md`.

## Refreshing

Say **"refresh the fable 5 prompt"** (invokes the `refresh-fable5-prompt` skill), or run:

```bash
bash Fable-5-Cracked/refresh.sh
```

It re-downloads from the source URL, updates the local backup only if a valid file comes
back, **falls back to the existing backup if the URL is offline**, and regenerates
`CLAUDE.md` (assistant layer + verbatim behavioral core) and `CLAUDE-full.md` (full
prompt), with subfolder copies named `CLAUDE-core.md`/`CLAUDE-full.md`. If the upstream format ever changes so the core block can't be found, it
falls back to the full prompt for `CLAUDE.md` so nothing breaks.

## Sources

- Fable 5 prompt — https://raw.githubusercontent.com/asgeirtj/system_prompts_leaks/main/Anthropic/claude-fable-5.md
- LLM Council skill — https://github.com/aiwithremy/claude-skills-llm-council
