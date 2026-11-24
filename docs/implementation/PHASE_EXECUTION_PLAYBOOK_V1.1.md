# Phase Execution Playbook V1.1 — Core Platform V2.2

**Plan ID:** CP-V2.2-EXEC-001  
**Plan version:** 1.1  
**Status:** PROPOSED — execution guidance only; no phase authorized  
**Applies to:** G0–G6  
**Target delivery:** Weeks 1–34; schedule reserve Weeks 35–36  
**Budget ceiling:** Phase ceilings in Execution Plan V1.1; VND 180m total envelope including owner-controlled contingency  
**Owner:** Project Owner / Founder

> This playbook explains how to prepare and execute approved work in each phase. It does not authorize work, spending, customer-data processing, supplier commitment, production changes or deployment. All work-package records below are DRAFT until the Project Owner approves the relevant phase and work orders. G0–G6 remain LOCKED.

## 1. How to use this playbook

Use this document together with:
- docs/implementation/EXECUTION_PLAN_V2.2.md
- the relevant file under docs/implementation/phases/
- docs/implementation/INVESTMENT_BASELINE_V1.1.md
- docs/implementation/AI_QUALITY_AND_SLO_BASELINE_V1.1.md
- docs/implementation/LEGAL_DATA_GOVERNANCE_REGISTER_V1.1.md
- docs/governance/AI_AGENT_EXECUTION_CONTROL_V1.md
- docs/templates/PHASE_TASK_WORK_ORDER_TEMPLATE.md
- docs/templates/PHASE_GATE_REVIEW_TEMPLATE.md
- docs/implementation/APPROVAL_REGISTER.md and EXECUTION_REGISTER.md

The Work Package IDs below are planning identifiers, not authorization references. Before execution, create a separate work order for each bounded package using the repository template. A work order must state exact files/services, acceptance tests, estimate, dependencies, data classification, provider route, reviewer, rollback and budget. Status must remain DRAFT until explicitly approved.

## 2. Universal execution sequence

Every phase follows the same control sequence:

1. **Confirm authorization:** verify approved plan version, phase-start decision, approved work orders, owner, budget and timebox in the approval register.
2. **Preflight:** inspect dependencies, current branch/main state, architecture/ADR, data route, secrets, environment, test data, vendor access and rollback.
3. **Baseline:** capture current behavior, relevant SLI/cost values and tests before changing it.
4. **Implement the smallest vertical slice:** work in a branch; one work order per PR where practical; do not mix unapproved cleanup or expansion.
5. **Verify:** run unit, integration, contract, end-to-end, security, privacy, performance and cost checks applicable to the work order. Keep raw customer content out of telemetry.
6. **Review:** implementer reports; designated reviewer inspects; an independent human reviews security-sensitive changes.
7. **Close work order:** attach PR, commit, test evidence, issues, actual/forecast cost and rollback notes. The owner decides ACCEPTED or REWORK.
8. **Gate review:** prepare the phase gate pack. Recommendation is not approval.
9. **Owner decision:** only the Project Owner may accept the phase and authorize the next phase. Update the approval and execution registers only from durable owner evidence.

**Stop immediately** on cross-tenant access, unauthorized provider egress, C2/C3/UNKNOWN external AI transmission, policy/AuthZ/DLP/lineage/quota fail-open, incomplete deletion that exposes data, secret leakage, unapproved legal/data route or budget ceiling breach. Preserve safe evidence and escalate. Do not disable security tests or bypass approvals.

## 3. Roles and decision rights

