---
name: claude-code-reviewer
description: Use this skill when the user wants to run Claude Code for code review, review current git diff, inspect a PR or commit, or have a dedicated Claude Code subagent review code for correctness, security, maintainability, performance, and test coverage.
---

# Claude Code Reviewer

Use this skill to run a dedicated Claude Code `code-reviewer` subagent and return high-signal review findings.

## When to use

Use when asked to:
- review current changes
- review a commit, diff, or pull request
- run Claude Code as a reviewer
- check code quality, bugs, security, maintainability, performance, or tests

## What this skill does

1. Ensure the Claude Code subagent `code-reviewer` exists at `~/.claude/agents/code-reviewer.md`.
2. If missing, create it from `references/code-reviewer-subagent.md`.
3. Run Claude Code in headless mode with the `code-reviewer` subagent.
4. Prefer reviewing the current git diff first.
5. Return grouped findings by severity with concrete fixes.

## Workflow

### 1. Verify repository context

Run review inside the target repository. Prefer the user's current repo or the repo they explicitly mention.

### 2. Ensure subagent exists

Check for:

```bash
~/.claude/agents/code-reviewer.md
```

If missing, create it from:

```text
references/code-reviewer-subagent.md
```

### 3. Run review

For current uncommitted changes, use:

```bash
scripts/run-review.sh .
```

For a specific target, pass the repo path and optionally a custom prompt.

### 4. Summarize output

Report:
- overall assessment
- findings by severity
- top fixes first
- whether the code looks merge-ready

## Notes

- This skill uses Claude Code CLI via `claude -p`.
- The subagent is read-focused and should not modify code.
- If the repo has no diff, ask Claude Code to review named files or the latest commit.
- If Claude Code is unavailable, report that clearly instead of guessing.

## Files in this skill

- `references/code-reviewer-subagent.md` — canonical subagent definition
- `scripts/ensure-subagent.sh` — installs the subagent if missing
- `scripts/run-review.sh` — runs Claude Code review against a repo
