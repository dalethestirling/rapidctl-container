# rapidctl-container

This repository provides a reference container environment for [rapidctl](https://github.com/dalethestirling/rapidctl), a Python library for executing container-based tasks.

## Context

`rapidctl` uses this container image as a lightweight, secure, and reproducible environment to run scripts and commands. It is optimized for fast startup and contains a set of common utilities and custom commands.

The container image is **runtime-agnostic** — it works with both Podman and Docker runtimes.

## What is included

The container is built on top of the **Red Hat Universal Base Image (UBI) 9**, providing a stable and minimal foundation.

### Built-in Commands

Pre-installed scripts are located in `/opt/rapidctl/cmd/` and are available in the container's environment:

- `hello-world`: A simple "Hello World" demonstration script.
- `reflector`: A utility script that echoes back its arguments or reads from stdin.

## How to Extend

You can easily extend this container with your own custom commands:

1.  **Add Scripts**: Place your scripts in the `cmd/` directory of this repository.
2.  **Update Commands Manifest**: Add an entry for your new command in `commands.json` with a `summary`. This provides the subcommand help text in `rapidctl`.
3.  **Modify Containerfile**: If your scripts require additional system packages, add the necessary `dnf install` commands to the [Containerfile](file:///Users/dalestirling/Documents/Projects/rapidctl-container/Containerfile).
4.  **Update Metadata**: If you add new binaries or scripts, ensure they are correctly added to the `/opt/rapidctl/cmd` path in the build process.

## Multi-Platform Support

This repository is configured with GitHub Actions to automatically build and push multi-platform images:

- `linux/amd64`
- `linux/arm64` (Apple Silicon support)

Images are hosted on the GitHub Container Registry (GHCR).

## Integration with rapidctl

The `rapidctl` library uses this container via its reference implementation, `examplectl`. When you run a command through `examplectl`, it pulls the image (if necessary) and executes the specified command within an instance of this container using the library.

The container works with both **Podman** (default) and **Docker** runtimes. Select the runtime via the `RAPIDCTL_EXEC_MODE` environment variable:
- `RAPIDCTL_EXEC_MODE=podman` (default)
- `RAPIDCTL_EXEC_MODE=docker`

For more information on how to use the library, visit the [rapidctl repository](https://github.com/dalethestirling/rapidctl).