| Role | Responsible for | Cannot do alone |
|---|---|---|
| Project Owner / Product Owner (PO) | ICP, scope, priority, customer commitments, budget, phase authorization, residual-risk and release decisions | Delegate statutory obligations or self-certify independent security review |
| Technical Owner / Architect (TO) | Architecture, technical breakdown, dependencies, estimates, design and technical acceptance | Change V2.2 boundaries/provider/security without CR/ADR |
| Backend / Platform Engineer (BE) | API, identity/tenant, document, knowledge, workflow and control-plane implementation | Approve own security-sensitive work |
| Frontend / UX Engineer (FE) | User journeys, workflow UI, accessibility and admin UX | Expand product scope from customer requests |
| QA / Security Reviewer (QA/SEC) | Test strategy, negative/regression tests, independent security review and evidence | Accept legal risk or phase on behalf of PO |
| DevOps / SRE (OPS) | CI, staging, secrets, monitoring, backup/restore, deployment and runbooks | Deploy production without explicit release authorization |
| BA / UX Researcher (BA) | Customer interviews, workflow mapping, PRD and pilot research | Treat interview statements as signed customer commitments |
| Legal / Privacy Counsel (LEGAL) | Applicability, contracts, data-processing roles, cross-border and IP/licence review | Make unqualified assumptions outside agreed legal scope |

One person may hold multiple delivery roles in a lean startup, but the author of a security-sensitive change must not be its sole independent reviewer. If independent review capacity is unavailable, the affected security gate is BLOCKED.

## 4. G0 — Discovery, ICP and scope freeze

**Window:** Weeks 1–2  
**Ceiling:** VND 8m  
**Accountable:** PO; BA leads discovery; TO and LEGAL support  
**Objective:** Select the first ICP and no more than three workflows based on evidence, and create an investable PRD and delivery baseline.

### Ordered work packages

| ID | Timing | Owner | Work and method | Output / Definition of Done |
|---|---|---|---|---|
| G0-WP01 | Day 1 | PO + TO | Kickoff; confirm decision rights, interview ethics, evidence repository, assumptions and stop rules | Discovery brief; interview script; assumption/risk register |
| G0-WP02 | Days 1–6 | BA + PO | Conduct 8–12 interviews with SME buyers, process owners and daily users; capture baseline volume, time, rework, error cost and current workaround | Anonymized interview notes; evidence table; facts separated from hypotheses |
| G0-WP03 | Days 3–7 | PO + BA | Score at least two candidate ICP/vertical clusters on pain, value, urgency, data readiness, repeatability, integration effort, sales cycle and willingness to pay | ICP scorecard; one primary ICP recommendation; rejected-segment rationale |
| G0-WP04 | Days 4–8 | BA + TO | Map three candidate workflows AS-IS/TO-BE, exceptions, inputs/outputs, approval boundaries and baseline measures | Workflow maps; maximum three selected MVP workflows |
| G0-WP05 | Days 5–9 | TO + LEGAL | Inventory data owners, categories, classification, source, purpose, provider route, storage region, retention and deletion; identify controller/processor/subprocessor questions | Data inventory; initial legal applicability matrix; prohibited/unknown routes list |
| G0-WP06 | Days 7–10 | TO + PO | Decompose engineering effort, roles, supplier SOWs and all-in quotes; validate cloud/AI/tool costs and 12-month OPEX assumptions | Named resource plan; quote comparison; estimate-to-complete; OPEX assumptions |
| G0-WP07 | Days 9–10 | PO + TO + BA | Complete PRD, acceptance criteria, initial architecture crosswalk, risks, delivery estimates and Gate Review | AI Office PRD V1; ranked backlog; G0 gate pack; explicit GO/NO-GO request |

### Required interview record

For each interview, record customer segment, role, process, frequency, task time, people involved, error/rework, current tool, cost of delay, data source/quality, security restrictions, urgency, buyer and willingness-to-pay evidence. Do not store unnecessary personal data in research notes. “Sounds useful” is not a buying commitment.

### G0 exit criteria

- At least 8 documented interviews, or an owner-approved alternative sample with rationale.
- One primary ICP selected from a scored comparison; buyer and process owner identified.
- At least three recurring pain points have evidence; no more than three workflows selected.
- At least two prospective design partners have a concrete evaluation path.
- Data and legal routes are documented; unknown data classification remains blocked.
- Written or clearly labelled budgetary quotes and named delivery capacity support V1.1 cost/time assumptions.
- PRD, backlog, risks and success metrics accepted by PO.
- Project Owner records G0 acceptance and separately authorizes G1.

