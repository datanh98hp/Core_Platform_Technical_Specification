# Core Platform Technical Specification

This repository contains the Core Platform V2.2 architecture and security-hardening baseline.

## Mandatory AI coding agent entrypoint

Every AI coding agent must read `docs/README.md` in full before any task, then follow `AGENTS.md`. Tool adapters are provided for Codex, GitHub Copilot, Claude Code and Gemini CLI. Other agents must be configured to load `AGENTS.md` or follow `AI_AGENT_START_HERE.md` manually.

- [AI Agent Start Here](AI_AGENT_START_HERE.md)
- [Canonical agent contract](AGENTS.md)
- [Documentation entrypoint](docs/README.md)

V2.2 supersedes V2.1 wherever they conflict. Tool-specific instruction files are adapters and must not become competing policy sources.


## Controlled implementation plan

The proposed Core Platform V2.2 delivery baseline is in [EXECUTION_PLAN_V2.2](docs/implementation/EXECUTION_PLAN_V2.2.md). It is broken into seven stage plans under [docs/implementation/phases](docs/implementation/phases/). All stages remain locked until explicitly authorized by the Project Owner.

AI coding agents must follow [AI Agent Execution Control V1](docs/governance/AI_AGENT_EXECUTION_CONTROL_V1.md), record decisions in the [Approval Register](docs/implementation/APPROVAL_REGISTER.md), and use a pull request for all changes. See [GitHub repository protection setup](docs/governance/GITHUB_REPOSITORY_PROTECTION_SETUP.md).
