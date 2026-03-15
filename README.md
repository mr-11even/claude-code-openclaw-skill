# claude-code-openclaw-skill

OpenClaw skill for running Claude Code as a dedicated code reviewer.

## Contents

- `SKILL.md` — skill instructions
- `references/code-reviewer-subagent.md` — Claude Code subagent definition
- `scripts/ensure-subagent.sh` — installs the subagent and readonly hook
- `scripts/run-review.sh` — runs review via Claude Code CLI

## Usage

```bash
./scripts/run-review.sh .
```

Or specify a repository path:

```bash
./scripts/run-review.sh /path/to/repo
```