**NO-GO:** no identifiable buyer, no recurring problem with measurable cost, no lawful data route, no credible resource plan or costs exceed the envelope without an approved replan.

## 5. G1 — Core Platform foundation

**Window:** Weeks 3–5  
**Ceiling:** VND 18m  
**Accountable:** TO; BE and OPS implement; QA reviews  
**Objective:** Create the smallest reproducible foundation needed by approved MVP workflows, without premature microservice/Kubernetes complexity.

### Ordered work packages

| ID | Timing | Owner | Work and method | Output / Definition of Done |
|---|---|---|---|---|
| G1-WP01 | Week 3 | TO + OPS | Confirm V2.2 architecture/ADR map, repository standards, branch/PR/CODEOWNERS, required CI checks and GitHub Environment protection | Architecture decision map; repository protection evidence or blocking admin action |
| G1-WP02 | Week 3 | BE + OPS | Create repeatable local Docker development and controlled staging configuration; pin versions; separate secrets by environment | Fresh-clone setup succeeds from documented steps; no committed secrets |
| G1-WP03 | Week 3–4 | BE | Implement trusted tenant/actor context and service identity interfaces; define authorization boundaries and role model | Identity/tenant contract; negative tests for forged tenant/actor context |
| G1-WP04 | Week 4 | BE + TO | Establish PostgreSQL schema ownership, per-service DB roles, migration conventions and storage adapter | Versioned migrations; ownership matrix; no cross-service FK/direct DB access |
| G1-WP05 | Week 4 | BE | Establish approved OpenAPI/gRPC/event contracts and NATS conventions for implemented workflows | Versioned contracts; at-least-once/outbox/inbox/idempotency evidence where events exist |
| G1-WP06 | Week 4–5 | BE + OPS | Create Redis, NATS JetStream and Storage Adapter integration paths required by selected MVP workflows | Integration smoke tests; bounded timeouts; no unapproved provider route |
| G1-WP07 | Week 5 | OPS + QA | Add build, lint, type, unit, migration, dependency and safe-telemetry CI; create basic OpenTelemetry/Sentry/metrics | CI evidence; health dashboard; telemetry redaction review |
| G1-WP08 | Week 5 | TO + QA | Reproducibility, boundary and rollback verification; complete G1 Gate Review | G1 evidence pack and owner GO/NO-GO request |

### G1 exit criteria

- Clean setup from a fresh clone; frontend/backend build and representative request persist safely.
- Service/schema/DB-role ownership documented and enforced.
- No prohibited cross-service foreign keys or direct runtime database access.
- Contracts and migration lifecycle reviewed; events make no exactly-once claim.
- CI checks execute on PR; secrets and sensitive telemetry are absent.
- Staging deployment and rollback are documented.
- Baseline operational metrics and known gaps are recorded.
- Project Owner accepts G1 and separately authorizes G2.

**NO-GO:** irreproducible environment, unresolved tenant identity boundary, schema coupling, secret leakage or no reviewer/rollback path.

## 6. G2 — Security P0 foundation

**Window:** Weeks 6–11  
**Ceiling:** VND 32m  
**Accountable:** TO / Security Owner; BE implements; independent QA/SEC reviews  
**Objective:** Deliver a secure vertical slice for the exact MVP data and AI routes. Minimum Policy, Lineage and Deletion requirements in this phase are mandatory; they cannot be deferred to G4.

### Ordered work packages

