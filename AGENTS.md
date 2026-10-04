# AGENTS.md - rapidctl-container Development Guide

## Project Overview
Base container image for rapidctl command hosting. Provides UBI9-based environment with commands at `/opt/rapidctl/cmd/` and metadata at `/opt/rapidctl/commands.json`.

## Version Contract

### Publishing
- CI builds on push to main, publishes to `ghcr.io/dalethestirling/rapidctl-container`
- **Two tags always created**: `latest` and timestamp (e.g., `1771729391`)
- Timestamp format: `date +%s` (Unix epoch seconds)

### Downstream Consumption
- Consumers (e.g., examplectl) should default to `latest` for "always working" demos
- For reproducibility: pin to specific timestamp tag
- Breaking changes to `commands.json` schema or command path require coordination

### Schema Stability
- `commands.json` structure: `{ "command-name": { "summary": "...", "parameters": {...}, "argument_mapping": {...} } }`
- Command path: `/opt/rapidctl/cmd/` (fixed by rapidctl library contract)
- Adding commands: non-breaking
- Removing/renaming commands: breaking
- Changing `parameters` or `argument_mapping`: breaking for MCP/auto-generated help

## Extension Pattern (for downstream forks)

1. Fork this repo
2. Add scripts to `cmd/` (must be executable)
3. Update `commands.json` with metadata
4. Add `dnf install` to Containerfile if commands need system packages
5. Push to your GHCR: `ghcr.io/<your-org>/<your-container>`
6. Point your CLI wrapper (e.g., examplectl fork) to your container repo

## CI/CD
- Workflow: `.github/workflows/docker-image.yml`
- Multi-platform: linux/amd64, linux/arm64
- Triggers: push to main (ignores markdown changes)
- Requires: `GITHUB_TOKEN` with packages:write