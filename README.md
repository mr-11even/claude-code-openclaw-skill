# claude-code-openclaw-skill

OpenClaw skill for delegating coding workflows to Claude Code.

## Highlights

- direct Claude Code task execution
- native spec-kit workflow preference for Claude Code projects
- lower OpenClaw token usage by minimizing external orchestration
- helper script for launching spec-kit end-to-end in a Claude Code project

## Files

- `SKILL.md`
- `references/spec-kit-workflow.md`
- `scripts/run-spec-kit-native.sh`

## Example

```bash
./scripts/run-spec-kit-native.sh /path/to/project "Build a skeuomorphic todo list app"
```
