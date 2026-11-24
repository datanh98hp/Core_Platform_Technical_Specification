# Project Documentation — V2.2 baseline

## Mandatory baseline
**Core Platform Technical Specification V2.2 – Architecture & Security Hardening** is the authoritative baseline. It supersedes V2.1. AI coding agents must not implement against V2.1 assumptions.

## Read first
1. `architecture/Core_Platform_Technical_Specification_V2.2.md` and `.docx`
2. `adr/ADR-011` through `ADR-014`
3. `security/AI_Data_Protection_and_Security_Harness_Policy_v2.2.md`
4. `governance/AI_Agent_Coding_Governance_v2.2.md`
5. `implementation/sql/08-control-plane-v2.2.sql`
6. `implementation/proto/controlplane/v1/controlplane.proto`
7. `implementation/backlog/v2.2-implementation-backlog.md`

## V2.2 additions
- Security Policy Registry with immutable versioning, approval and server-side enforcement.
- Data Lineage across source documents, OCR, chunks, embeddings, retrieval contexts and AI outputs.
- Quota & Cost Governance with atomic reservations, immutable ledger and reconciliation.
- Resilience with deadlines, retries, circuit breaker, bulkheads, DLQ and policy-aware fallback.
- No cross-service foreign keys or direct cross-schema runtime access.
- Expanded SEC-016…SEC-025 acceptance tests.

## Migration caution
V2.1 assets are retained as historical implementation material. They are not authority where they conflict with V2.2. The V2.2 SQL migration creates control-plane structures but intentionally does not blindly drop existing cross-service foreign keys. Inspect the deployed schema, back up, test on a sanitized clone and apply reviewed constraint-removal migrations separately.

## Folder map
- `architecture/` — technical specification
- `adr/` — architecture decision records
- `security/` — AI data protection and Harness policy
- `governance/` — AI coding agent rules
- `implementation/sql/` — database schema and ownership rules
- `implementation/proto/` — gRPC contracts
- `implementation/backlog/` — implementation and acceptance backlog
- `implementation/deploy/` — development/pilot infrastructure
