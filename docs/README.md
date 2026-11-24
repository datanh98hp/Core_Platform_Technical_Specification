# Core Platform Documentation — V2.2 Active Baseline

**Mandatory entrypoint for every AI coding agent, developer and reviewer.** Read this file before any repository task.

## Document precedence
1. `AGENTS.md` and this README define repository-wide agent entry requirements.
2. `governance/AI_Agent_Coding_Governance_v2.2.md` defines the mandatory agent workflow and prohibitions.
3. `architecture/Core_Platform_Technical_Specification_V2.2.md` is the active architecture/security baseline.
4. Accepted ADRs under `adr/` are binding decisions.
5. SQL, gRPC, security acceptance tests and the implementation backlog define implementation contracts.

V2.2 supersedes V2.1 wherever they conflict. V1/V2.1 material is historical reference only and must not be treated as the active specification.

## V2.2 scope
- Modular multi-tenant Core Platform with API Gateway/BFF and domain services.
- Mandatory AI Security Harness and trusted server-side policy enforcement.
- Security Policy Registry with immutable, approved policy versions.
- Data Lineage for source and derived data, classification/ACL inheritance and deletion propagation.
- Quota & Cost Governance with atomic reservations, usage ledger and reconciliation.
- Resilience with timeouts, bounded retries, idempotency, circuit breaker, bulkheads, DLQ and policy-aware fallback.
- Per-service database ownership; no cross-service foreign keys or direct cross-service database access.

## Read order for implementation
1. `../AGENTS.md`
2. `governance/AI_Agent_Coding_Governance_v2.2.md`
3. `architecture/Core_Platform_Technical_Specification_V2.2.md`
4. Applicable ADRs under `adr/`
5. Relevant schema/proto/OpenAPI/event contracts
6. `implementation/backlog/v2.2-implementation-backlog.md` and `acceptance-matrix.csv`
7. Security policy and acceptance tests before any AI/data-path change

## Release principle
Security controls must be enforced at runtime and tested with negative, cross-tenant, outage/fail-closed, idempotency and deletion-propagation cases. A prompt instruction or an agent self-report is not evidence of enforcement. Security-sensitive changes require independent human review.
