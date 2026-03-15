#!/bin/bash
set -euo pipefail
mkdir -p "$HOME/.claude/agents" "$HOME/.claude/hooks"

HOOK="$HOME/.claude/hooks/validate-readonly-bash.sh"
if [ ! -f "$HOOK" ]; then
cat > "$HOOK" <<'HOOKEOF'
#!/bin/bash
INPUT=$(cat)
COMMAND=$(printf '%s' "$INPUT" | python3 -c 'import sys,json; data=json.load(sys.stdin); print(data.get("tool_input",{}).get("command",""))')
if echo "$COMMAND" | grep -E '(^|[[:space:]])(rm|mv|cp|chmod|chown|sed -i|perl -i|git add|git commit|git push|git reset|git checkout|git restore|touch|mkdir|rmdir|tee|dd|truncate)([[:space:]]|$)' >/dev/null; then
  echo "Blocked: code-reviewer is read-only. Write operations are not allowed." >&2
  exit 2
fi
exit 0
HOOKEOF
chmod +x "$HOOK"
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cp "$SKILL_DIR/references/code-reviewer-subagent.md" "$HOME/.claude/agents/code-reviewer.md"
echo "Installed code-reviewer subagent to $HOME/.claude/agents/code-reviewer.md"
