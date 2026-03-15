# Spec-Kit with Claude Code

## Goal

Use Claude Code as the primary executor of the spec-kit workflow while OpenClaw acts as a lightweight launcher and monitor.

## Preferred flow

1. Enter the target repository.
2. Ensure `claude` and `specify` are installed.
3. If the repo is not initialized for spec-kit, run:

```bash
specify init --here --ai claude --force
```

4. Let Claude Code execute the native flow inside the project:
   - constitution
   - specify
   - plan
   - tasks
   - implement

## Why this is preferred

- reduces OpenClaw-side token usage
- keeps workflow logic inside Claude Code/spec-kit
- makes behavior closer to official spec-kit usage
- reduces duplicated orchestration prompts

## Practical guidance

- Use concise launch prompts.
- Avoid restating the entire workflow every turn.
- Read generated artifacts from disk when verification is needed.
- Only add extra orchestration when recovery, debugging, or auditing is required.