| ID | Timing | Owner | Work and method | Output / Definition of Done |
|---|---|---|---|---|
| G2-WP01 | Week 6 | TO + QA/SEC | Threat model each approved workflow, trust boundary, AI ingress/egress, tenant and data-store path | Threat model; abuse cases; security test plan; data-flow diagram |
| G2-WP02 | Week 6–7 | BE | Enforce trusted server-side tenant/actor identity and authorization; reject caller-supplied authority | AuthN/AuthZ and tenant-isolation negative tests |
| G2-WP03 | Week 7–8 | BE + QA/SEC | Implement AI Security Harness at prompt, file, OCR, RAG, embedding, tool and output boundaries; treat retrieved content as untrusted | Harness policy/config; prompt-injection and unsafe-input/output tests |
| G2-WP04 | Week 7–8 | OPS + BE | Restrict outbound AI provider access to approved AI Gateway workload; allowlist provider route and credentials | Network/identity egress evidence; provider mock/canary tests |
| G2-WP05 | Week 8–9 | BE | Enforce server-side tenant/resource ACL before RAG context assembly and protected execution; isolate caches | Unauthorized-resource, cross-tenant and cache isolation tests |
| G2-WP06 | Week 8–9 | BE + QA/SEC | Enforce classification: UNKNOWN deny; C2/C3 blocked from external AI; derived artifacts inherit highest classification and strictest ACL | Forged classification/permission and derivative inheritance tests |
| G2-WP07 | Week 9–10 | BE + TO | Implement MVP Policy Decision Minimum: server-side versioned decision, deny-by-default, expiry/revoke and revalidation before egress/tool call | SEC-017 pass for shipped paths; policy-dependency outage fails closed |
| G2-WP08 | Week 9–10 | BE | Implement MVP lineage/provenance across source → OCR/normalized file → chunk/embedding/index → context/output; track ACL/classification | Traceable derivative records; tests for source provenance and inheritance |
| G2-WP09 | Week 10 | BE + OPS | Implement MVP revoke/delete propagation to derivatives, indexes, caches and queued jobs; expose incomplete/retry state | SEC-015 pass for every implemented source/derivative; no hidden incomplete deletion |
| G2-WP10 | Week 10–11 | BE + QA/SEC | Verify DB grants/boundaries and automated SEC matrix; remove unsafe grants only through reviewed migration | SEC-022/023/024 and applicable SEC-001…017 results; migration/rollback evidence |
| G2-WP11 | Week 11 | Independent QA/SEC + PO | Run independent review, triage findings, rerun tests and prepare gate | Security report; critical/high finding disposition; G2 Gate Review |

### Mandatory G2 test groups

Use the authoritative security acceptance matrix and applicable IDs:
- classification, unknown-data and forged-policy bypass;
- prompt/file/OCR/RAG/embedding/tool/output injection and leakage;
- provider egress bypass and AI Gateway-only route;
- tenant and resource ACL isolation;
- current policy version, expiry/revoke and fail-closed dependency;
- lineage/classification/ACL inheritance;
- end-to-end deletion/revocation on every MVP derivative;
- telemetry redaction and no secrets/sensitive payloads;
- database ownership and prohibited access.

### G2 exit criteria

All P0 controls applicable to shipped MVP paths pass with reproducible evidence; no C2/C3/UNKNOWN canary reaches external AI; no unauthorized tenant/resource data enters context; policy/lineage/quota dependency failure fails closed; independent human security review is complete; critical P0 findings are resolved. The owner explicitly accepts G2 and separately authorizes G3.

**NO-GO:** any cross-tenant leak, policy bypass, unauthorized provider egress, incomplete deletion that can expose data, sensitive telemetry leak or unresolved P0 finding.

## 7. G3 — AI Ops Desk / AI Office MVP

**Window:** Weeks 12–19  
**Ceiling:** VND 42m  
**Accountable:** PO and TO; BE/FE implement; QA validates; BA supports usability  
**Objective:** Deliver no more than three approved workflows on the secured platform, with observable AI quality, user value and cost.

### Ordered work packages

