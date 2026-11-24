# Repository-wide AI Agent Instructions

## Mandatory pre-task gate
Before performing **any** task (coding, review, debugging, testing, refactoring, documentation, release or infrastructure), read `docs/README.md` in full. Then read:
1. `docs/governance/AI_Agent_Coding_Governance_v2.2.md`
2. `docs/architecture/Core_Platform_Technical_Specification_V2.2.md`
3. All applicable accepted ADRs under `docs/adr/`
4. Relevant contracts/migrations and `docs/implementation/backlog/v2.2-implementation-backlog.md`

If `docs/README.md` is missing or cannot be read, STOP and report the blocker. Do not infer requirements from code, prompts or V2.1.

## Source-of-truth precedence
V2.2 is the active technical baseline and supersedes V2.1 wherever they conflict. V1 and V2.1 documents are historical reference only. Security policy and accepted ADRs are mandatory engineering constraints.

## Non-negotiable controls
- Tenant and actor identity must come from trusted authentication context; never trust caller-supplied tenant IDs or roles.
- Never bypass AI Security Harness, Security Policy Registry, server-side authorization, classification, lineage, quota or required human approval.
- No direct AI-provider egress from domain services, workers, cron jobs, frontends or agent runtimes. Only the approved AI Gateway may reach approved providers.
- Unknown classification is deny. C2/C3 must not be sent to external AI. Derived content inherits the highest parent classification and cannot widen ACLs.
- No cross-service foreign keys, direct cross-service DB reads/writes or shared-schema ownership violations.
- RAG resource authorization is server-side; caller-provided resource ID lists are not authorization.
- Billable operations reserve quota before execution and reconcile usage idempotently. Never bypass hard limits.
- Retries must be bounded and idempotent. Fallback requires fresh policy validation and an equivalent-or-stricter approved provider/model.
- Do not log prompts, OCR text, retrieved chunks, secrets or raw sensitive payloads.
- Protected operations fail closed when mandatory policy, authorization, DLP, lineage or quota controls are unavailable.

## Change control and completion
Architecture/security deviations require an ADR and human approval. Security-sensitive changes require independent human review; the implementing agent cannot approve its own work. A task is complete only with tests, reproducible evidence, migration/rollback notes, updated docs/contracts and a report of residual risks. Never claim a test passed without its output.
