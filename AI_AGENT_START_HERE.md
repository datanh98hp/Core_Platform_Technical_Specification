# AI Agent Start Here — Tool-Neutral Entry Point

This repository uses one canonical engineering contract: `AGENTS.md`.

## Required reading order

1. `docs/README.md` — read in full before any task.
2. `AGENTS.md` — canonical repository instructions and security constraints.
3. `docs/governance/AI_Agent_Coding_Governance_v2.2.md`.
4. `docs/architecture/Core_Platform_Technical_Specification_V2.2.md`.
5. Relevant accepted ADRs, security policy, contracts and backlog.

## Agent compatibility

| Agent/tool | Repository instruction file |
|---|---|
| OpenAI Codex | `AGENTS.md` |
| GitHub Copilot | `.github/copilot-instructions.md`; supported agent modes also understand `AGENTS.md` |
| Claude Code | `CLAUDE.md` |
| Gemini CLI | `GEMINI.md` |
| Other AI coding agents | Configure the tool to load `AGENTS.md`, or open this file and `AGENTS.md` explicitly before work |

Tool-specific files are adapters only. They must not contain conflicting architecture, security or delivery rules. Update the canonical contract first, then synchronize adapters.

## Important limitation

There is no universal mechanism that forces every third-party AI coding tool to discover repository instructions automatically. Discovery depends on the agent harness and its settings. The repository therefore provides standard entry files for Codex, Copilot, Claude and Gemini, a generic manual entrypoint for other tools, and CI checks that detect missing instruction files. Each agent host must still support or be configured to load its adapter.