| ID | Timing | Owner | Work and method | Output / Definition of Done |
|---|---|---|---|---|
| G3-WP01 | Week 12 | PO + BA + FE | Confirm approved user journeys, roles, states, empty/error/loading states and human approval points | UI acceptance map and workflow story set |
| G3-WP02 | Week 12–14 | BE + FE | Implement Document intake, versioning, metadata and supported-file validation; bounded OCR/extraction | Upload/validation/status flow; unsupported file safely rejected |
| G3-WP03 | Week 13–15 | BE | Implement Knowledge ingestion, normalization, chunking, embedding, indexing and server-side ACL retrieval | Permission-aware knowledge base with source/version trace |
| G3-WP04 | Week 14–16 | BE + FE | Implement Assistant grounded Q&A, summarization and extraction with citations, abstention and safe error behavior | Assistant UI/API; citation resolution and no-evidence refusal tests |
| G3-WP05 | Week 15–17 | BE + FE | Implement maximum three G0-approved workflows: task state, assignment, human approvals, audit and retry-safe behavior | Three end-to-end staging workflows; no unauthorized autonomous actions |
| G3-WP06 | Week 16–18 | BE + OPS | Implement tenant-safe usage/cost visibility, request/job trace IDs and non-sensitive operational metrics | Per-tenant usage and feature cost view; safe telemetry |
| G3-WP07 | Week 17–18 | QA + BA | Build and run 120+ case benchmark; report results per workflow/case family; usability test with representative users | Versioned benchmark, rubric, results, failure/error register |
| G3-WP08 | Week 18–19 | TO + QA + PO | Run security regression, performance/cost tests, resolve release blockers and prepare MVP Gate Review | MVP candidate, deployment/rollback note, accepted limitations and G3 Gate Review |

### MVP workflow implementation order

Follow the exact three workflows selected at G0. For each one, implement in this order:
1. input/source validation and classification;
2. identity, tenant and resource authorization;
3. policy decision and quota pre-check;
4. processing/AI call only through approved gateway;
5. evidence/provenance and citations;
6. human review/approval where required;
7. final state, audit record and user-visible status;
8. error, retry, idempotency, deletion and rollback path.

Do not start with a generic autonomous assistant and retrofit permissions later.

### G3 exit criteria

- All selected workflows complete end-to-end in staging with audit history.
- RAG authorization is enforced before context; citation points to the correct source/version.
- 120+ case benchmark meets the approved per-metric thresholds; zero critical leakage or authorization failure.
- Costs, latency and error cases are measured by workflow/provider.
- Usability evidence, issue register and deployment rollback notes are available.
- No P0 regression; PO accepts G3 and separately authorizes G4.

**NO-GO:** any unauthorized source in context, failed critical metric, unapproved data route, missing human approval or no reproducible benchmark.

## 8. G4 — Control Plane P1

**Window:** Weeks 20–24  
**Ceiling:** VND 23m  
**Accountable:** TO; BE implements; QA/SEC and Finance reviewer inspect  
**Objective:** Complete control-plane lifecycle, metering and essential resilience before any real customer pilot.

### Ordered work packages

| ID | Timing | Owner | Work and method | Output / Definition of Done |
|---|---|---|---|---|
| G4-WP01 | Week 20 | TO + BE | Define immutable policy versions, draft/review/approve/activate/revoke states, audit semantics and API contract | Policy Registry schema/API/state transition tests |
| G4-WP02 | Week 20–21 | BE + QA/SEC | Enforce current policy revalidation and cache invalidation on revoke/activate | Stale/revoked policy denied; SEC-017 race and cache tests |
| G4-WP03 | Week 21 | BE | Complete lineage graph for files, OCR, chunks, embeddings, indexes, caches, jobs, context and outputs | Lineage queries and descendant trace |
| G4-WP04 | Week 21–22 | BE + OPS | Complete deletion job orchestration, retries, provider/storage status and auditable completion evidence | SEC-018/019 applicable tests; incomplete deletion remains visible and blocked |
| G4-WP05 | Week 22 | BE + Finance reviewer | Atomic quota reservation, immutable usage ledger, idempotent reconciliation and versioned rate cards | SEC-020; concurrent reservation and duplicate-charge tests |
| G4-WP06 | Week 22–23 | BE + OPS | Implement circuit breaker per approved provider route, bounded retry+jitter, deadlines, bulkhead and DLQ/poison handling | State transition and outage simulation evidence |
| G4-WP07 | Week 23 | TO + LEGAL + QA | Approve provider fallback matrix; verify region, retention, classification, privacy, quality and quota equivalence; re-evaluate policy on fallback | SEC-021; fallback never turns DENY into ALLOW; safe no-fallback when no equivalent route exists |
| G4-WP08 | Week 23–24 | BE + FE + OPS | Tenant-isolated usage/cost/circuit/deletion dashboards and runbooks | SEC-025; no cross-tenant telemetry exposure |
| G4-WP09 | Week 24 | Independent QA/SEC + PO | Run full P0/P1 regression, review migrations and complete Gate Review | G4 security/operations pack; owner GO/NO-GO |

