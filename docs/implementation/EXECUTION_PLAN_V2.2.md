# Core Platform V2.2 — Project Execution Plan

**Plan ID:** CP-V2.2-EXEC-001  
**Plan version:** 1.0  
**Status:** PROPOSED — awaiting Project Owner review and approval  
**Baseline architecture:** Core Platform Technical Specification V2.2  
**Product objective:** AI Ops Desk / AI Office first  
**Planning horizon:** 30 weeks (approximately 7–8 months)  
**Total planning envelope:** VND 180,000,000  
**Decision owner:** Project Owner / Founder  
**Last authored:** 2026-11-24

> This document is a proposed execution baseline. It does not authorize implementation, supplier commitments, production data processing, spend or deployment. The Project Owner must approve this plan and separately authorize each phase.

## 1. Executive objective

Build a reusable multi-tenant Core Platform and commercialize one focused first product: AI Ops Desk / AI Office for Vietnamese SME customers. The product combines selected Document, Knowledge, Assistant and Workflow capabilities.

The strategy is **platform first, one product first, expansion from evidence**. Do not build twelve independent applications. Reuse the same identity, tenant, AI Gateway, Security Harness, policy, lineage, quota, document, knowledge, workflow and integration capabilities.

## 2. Baseline and precedence

The active architecture/security baseline is V2.2. Read and obey, in order:

1. Repository entrypoint: docs/README.md and root AGENTS.md.
2. Governance: docs/governance/AI_Agent_Coding_Governance_v2.2.md.
3. Architecture: docs/architecture/Core_Platform_Technical_Specification_V2.2.md.
4. Accepted ADRs relevant to the work.
5. This execution plan and the relevant phase document.
6. Contracts, SQL migrations, security policy, acceptance matrix and implementation backlog.
7. Approved task/work order and its acceptance criteria.

If documents conflict, stop and report the exact conflict. Do not choose the easier interpretation. V2.2 architecture/security and accepted ADRs remain authoritative; this execution plan controls delivery sequence, scope and stage budgets. A conflict requires an approved Change Request and, for architecture/security, a superseding ADR.

## 3. Delivery phases

| Phase | Target weeks | Planning ceiling | Purpose | Exit gate |
|---|---:|---:|---|---|
| G0 | 1–2 | VND 8m | Validate customer problem, data and scope | Approved PRD and 3 workflows max |
| G1 | 3–5 | VND 20m | Core technical foundation | Reproducible dev/staging and CI |
| G2 | 6–10 | VND 30m | P0 security foundation | Required P0 security tests pass |
| G3 | 11–17 | VND 45m | AI Office MVP | 3 approved workflows and benchmark |
| G4 | 18–21 | VND 18m | P1 control plane | Policy/lineage/quota/resilience acceptance |
| G5 | 22–26 | VND 24m | Customer pilot | Value, quality, cost and conversion evidence |
| G6 | 27–30 | VND 20m | Production hardening and commercial release | Production Go/No-Go |
| Reserve | Owner-controlled | VND 15m | Approved contingency only | Separate written approval |

Phase ceilings total VND 165m; reserve is VND 15m; total planning envelope is VND 180m. These are planning estimates, not supplier quotations or automatic spending authority. Founder salary is not assumed. Third-party AI, hosting, legal, tax and supplier costs must be forecast and tracked; any overrun requires approval before commitment. Unused funds are not automatically reallocated.

## 4. Dependency and gate sequence

G0 → G1 → G2 → G3 → G4 → G5 → G6.

A phase may have internal parallel tasks only where the approved phase document and task dependencies permit it. No phase may be skipped. No subsequent phase starts merely because its predecessor appears technically complete. The Project Owner must explicitly approve both:
- **Phase start:** authorizes the named phase, work packages, budget ceiling and time window.
- **Phase exit / next phase:** accepts the gate evidence and authorizes the next phase.

The approval must be recorded in docs/implementation/APPROVAL_REGISTER.md. An approval for one phase does not authorize future phases.

## 5. Phase documents

- G0: phases/G0_DISCOVERY_AND_SCOPE.md
- G1: phases/G1_PLATFORM_FOUNDATION.md
- G2: phases/G2_SECURITY_P0.md
- G3: phases/G3_AI_OFFICE_MVP.md
- G4: phases/G4_CONTROL_PLANE_P1.md
- G5: phases/G5_CUSTOMER_PILOT.md
- G6: phases/G6_PRODUCTION_AND_COMMERCIAL_RELEASE.md

Each phase document is a controlled baseline. AI coding agents must not widen, narrow, reorder or reinterpret its scope without following the Change Control Policy.

## 6. Product boundary

### First product scope
AI Ops Desk / AI Office:
- Document: upload, version, metadata and selected OCR/extraction.
- Knowledge: tenant-aware ingestion, indexing, semantic search and authorized retrieval.
- Assistant: grounded Q&A, summaries and extraction with source citations and safe refusal.
- Workflow: a maximum of three approved first-release workflows, with assignments, approvals and audit history.
- Administration: tenant/users/roles and basic usage/cost visibility.

