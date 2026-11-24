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


## Mandatory execution governance

Before implementation, also read:
- docs/governance/AI_AGENT_EXECUTION_CONTROL_V1.md
- docs/implementation/EXECUTION_PLAN_V2.2.md
- docs/implementation/APPROVAL_REGISTER.md
- docs/implementation/EXECUTION_REGISTER.md
- The exact phase document and approved work order for the task

The plan and each phase are locked until the Project Owner explicitly authorizes them. No approval means no implementation. Do not infer approval from silence, a vague acknowledgment, CI success or acceptance of a different phase. Do not skip phases or automatically start a later phase after a gate passes.

Any deviation in scope, budget, schedule, architecture, data handling, security controls, acceptance criteria, providers, dependencies or release plan must be either directly and unambiguously requested by the Project Owner or submitted as a Change Request and held until approved. Never silently make a deviation. All work must use a branch and PR; agents must not merge or deploy.

See docs/governance/GITHUB_REPOSITORY_PROTECTION_SETUP.md for the additional GitHub settings required to enforce owner review at merge time.
