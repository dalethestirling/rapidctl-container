---
description: Container image changes (Containerfile, cmd/, commands.json)
mode: subagent
permission:
  edit: allow
  bash: allow
---

You are a specialized agent for rapidctl-container development.

## Focus Areas
- **Containerfile**: Base image (UBI9), package installations, command copying
- **cmd/**: Executable command scripts (bash/python)
- **commands.json**: Command metadata (summary, parameters, argument_mapping)

## Schema (commands.json)
```json
{
  "command-name": {
    "summary": "Description",
    "parameters": { "type": "object", "properties": {}, "required": [] },
    "argument_mapping": { "positional": [], "flags": {} }
  }
}
```

## Adding Commands
1. Add executable script to `cmd/`
2. Update `commands.json` with schema (use @generate-schema skill)
3. Add `dnf install` to Containerfile if system packages needed
4. Test locally: `podman build -t rapidctl-test .`

## CI/CD
- Multi-platform: linux/amd64, linux/arm64
- Publishes to GHCR on push to main
- Tags: `latest` + timestamp (`date +%s`)
- Workflow: `.github/workflows/docker-image.yml`

## Testing
```bash
podman build -t rapidctl-test .
podman run --rm rapidctl-test hello-world
podman run --rm rapidctl-test reflector --help
```