### Explicitly deferred
AI CRM, Customer Service as a separate product, Marketing Automation, Project/Resource Management, Smart Inventory, AI Finance, Mini ERP and Smart Production are not part of this MVP. They require a later product case, customer evidence, separate scope and approved investment decision.

### Product safety boundary
No autonomous high-impact external action. Human approval is required for sending external communications, financial approvals, irreversible/destructive changes and privileged operations. AI outputs must be visibly identified where required and reviewed according to the approved workflow.

## 7. Technical baseline

Keep the V2.2 stack and boundaries: Next.js/React/TypeScript, Python/FastAPI, gRPC, PostgreSQL/pgvector, Redis, NATS JetStream, MinIO through the Storage Adapter, Docker, OpenTelemetry, Prometheus/Grafana, Sentry and GitHub Actions.

Do not add Kubernetes, Kafka, new providers, frameworks, services or major dependencies without evidence and approval. Control-plane capabilities may initially be modules within existing deployables when V2.2 ownership and security boundaries are preserved.

Mandatory principles include service-owned schemas and DB roles, no cross-service foreign keys/direct cross-service database access, at-least-once events with outbox/inbox and idempotency, AI Gateway-only provider egress, server-side ACL, classification inheritance, fail-closed protected operations and safe telemetry.

## 8. Release gates and required evidence

- **G0:** customer problem evidence, PRD, workflow maps, data inventory, partner shortlist and open legal questions.
- **G1:** buildable codebase, reproducible environment, contracts, migrations, CI and observability.
- **G2:** threat model, egress evidence, tenant/ACL tests, classification tests, SEC-001…017, SEC-022…024 and applicable deletion evidence; independent security review.
- **G3:** working MVP, three workflows, benchmark report, product tests, cost and known-issues register.
- **G4:** SEC-018…021 and SEC-025, P0 regression, deletion/lineage evidence, quota ledger, approved fallback and review.
- **G5:** pilot contracts/onboarding, measured baselines, KPI evidence, feedback, cost/margin and data closeout.
- **G6:** production SLOs, scan results, restore drill, load/soak tests, incident runbooks, legal/contract review, pricing and release approval.

A test result is not accepted without its command or method, environment, dataset/version, observed result, evidence location and reviewer where required. A green CI badge alone is not proof of all security properties.

## 9. Proposed commercial validation targets

The initial hypotheses for G5 are:
- 3–5 SME pilot customers, with a documented owner and scope per customer.
- At least 2 customers show credible paid-conversion intent.
- At least 30% median time reduction on at least two measured workflows.
- At least 90% grounded/useful answers on an approved benchmark, with unsupported and critical errors reported separately.
- Work toward direct AI provider cost at or below 20% of recurring revenue for the same service scope.
- Zero severe security/privacy incidents.

These are proposed decision thresholds. The Product Owner must approve definitions, sample size and measurement window before pilot measurement. Do not present these targets as achieved facts or contractual guarantees.

## 10. Budget governance

- Phase budgets are ceilings, not entitlements.
- No phase spend before explicit phase-start approval.
- Record forecast, committed and actual cost separately.
- Record provider/model, token volume, storage, egress, connector and outsourced labour costs by phase.
- Stop new discretionary commitments when a phase forecast exceeds its ceiling.
- Do not use the VND 15m reserve without a Change Request and explicit Project Owner approval.
- Do not reallocate unused budget between phases without approval.

## 11. Scope control and AI agent constraints

The mandatory rules are in docs/governance/AI_AGENT_EXECUTION_CONTROL_V1.md. In summary:
- Work only on a task listed in an explicitly approved active phase/work order.
- Read the plan and current phase document before each task.
- Never invent requirements, change phase sequence, introduce dependencies or relax acceptance/security criteria.
- If a requirement is missing or ambiguous, stop and ask; do not infer approval.
- Any variance is either directly and explicitly requested by the Project Owner, or submitted as a Change Request with impact and options, then held until approval.
- Agents may not approve their own Change Requests, merge to main, alter production or deploy without explicit authorization.
- Every change is made on a branch and through a pull request with actual test evidence.

## 12. Current project state

At publication, all G0–G6 phases are **LOCKED / NOT STARTED / NOT APPROVED**. The plan itself is proposed and requires Project Owner review. No phase-start authorization is implied by creation or review of these documents.

Update docs/implementation/EXECUTION_REGISTER.md and APPROVAL_REGISTER.md only when an explicit owner decision is received. Never fabricate an approval or backdate a decision.

## 13. Plan review cadence

Review progress at the end of each approved work package and each week during an active phase. A review may report variance but does not authorize scope change. At the phase gate, submit a complete Gate Review and wait for the Project Owner's GO/NO-GO decision.

## 14. Approval

**Project Owner decision:** PENDING  
**Approved plan version:** none  
**Approval evidence:** to be recorded in APPROVAL_REGISTER.md  
**Phase currently authorized:** none

This document becomes the execution baseline only after explicit Project Owner approval. Each phase still requires separate authorization.
