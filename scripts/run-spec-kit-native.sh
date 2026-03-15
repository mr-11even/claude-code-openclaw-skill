#!/bin/bash
set -euo pipefail

PROJECT_DIR="${1:-}"
FEATURE_REQUEST="${2:-}"

if [ -z "$PROJECT_DIR" ] || [ -z "$FEATURE_REQUEST" ]; then
  echo "Usage: $0 <project-dir> <feature-request>" >&2
  exit 1
fi

command -v claude >/dev/null 2>&1 || { echo "claude not found" >&2; exit 1; }
command -v specify >/dev/null 2>&1 || { echo "specify not found" >&2; exit 1; }

cd "$PROJECT_DIR"

if [ ! -d ".specify" ] || [ ! -d ".claude/commands" ]; then
  specify init --here --ai claude --force
fi

PROMPT=$(cat <<PROMPT_EOF
You are working inside a spec-kit initialized project.
Use the repository's native spec-kit workflow for this request: ${FEATURE_REQUEST}

Execute the full flow in-project:
1. /speckit.constitution
2. /speckit.specify
3. /speckit.plan
4. /speckit.tasks
5. /speckit.implement

Prefer native spec-kit behavior and repository scripts/templates over recreating the workflow externally.
Make reasonable decisions autonomously. Keep the final response concise and include:
- branch name
- key artifacts created
- implementation status
- exact run instructions
PROMPT_EOF
)

claude --permission-mode bypassPermissions --print "$PROMPT"
