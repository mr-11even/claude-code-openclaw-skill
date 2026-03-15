---
name: claude-code-agent
description: Use this skill when the user wants to run Claude Code for coding work, spec-kit workflows, code review, implementation planning, bug fixing, or feature delivery. Prefer native Claude Code commands and slash-command workflows over external orchestration when possible, especially to reduce OpenClaw token usage.
---

# Claude Code Agent

Use this skill to delegate coding work to Claude Code CLI.

## When to use

Use when the user asks to:
- run Claude Code
- build, refactor, debug, or review code with Claude Code
- use spec-kit with Claude Code
- create specs, plans, tasks, or implementations in a Claude Code project
- minimize OpenClaw-side token usage by letting Claude Code handle the workflow natively

## Core rule

Prefer **native Claude Code execution** over heavy external orchestration.

For normal coding tasks, use Claude Code directly in the target repository.
For spec-kit projects, prefer letting Claude Code run the project's native `/speckit.*` workflow (or the closest native command-compatible equivalent available in the current Claude Code surface) instead of reimplementing the workflow outside Claude Code.

## Execution modes

### 1. Direct Claude Code task execution

Use for ordinary coding, debugging, or implementation work:

```bash
claude --permission-mode bypassPermissions --print "<task>"
```

Run in the project directory.

### 2. Native spec-kit workflow with Claude Code

When the user wants spec-kit, do this:

1. Ensure `specify` is installed.
2. Initialize the project with `specify init --ai claude` if needed.
3. Prefer Claude Code-native spec-kit progression:
   - `/speckit.constitution`
   - `/speckit.specify`
   - `/speckit.plan`
   - `/speckit.tasks`
   - `/speckit.implement`
4. Minimize OpenClaw-side orchestration. Act mainly as launcher, monitor, and summarizer.

Important preference:
- If the user has indicated they want lower OpenClaw token usage, prefer sending Claude Code a concise instruction to execute the native spec-kit flow within the repo.
- Avoid repeatedly re-summarizing all prior steps in OpenClaw unless recovery/debugging requires it.

## Recommended commands

### Check tools

```bash
which claude
claude --version
which specify || true
specify check || true
```

### Install spec-kit

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
```

### Initialize spec-kit for Claude Code

```bash
specify init --here --ai claude --force
```

### Run Claude Code on a coding task

```bash
claude --permission-mode bypassPermissions --print "Implement the requested feature and summarize the result"
```

### Run Claude Code on a spec-kit workflow

Use the helper script:

```bash
scripts/run-spec-kit-native.sh /path/to/project "Build a skeuomorphic todo list app"
```

This script:
- verifies `claude` and `specify`
- initializes spec-kit if needed
- instructs Claude Code to use the repository's native spec-kit workflow
- keeps OpenClaw orchestration thin

## Files in this skill

- `references/spec-kit-workflow.md` — guidance for using spec-kit with Claude Code
- `scripts/run-spec-kit-native.sh` — helper to initialize and launch a native spec-kit workflow through Claude Code

## Notes

- For Claude Code, prefer `--permission-mode bypassPermissions --print`.
- Avoid PTY for Claude Code unless truly required by a TTY-only flow.
- For long-running work, use background execution and monitor with process tools.
- For spec-kit, native in-repo execution is preferred over rebuilding the workflow step-by-step in OpenClaw.
