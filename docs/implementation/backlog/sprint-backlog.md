# Sprint backlog — 8 sprints × 2 weeks

Capacity assumption: Founder is product/architecture owner and lead engineer; specialist contractors work on bounded modules. Re-estimate after Sprint 1. Sprint 0 is a one-week architecture gate.

## Sprint 0 — Architecture decisions (1 week)
- ADR service boundaries and database ownership.
- Select OIDC/auth approach, MinIO edition/license/support, NATS retention/replication, PostgreSQL/RLS strategy.
- Define UUID, timestamp UTC, API casing, error taxonomy and compatibility policy.
**Exit:** ADRs approved; local environment reproducible.

## Sprint 1 — Platform foundation
- Monorepo skeleton and service templates.
- Compose infrastructure and SQL bootstrap/migration runner.
- Health/live, health/ready, structured logging and trace IDs.
- Identity: users, organizations, memberships.
**Acceptance:** clean clone starts infrastructure; migrations pass; membership tests pass.

## Sprint 2 — Authorization and Core Business
- Roles, permissions, membership-role mapping.
- Login/refresh/logout integration with chosen auth component.
- Tenant context and resource authorization middleware.
- Workspace, entitlements, settings APIs.
**Acceptance:** cross-tenant negative tests pass; revoked sessions denied; quota enforced server-side.

## Sprint 3 — Communication backbone
- Compile protobuf contracts and generate stubs.
- gRPC interceptors: auth, deadlines, tracing, error mapping.
- NATS streams/consumers and subject permissions.
- Transactional outbox, consumer inbox and schema validation.
**Acceptance:** duplicate event has one logical effect; replay/restart safe; traces correlate.

## Sprint 4 — Document and object storage
- Storage Adapter and MinIO integration.
- Signed upload/download, complete-upload verification.
- Document versions, processing jobs and artifacts.
- OCR/parser worker interface, validation, deletion lifecycle.
**Acceptance:** direct upload works; invalid size/MIME/checksum rejected; retries/DLQ tested.

## Sprint 5 — AI Engine and Knowledge
- Provider/model registry and secret references.
- Prompt versioning, routing, quota, timeout and usage metering.
- Knowledge base/source/chunk schema, embedding and hybrid retrieval.
- ACL-aware retrieval and evaluation dataset.
**Acceptance:** no cross-tenant retrieval; citations resolve to authorized source; usage reconciles.

## Sprint 6 — Workflow and Integration
- Immutable workflow versions, run/task state machine.
- Human approval, task inbox and audit history.
- Webhook subscriptions, signature, SSRF protection, retry/DLQ.
- Notification and connector secret references.
**Acceptance:** start/complete idempotent; unauthorized approval blocked; webhook retry tested.

## Sprint 7 — Hardening
- Load tests: baseline, ramp, burst, soak, noisy tenant.
- DB/index/pool/cache/worker tuning.
- Security tests: IDOR, privilege escalation, SSRF, upload abuse.
- PostgreSQL/object backup and restore drill.
- Dashboards, alerts, runbooks, dependency/license inventory.
**Acceptance:** agreed SLO profile passed; zero cross-tenant findings; measured RTO/RPO documented.

## Sprint 8 — Pilot
- Tenant provisioning, admin onboarding and module configuration.
- Usage/cost dashboard and customer support process.
- UAT, privacy/data-processing terms and customer configuration.
- Release/rollback checklist and feedback loop.
**Acceptance:** pilot UAT signed; critical defects closed; support and recovery runbooks accepted.

## Definition of Done
Reviewed code; unit/integration/contract/security tests; migrations tested; API/proto/event contracts versioned; logs/metrics/traces without sensitive content; tenant authorization; timeout/retry/idempotency; runbook and operational owner.