### G4 exit criteria

- Immutable Policy Registry lifecycle and policy revocation/cache invalidation work.
- Full registered derivative lineage and deletion reconciliation work.
- Quota reservation is atomic and retries cannot duplicate charges.
- Circuit breaker opens on simulated provider outage; fallback is allowlisted and revalidated, or safely denied.
- Tenant cost/usage/circuit telemetry remains isolated.
- SEC-018…025 and relevant P0 regressions pass; independent review complete.
- Customer pilot has approved data routes and operational runbooks.
- Project Owner accepts G4 and separately authorizes G5.

**NO-GO:** stale permission retrieval, incomplete deletion, quota race/duplicate charge, unsafe fallback or tenant cost leakage.

## 9. G5 — Controlled customer pilot

**Window:** Weeks 25–30  
**Ceiling:** VND 22m  
**Accountable:** PO / Customer Success; TO/OPS secure environment; LEGAL reviews customer pack  
**Objective:** Measure workflow value, adoption, quality, reliability, service effort and total cost-to-serve in a controlled pre-production pilot.

### Ordered work packages

| ID | Timing | Owner | Work and method | Output / Definition of Done |
|---|---|---|---|---|
| G5-WP01 | Week 25 | PO + BA | Select 3–5 pilots, sponsor, buyer, user groups and workflow scope; confirm paid-conversion test | Pilot register and signed scope |
| G5-WP02 | Week 25 | LEGAL + PO | Review customer contract, DPA/data terms, purposes, roles, notices, providers/subprocessors, region and retention | Counsel-reviewed tenant onboarding/legal pack |
| G5-WP03 | Week 25–26 | OPS + BE + QA | Configure isolated tenants, roles, policies, quotas, approved provider routes, audit, backup and incident contacts | Tenant readiness checklist and security smoke test |
| G5-WP04 | Week 26 | BA + FE + PO | Capture pre-pilot time/error baseline; train users; obtain feedback and support channels | Baseline dataset and training/acceptance record |
| G5-WP05 | Weeks 26–29 | Customer Success + TO | Roll out 1–3 approved workflows per tenant in controlled waves; review incidents and quality weekly | Tenant-by-tenant rollout evidence and issue register |
| G5-WP06 | Weeks 26–30 | PO + BA + Finance | Measure time saved, errors/rework, adoption, latency, AI/OCR, cloud, human support, onboarding and COGS | Weekly KPI and per-tenant unit-economics report |
| G5-WP07 | Weeks 28–30 | PO + Sales/BA | Validate buyer, proposed price, budget route, implementation fee, renewal and objections | Documented willingness-to-pay evidence; at least two credible conversion paths target |
| G5-WP08 | Week 30 | BE + OPS + LEGAL | Close pilot: export/retention/deletion, access revocation, unresolved issues and 12-month OPEX | Pilot closeout and Gate Review |

### Pilot controls

