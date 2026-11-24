# Core Platform Technical Specification

This repository contains the Core Platform V2.2 architecture and security-hardening baseline.

## Mandatory AI coding agent entrypoint

Every AI coding agent must read `docs/README.md` in full before any task, then follow `AGENTS.md`. Tool adapters are provided for Codex, GitHub Copilot, Claude Code and Gemini CLI. Other agents must be configured to load `AGENTS.md` or follow `AI_AGENT_START_HERE.md` manually.

- [AI Agent Start Here](AI_AGENT_START_HERE.md)
- [Canonical agent contract](AGENTS.md)
- [Documentation entrypoint](docs/README.md)

V2.2 supersedes V2.1 wherever they conflict. Tool-specific instruction files are adapters and must not become competing policy sources.
