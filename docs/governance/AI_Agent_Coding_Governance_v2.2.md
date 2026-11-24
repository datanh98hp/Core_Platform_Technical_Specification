# AI Agent Coding Governance V2.2

**Mandatory for every AI coding agent.** Read `docs/README.md` first; this file then governs the entire task lifecycle. V2.2 supersedes V1 wherever they conflict.

## 1. Required sequence
1. Read `docs/README.md`, this governance document, V2.2 Technical Specification and applicable ADRs.
2. Confirm task scope, affected services, dependencies, data classification and acceptance criteria.
3. Inspect current implementation and baseline tests; do not assume V2.1 assumptions remain valid.
4. Design contract/schema changes first; preserve service ownership and additive/versioned APIs.
5. Implement backend and migrations; validate tenant isolation, server-side authz, policy, lineage and quota.
6. Implement frontend only after backend contracts are stable.
7. Run unit, integration, contract, E2E, security and migration tests relevant to the task.
8. Run performance/security checks and verify telemetry contains no sensitive payload.
9. Obtain human review for security/architecture changes; deploy only with approved plan.
10. Report changed files, commands, test output, evidence, migrations/rollback and residual risks.

## 2. Prohibited actions
- No bypass of AI Security Harness, Policy Registry, DLP, server-side ACL, Data Lineage, quota or human approval.
- Never trust caller-supplied tenant, actor, role, classification, `external_ai_allowed`, policy decision or RAG `allowed_resource_ids`.
- No direct AI-provider calls from domain services, workers, cron jobs, frontend or coding-agent runtime.
- No cross-service foreign keys or direct cross-schema runtime DB reads/writes.
- No lowering classification or widening ACL on derived data.
- No raw prompts, OCR, RAG chunks, secrets or sensitive payloads in telemetry.
- No unbounded retry, non-idempotent billable retry or duplicate usage charge.
- No provider fallback without fresh policy revalidation and equivalent-or-stricter provider controls.
- No mocked production path used as sole acceptance evidence.
- No claim that tests passed without their actual output.

## 3. Change control
Architecture/security deviations require an ADR, impact/risk analysis and explicit human approval. AI agents may draft ADRs but cannot approve them. Security-sensitive changes require independent human review, not self-approval by the implementing agent. Database migration requires backup, sanitized clone test, forward/rollback plan and reviewed deployment steps. Never perform destructive production migration automatically.

## 4. Definition of Done
- V2.2 and applicable ADRs followed.
- Contracts/schema docs updated and migration-safe.
- Server-side tenant/classification/ACL/policy/lineage/quota checks enforced.
- Positive, negative, cross-tenant, outage/fail-closed, idempotency and deletion tests as relevant.
- No provider egress bypass or raw sensitive telemetry.
- Reproducible CI/test/security evidence.
- Migration, rollback, observability and runbook updates.
- Independent human review for security-sensitive changes.
- Final report accurately states completed work and known gaps.