- G5 is not public self-service production.
- Use only tenant-approved data and providers; minimum necessary data and least privilege.
- No customer content used for shared model training.
- Human review for generated outputs and explicit approval for consequential/external actions.
- Support hours, incident severity and response boundaries are written before onboarding.
- No customer name/logo/testimonial is published without separate permission.

### G5 exit criteria

- Target 3–5 pilots; lower sample requires documented owner decision and rationale.
- At least two credible paid-conversion paths with named buyer, price range, timing and procurement steps.
- At least two workflows show measurable benefit against baseline; target ≥30% median time reduction where applicable.
- AI quality and security thresholds remain satisfied in pilot conditions.
- Full COGS, gross margin, onboarding/support burden and 12-month base/downside OPEX are calculated.
- Data export/deletion and customer closeout are complete or have an approved, time-bound action plan.
- Project Owner accepts G5 and separately authorizes G6.

**NO-GO:** unresolved severe incident, unapproved data route, no measured value, no credible buyer signal or unknown unit economics.

## 10. G6 — Production readiness and commercial release decision

**Window:** Weeks 31–34  
**Ceiling:** VND 20m  
**Accountable:** TO + PO; OPS/SRE and QA/SEC execute; LEGAL reviews launch scope  
**Objective:** Harden the exact pilot-proven scope for a controlled production launch. Completion of G6 work does not itself authorize deployment.

### Ordered work packages

| ID | Timing | Owner | Work and method | Output / Definition of Done |
|---|---|---|---|---|
| G6-WP01 | Week 31 | TO + OPS | Freeze release scope, architecture/topology, capacity, data-flow, threat and provider/subprocessor maps | Production design pack and deployment decision |
| G6-WP02 | Week 31–32 | OPS + QA/SEC | Configure managed secrets, rotation, least privilege, CI security gates, dependency/SBOM/licence scan and release provenance | Security pipeline evidence; no exposed secrets or unreviewed critical dependencies |
| G6-WP03 | Week 32 | OPS + BE | Configure production backup, retention, restore test, RPO/RTO and disaster recovery | Successful timed restore and recovery report |
| G6-WP04 | Week 32–33 | OPS + QA | Run load/soak/chaos at ≥2× pilot peak or approved forecast; measure all SLOs | Signed load and SLO report; capacity limits |
| G6-WP05 | Week 33 | TO + OPS + QA/SEC | Validate monitoring, alerts, incident response, rollback, kill switch, queue/DLQ and provider outage runbooks | Rehearsed incident/rollback evidence |
| G6-WP06 | Week 33 | PO + Finance + LEGAL | Finalize price book, usage caps, support model, customer contract/DPA/privacy notice, supplier terms and 12-month cash runway | Commercial and legal readiness pack |
| G6-WP07 | Week 34 | PO + TO + independent reviewers | Review all acceptance evidence, residual risks, costs and customer scope; produce Go/No-Go | Production release recommendation and owner decision request |
| G6-WP08 | Post-G6 only | PO + OPS | Only after separate written release authorization: deploy exact artifact to exact tenant scope, observe canary, validate rollback readiness | Release record, only within explicit approval limits |

### G6 exit and production release conditions

- All applicable P0/P1 tests pass for the exact release candidate.
- No unresolved critical security finding; residual high risks have explicit authorized disposition and compensating controls.
- RPO/RTO restore drill passes; load/soak tests meet approved SLOs.
- On-call, escalation, incident and rollback owners are named and rehearsed.
- Current legal review, customer terms, DPA, subprocessors/provider routes, privacy disclosures and data retention/deletion procedures are approved.
- 12-month OPEX/runway, price book, capacity limit and gross-margin calculation are approved.
- Project Owner explicitly approves the exact release version, tenant scope, deployment window, spend limit, rollback authority and monitoring period.

**NO-GO:** failed restore, unresolved critical finding, missing legal approval, unapproved provider/data route, unowned incident response, failed SLO or no defensible operating runway.

## 11. Weeks 35–36 — schedule reserve

