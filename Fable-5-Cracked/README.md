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
├── CLAUDE.md                         # ACTIVE config = header + verbatim Fable 5 prompt (generated)
├── .claude/skills/
│   ├── refresh-fable5-prompt/SKILL.md   # "refresh the fable 5 prompt"
│   └── llm-council/SKILL.md             # "council this", "pressure-test this", …
└── Fable-5-Cracked/
    ├── README.md                     # this file
    ├── refresh.sh                    # fetch + rebuild (offline-safe)
    ├── CLAUDE.md                     # mirror of the active config
    ├── assets/
    │   └── claude-md-header.md       # the header prepended to the prompt
    ├── backups/
    │   ├── claude-fable-5.md         # VERBATIM offline backup of the Fable 5 prompt
    │   ├── llm-council-SKILL.md      # verbatim backup of the council skill
    │   └── llm-council-README.md     # verbatim backup of the council readme
    └── .claude/skills/               # self-contained mirror of both skills
```

## Refreshing

Say **"refresh the fable 5 prompt"** (invokes the `refresh-fable5-prompt` skill), or run:

```bash
bash Fable-5-Cracked/refresh.sh
```

It re-downloads from the source URL, updates the local backup only if a valid file comes
back, **falls back to the existing backup if the URL is offline**, and regenerates both
`CLAUDE.md` files.

## Sources

- Fable 5 prompt — https://raw.githubusercontent.com/asgeirtj/system_prompts_leaks/main/Anthropic/claude-fable-5.md
- LLM Council skill — https://github.com/aiwithremy/claude-skills-llm-council
