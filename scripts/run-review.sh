#!/bin/bash
set -euo pipefail
REPO="${1:-.}"
PROMPT="${2:-Use the code-reviewer subagent to review the current uncommitted changes only. Return findings grouped by severity with concrete fixes and a short merge-readiness conclusion.}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
"$SCRIPT_DIR/ensure-subagent.sh" >/dev/null
cd "$REPO"
claude -p "$PROMPT" \
  --allowedTools "Agent(code-reviewer),Read,Glob,Grep,Bash(git status *),Bash(git diff *),Bash(git log *),Bash(rg *),Bash(ls *),Bash(cat *),Bash(sed *),Bash(head *),Bash(tail *)" \
  --output-format json