The two-week reserve is held for critical-path slippage, remediation of verified defects or completion of already-approved gate evidence. It is not a new feature window. Consuming it requires reason/impact analysis, updated work-package estimate and capacity, forecast-to-complete, and Project Owner approval recorded in the register. If remediation cannot fit without exceeding scope or budget, stop and submit a CR for replan.

## 12. Weekly operating cadence

| Cadence | Participants | Required review | Record |
|---|---|---|---|
| Start of week | PO + TO + package owners | Approved work orders, dependencies, capacity, risks and acceptance tests | Weekly plan |
| Twice weekly | Implementers + TO/QA as needed | Blockers, PR status, security findings, scope variance | Task log |
| End of week | PO + TO + finance/QA/LEGAL as relevant | Planned/actual progress, committed/spent/forecast, SLO/quality, customer signal and risks | Weekly status report |
| Before every merge | Implementer + reviewer + owner per policy | Scope, tests, security, rollback and approval metadata | PR review |
| Phase end | PO + TO + independent reviewer | Gate template, evidence, cost, risk and recommendation | Gate Review |
| Next phase | Project Owner | Explicit GO/NO-GO and work/budget authorization | Approval Register |

Every weekly status report must include work-order ID, planned/actual progress, PR/commit, tests/evidence, budget ceiling/committed/paid/forecast, risk/blocker, next decision and any CR. A green CI status is not equivalent to product acceptance.

## 13. Work-order preparation checklist

Before approving a work order, verify:

- [ ] Plan and phase version match the approved baseline.
- [ ] Phase-start approval reference is present.
- [ ] Scope is one measurable outcome and names included/excluded behavior.
- [ ] Dependencies and upstream contracts are accepted.
- [ ] Owner, implementer, reviewer and independent security reviewer are named where required.
- [ ] Files/services/schema/API/provider/region changes are listed.
- [ ] Data classification, tenant boundary, lawful purpose and test-data source are documented.
- [ ] Acceptance criteria map to phase and SEC IDs and name exact commands/methods.
- [ ] Effort, calendar time, cost and phase ceiling are estimated.
- [ ] Migration, rollback, observability and operational ownership are defined.
- [ ] PR and evidence requirements are clear.
- [ ] Any scope variance has an approved CR before implementation.

## 14. Required stage artifacts

| Stage | Minimum evidence pack |
|---|---|
| G0 | Interview evidence, ICP scorecard, workflow maps, PRD, data/legal inventory, quote/resource plan, Gate Review |
| G1 | Architecture/ownership map, migrations/roles, contracts, reproducible environment, CI, staging, safe telemetry and rollback |
| G2 | Threat model, data-flow, provider egress, ACL/classification, MVP policy/lineage/deletion, SEC test results, independent review |
| G3 | MVP release candidate, workflow E2E, benchmark dataset/report, usability, performance/cost, regression and known issues |
| G4 | Policy Registry, lineage/deletion, quota ledger, circuit/fallback, tenant-isolated dashboards, SEC-018…025 and P0 regression |
| G5 | Signed pilot scope, tenant/legal pack, baseline and KPI data, incident log, COGS/margin, customer conversion evidence, data closeout |
| G6 | Production topology, scans, secrets, restore, SLO/load, runbooks, legal/commercial documents, 12-month cash forecast, Go/No-Go |

## 15. Current authorization status

All work packages in this playbook are DRAFT / NOT AUTHORIZED. Plan V1.1 and CR-001 remain PROPOSED. G0–G6 remain LOCKED. The first actionable sequence after plan approval is:

1. Project Owner approves the exact Plan V1.1 and CR-001.
2. Project Owner separately authorizes G0 and its named G0 work orders, ceiling and timebox.
3. G0 is performed and presented for gate review.
4. Project Owner explicitly accepts or rejects G0 and separately authorizes G1.
5. Repeat the same start and exit approval discipline for every subsequent phase.

No silence, CI result, PR merge, completed task or recommendation changes the authorization status.
