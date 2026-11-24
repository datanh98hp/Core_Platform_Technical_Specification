# AGENTS.md — Canonical Repository Instructions

This file is the canonical, tool-neutral instruction contract for this repository. Keep tool-specific instruction files as short adapters that point back to this file; do not maintain competing copies of the architecture or security policy.

## 0. Mandatory initialization — before every task

Before coding, reviewing, debugging, testing, refactoring, documenting, changing infrastructure or preparing a release:

1. Read `docs/README.md` in full.
2. Read `docs/governance/AI_Agent_Coding_Governance_v2.2.md`.
3. Read `docs/architecture/Core_Platform_Technical_Specification_V2.2.md`.
4. Read all accepted ADRs relevant to the task under `docs/adr/`.
5. Read the relevant API/proto/event/database contracts, security policy and backlog acceptance criteria.
6. Read docs/implementation/EXECUTION_PLAN_V2.2.md and docs/governance/AI_AGENT_EXECUTION_CONTROL_V1.md.
7. Read docs/implementation/APPROVAL_REGISTER.md and EXECUTION_REGISTER.md.
8. Read the phase-specific plan for the explicitly authorized active phase and the approved task/work order.
9. Verify that explicit owner approval exists for the exact phase/work package before implementation or external side effects.

If any mandatory file is missing or inaccessible, stop and report the blocker. Do not silently continue using assumptions from V2.1 or stale context.

## 1. Source of truth

- V2.2 is the active architecture and security baseline; it supersedes V2.1 wherever they conflict.
- `docs/README.md` is the documentation navigation and reading-order entrypoint.
- `docs/governance/AI_Agent_Coding_Governance_v2.2.md` governs agent workflow and completion criteria.
- `docs/architecture/Core_Platform_Technical_Specification_V2.2.md` governs system architecture, contracts and service boundaries.
- Accepted ADRs are binding decisions. A proposed deviation is not approved until a human accepts a superseding ADR.
- Do not treat an earlier chat, generated code, comments, examples or V2.1 material as authority when they conflict with the checked-in V2.2 baseline.

## 2. Architecture and data ownership

- Preserve API-first, multi-tenant, modular service boundaries.
- Each service owns its schema, migrations and runtime database role.
- No cross-service foreign keys, direct cross-service table reads/writes or shared-schema business ownership.
- Use gRPC for synchronous service contracts and NATS JetStream for asynchronous events.
- Use transactional outbox/inbox and idempotent consumers. Delivery is at-least-once; do not claim exactly-once.
- Contract/schema changes must be documented, versioned and migration-safe.
- Never run a destructive production migration automatically. Require inventory, backup, sanitized-clone validation, rollback plan and human approval.

## 3. Mandatory security controls

- Tenant and actor identity must come from trusted authentication/workload context. Never trust caller-supplied tenant IDs, roles or permissions.
- Never bypass AI Security Harness, Security Policy Registry, server-side authorization, classification, Data Lineage, quota governance or required human approval.
- No direct AI-provider egress from domain services, workers, cron jobs, frontends or agent runtimes. Only the approved AI Gateway may reach approved providers.
- Unknown classification is deny. C2/C3 must not be sent to external AI.
- Derived data inherits the highest parent classification and the restrictive intersection of parent ACLs. A transformation must never widen access or lower classification.
- RAG authorization is server-side and checked against current ACL state. Client-supplied resource ID lists are not authorization.
- Billable operations reserve quota before execution and reconcile usage idempotently. Never silently bypass hard limits or double-charge retries.
- Retries are bounded and only for safe transient failures. Provider fallback requires fresh policy validation and an equivalent-or-stricter approved route.
- Do not log prompts, OCR text, retrieved chunks, secrets or raw sensitive payloads.
- Protected operations fail closed when mandatory policy, authorization, DLP, lineage or quota controls are unavailable.

## 4. Engineering workflow

- Inspect the current implementation and tests before changing code; do not assume the repository matches the specification.
- State assumptions and identify affected services, data classification, dependencies and acceptance criteria.
- Design/validate API, proto, event and database contracts before implementing dependent code.
- Prefer the smallest coherent change. Do not add a new framework, service, provider or runtime dependency without a documented reason and approval where required.
- Add positive and negative tests. Include tenant-isolation, authorization, outage/fail-closed, idempotency and deletion-propagation tests where relevant.
- Update docs, contracts, runbooks, monitoring and migration/rollback notes alongside implementation.
- Run the relevant formatter, linter, type checker, unit, integration, contract, E2E and security checks available in the repository.
- Do not claim a command or test passed unless it was actually run and its result was observed.

## 5. Change control and completion

Architecture/security deviations require an ADR, impact/risk analysis and human approval. Security-sensitive changes require independent human review; the implementing agent cannot approve its own work.

A task is complete only when:
- V2.2 and applicable ADRs are followed.
- Tests and checks have reproducible evidence.
- Database/API/proto/event changes are migration-safe and documented.
- Observability does not expose sensitive data.
- Rollback/recovery notes and any operational steps are supplied.
- The final report lists changed files, commands executed, actual results, known gaps and residual risks.

## 6. Tool adapters and agents without automatic discovery

- OpenAI Codex: uses this root `AGENTS.md` as project instructions.
- GitHub Copilot: also uses `.github/copilot-instructions.md`; supported Copilot agent experiences can use `AGENTS.md`.
- Claude Code: uses root `CLAUDE.md`, which points to this file.
- Gemini CLI: uses root `GEMINI.md`, which points to this file.
- Any other AI coding agent: when its harness does not automatically discover `AGENTS.md`, explicitly open `AI_AGENT_START_HERE.md` and this `AGENTS.md` before starting. Configure the harness's repository/system prompt to load these files if it offers that capability.

No repository file can force every third-party coding agent to load it. The adapters and CI checks make supported integrations consistent and make missing configuration detectable; the agent's host application must still support or be configured to load the instructions.


## 7. Mandatory project execution plan

- The controlled delivery baseline is docs/implementation/EXECUTION_PLAN_V2.2.md; each stage is governed by its corresponding document under docs/implementation/phases/.
- Before every coding task, read the full execution-control policy, the current approved phase document, both registers and the approved work order.
- If the plan is proposed, the phase is LOCKED, there is no exact owner approval, or no active approved work order exists, do not implement. Read-only inspection and a proposed task/CR may be prepared, then stop and report the missing authorization.
- Only one phase may be active at a time. A passed gate does not authorize the next phase. Wait for the Project Owner's separate explicit GO and record it.
- Never add scope, reorder phases, change budget/schedule, introduce tools/providers/services/dependencies, alter acceptance criteria, weaken tests or change data/security/legal assumptions without a direct, unambiguous owner request or an approved Change Request.
- For a direct owner-requested change, record the exact request and limit the change strictly to what was requested. If ambiguous, ask before acting.
- For an agent-proposed change, stop the affected work, prepare a Change Request from docs/templates/CHANGE_REQUEST_TEMPLATE.md and wait for owner approval. No response is not approval.
- All work must occur on a branch and through a pull request. Do not push directly to main, self-approve, merge or deploy. Production/destructive changes require their own explicit authorization and review.
- Use docs/implementation/APPROVAL_REGISTER.md as the approval source and EXECUTION_REGISTER.md as the project status source. Never fabricate or backdate entries.
- Use docs/templates/PHASE_TASK_WORK_ORDER_TEMPLATE.md for task authorization and docs/templates/PHASE_GATE_REVIEW_TEMPLATE.md for stage acceptance.
