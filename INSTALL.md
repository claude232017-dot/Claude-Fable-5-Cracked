# Install on your own computer

These files were built in a temporary cloud sandbox and pushed to GitHub. They are
**not** on your PC yet. Follow the steps for your operating system to pull them down.

Repo: https://github.com/claude232017-dot/Claude-Fable-5-Cracked
Branch: `claude/fable-5-local-setup-7hdllq`

---

## 1. Get the files

### macOS / Linux (Terminal)

```bash
git clone -b claude/fable-5-local-setup-7hdllq \
  https://github.com/claude232017-dot/Claude-Fable-5-Cracked.git

cd Claude-Fable-5-Cracked
```

### Windows

Use **Git Bash** or **WSL** (recommended, because `refresh.sh` needs bash + curl):

```bash
git clone -b claude/fable-5-local-setup-7hdllq \
  https://github.com/claude232017-dot/Claude-Fable-5-Cracked.git

cd Claude-Fable-5-Cracked
```

If you don't have git: install it from https://git-scm.com/downloads (Git Bash comes with it).

### Already cloned before?

```bash
git fetch origin
git checkout claude/fable-5-local-setup-7hdllq
git pull
```

---

## 2. Use it with Claude Code

The `CLAUDE.md` config and the `.claude/skills/` folders are read by **Claude Code**
(the CLI / desktop app / IDE extension). They do nothing for the Claude website or other
chat apps — they are configuration for the Claude Code tool.

1. Install Claude Code — https://claude.com/claude-code
2. Open this folder as your working directory:

   ```bash
   cd Claude-Fable-5-Cracked
   claude
   ```

3. Claude Code automatically loads `CLAUDE.md` (the active Fable 5 behavioral config) and
   registers the two skills:
   - **`refresh-fable5-prompt`** — say *"refresh the fable 5 prompt"*
   - **`llm-council`** — say *"council this …"*, *"pressure-test this …"*, etc.

---

## 3. Refresh the prompt anytime

```bash
bash Fable-5-Cracked/refresh.sh
```

Re-downloads the Fable 5 prompt from the source URL, updates the local backup, and
rebuilds `CLAUDE.md`. If the URL is offline, it falls back to the local backup so it
never breaks.

> **Windows note:** run `refresh.sh` from Git Bash or WSL (it needs `bash` and `curl`).

---

## What's in here

| Path | What it is |
|------|-----------|
| `CLAUDE.md` | Active config = verbatim Fable 5 behavioral core (~6k tokens) |
| `CLAUDE-full.md` | Full verbatim Fable 5 prompt (reference copy) |
| `.claude/skills/refresh-fable5-prompt/` | The refresh skill |
| `.claude/skills/llm-council/` | The 5-advisor decision skill |
| `Fable-5-Cracked/backups/` | Verbatim offline backups (survive URL going down) |
| `Fable-5-Cracked/refresh.sh` | Fetch + rebuild script (offline-safe) |
| `Fable-5-Cracked/README.md` | Full explanation + honest scope |

---

## Honest scope (important)

This clones Fable 5's **behavior** (rules, persona, formatting, refusal boundaries,
skills) — permanently and offline. It does **not** transfer the model's underlying
intelligence / "IQ"; that lives in the model weights. So behavior is identical on any
model that runs it, but raw capability still follows whichever model you actually use.
