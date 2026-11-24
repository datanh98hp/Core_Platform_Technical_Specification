# G1 — Core Platform Technical Foundation

**Plan version:** 1.0  
**Status:** LOCKED — pending explicit user approval  
**Target window:** Weeks 3–5  
**Planning ceiling:** VND 20,000,000  
**Gate:** G1 → G2  
**Accountable owner:** Technical Owner / Founder

## 1. Purpose

Build the smallest working engineering foundation that conforms to Core Platform Technical Specification V2.2. G1 establishes repeatable development, testing and staging paths; it does not deliver every business capability.

## 2. Entry conditions

- G0 is accepted and the user explicitly authorizes G1.
- PRD and selected workflows are approved.
- Repository baseline, architecture, ADRs and current backlog have been read.
- A task-level work order exists for each implementation unit.

## 3. Work packages

| ID | Work package | Required activities | Deliverable |
|---|---|---|---|
| G1-01 | Repository workflow | Branch conventions, PR template, CODEOWNERS and CI baseline | Reviewed repository workflow |
| G1-02 | Application skeleton | Next.js/React/TypeScript frontend; Python/FastAPI backend; Gateway/BFF boundary | Running frontend and backend skeleton |
| G1-03 | Persistence | PostgreSQL, pgvector where required, per-service schema and DB-role model | Versioned migrations and ownership map |
| G1-04 | Platform adapters | Redis, NATS JetStream and Storage Adapter over MinIO | Local integration contracts |
| G1-05 | Service contracts | OpenAPI, gRPC and event schemas for approved interfaces | Versioned contract set |
| G1-06 | Developer environment | Docker development setup and configuration examples without secrets | Reproducible local environment |
| G1-07 | CI and quality | Build, unit tests, formatting, lint/type checks and dependency checks | Passing CI evidence |
| G1-08 | Observability baseline | OpenTelemetry, safe logs, metrics and error reporting | Basic service-health views |

## 4. In scope

- Foundation modules needed by approved MVP workflows.
- Ownership boundaries for Gateway/BFF, Identity/Tenant, Document, Knowledge, Workflow and AI Gateway interfaces.
- PostgreSQL schema ownership and migration conventions.
- NATS at-least-once delivery, outbox/inbox and idempotent-consumer conventions where events are implemented.
- Development and staging deployment paths.

## 5. Out of scope

- Kubernetes, Kafka or service decomposition without a documented scale/isolation reason and approved change.
- Production high availability or production customer-data processing.
- Cross-service foreign keys, direct cross-service reads/writes or shared business-schema ownership.
- Broad connector catalogue, native mobile applications or unapproved third-party services.
- Implementing security controls as prompt-only behavior.

## 6. Required deliverables

1. Service/module ownership map and component diagram.
2. Running local development environment and staging deployment.
3. Initial schemas, migrations and database roles for implemented services.
4. OpenAPI/proto/event contracts for implemented interfaces.
5. CI pipeline with actual build/test evidence.
6. Observability and safe-logging conventions.
7. Environment-variable reference and secret-handling guide.
8. G1 Gate Review with known gaps and rollback notes.

## 7. Acceptance criteria

- A fresh developer environment can be started from documented steps without undocumented manual edits.
- Frontend and backend build successfully; a representative request reaches backend and persistence.
- CI runs on pull requests and reports actual results.
- Implemented services use owned schemas and service-specific DB permissions.
- No cross-service foreign keys or direct runtime cross-schema reads/writes are introduced.
- Events, where implemented, follow at-least-once semantics with idempotency; no exactly-once claim is made.
- No secret is committed; logs/traces exclude raw sensitive payloads.
- Staging has a documented deploy and rollback procedure.
- The user explicitly approves G1 exit and G2 start.

## 8. Risks and controls

- Overengineering: minimize deployable services while preserving V2.2 boundaries; control-plane modules may be co-located initially.
- Integration drift: contract-first changes and CI validation.
- Unrepeatable environments: pin versions and document setup.
- Secret leakage: examples use placeholders; real secrets belong in an approved secret store.

## 9. Exit gate

**GO to G2** requires a reproducible development/staging baseline, passing CI, documented service ownership, contract and migration evidence, and an accepted known-gap register.

**NO-GO** for unresolved cross-service data coupling, secret leakage, irreproducible builds or unreviewed destructive migrations.
