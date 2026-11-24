# Core Platform V2.2 — Project Execution & Investment Plan

**Plan ID:** CP-V2.2-EXEC-001  
**Plan version:** 1.1  
**Status:** PROPOSED — owner approval required; not yet an authorized spending or execution baseline  
**Baseline architecture:** Core Platform Technical Specification V2.2  
**First product:** AI Ops Desk / AI Office  
**Delivery horizon:** 36 weeks (34 planned delivery weeks + 2 schedule-reserve weeks)  
**Maximum investment envelope:** VND 180,000,000, inclusive of VND 15,000,000 owner-controlled contingency  
**Decision owner:** Project Owner / Founder  
**Revision date:** 2026-11-25  
**Supersedes:** Plan V1.0 as the proposed candidate only; V1.0 remains in Git history

> This revision is a decision-ready proposal, not an approval. It does not authorize G0–G6, supplier commitments, customer-data processing, production deployment or spending. Approval of this document and authorization of each phase are separate decisions. All phases remain LOCKED until the Project Owner records explicit authorization.

## 1. Executive decision

Adopt a narrow, evidence-led, hybrid SaaS + implementation strategy. Build the shared Core Platform once, commercialize AI Ops Desk / AI Office first, and open further product modules only after repeatable customer demand is demonstrated.

V1.1 corrects the priority, investment and delivery weaknesses identified in the V1.0 review:

1. P0 policy, lineage/provenance and deletion controls are implemented on the MVP path in G2; they are not deferred until G4.
2. G4 completes the control-plane lifecycle and includes essential circuit-breaker and approved-fallback behavior before customer pilot.
3. The VND 180m envelope now has a phase allocation, cost categories, effort/rate assumptions, cash-flow forecast and stop rules.
4. The delivery baseline is 36 weeks, including explicit schedule reserve.
5. AI quality, service SLOs, unit economics and legal/data governance have measurable acceptance criteria and evidence owners.
6. Repository approval controls are distinguished from documentation checks; a passing CI run is not an approval.

**Investment recommendation:** conditional approval of the plan structure and ceilings only after G0 validates the ICP, supplier quotes, available capacity, legal applicability and recurring operating cost. Do not represent the current estimates as guaranteed delivery cost or guaranteed commercial outcomes.

## 2. Product, customer and commercial boundary

### 2.1 First product

AI Ops Desk / AI Office combines only the capabilities required by up to three approved workflows:

- Document intake, versioning, metadata and bounded OCR/extraction.
- Tenant-aware Knowledge ingestion and permission-aware retrieval.
- AI Assistant for grounded Q&A, summaries and extraction with citations and abstention.
- Workflow assignment, approvals, status, history and audit.
- Basic tenant administration, usage and cost visibility.

No autonomous high-impact external action is permitted. Human approval is mandatory for external communications, financial commitments, irreversible operations and privileged actions.

### 2.2 Ideal Customer Profile (ICP) — decision deferred to G0

“Vietnamese SME” is not a sufficient ICP. G0 must select one initial vertical/use-case cluster and document:

- Employee and operational scale, business model and system maturity.
- Economic buyer, process owner, daily user and security/data approver.
- One recurring high-friction process with measurable volume, time, error or delay cost.
- Data availability, ownership, quality, classification and lawful processing path.
- Existing tools and integration requirements.
- Buying trigger, willingness-to-pay evidence, budget owner and procurement cycle.

Score candidate segments using pain frequency, economic value, urgency, data readiness, repeatability, implementation effort, sales cycle and willingness to pay. Select one primary ICP for the first commercial offer; do not design the MVP to serve every SME sector.

### 2.3 Packaging hypothesis

The initial commercial package is:

1. Recurring SaaS subscription for the standard multi-tenant service.
2. One-time onboarding and configuration fee.
3. Separately scoped integration/data-migration fee.
4. Metered usage tier or overage for AI/OCR/storage/connector consumption.
5. Optional support tier with explicitly defined service hours and response targets.

G5 must test willingness to pay and onboarding effort. G6 must approve an actual price book and a 12-month operating forecast. No price or SLA is promised by this planning document.

### 2.4 Deployment boundary

The default MVP and first release target is a standard multi-tenant SaaS deployment with strict tenant isolation. Dedicated single-tenant/private-cloud deployment is a separately priced option only after a Change Request, threat model, operating-cost analysis and owner approval. On-premises deployment is excluded from the first release.

## 3. Scope and product expansion rules

The first release excludes separate CRM, Customer Service, Marketing Automation, Project/Resource Management, Inventory, Finance, ERP and Production products. Those remain portfolio candidates, not MVP commitments.

A later module may enter discovery only when at least three paying customers demonstrate the same recurring need, or a signed customer-funded scope covers its full delivery and support cost. A single prospect request does not change the roadmap.

## 4. Delivery baseline and stage gates

| Phase | Planned weeks | Duration | Phase ceiling | Purpose | Exit decision |
|---|---:|---:|---:|---|---|
| G0 — Discovery and scope | 1–2 | 2 weeks | VND 8m | Select ICP, validate pain, workflows, data and willingness to pay | Approve PRD, ICP and G1 start |
| G1 — Platform foundation | 3–5 | 3 weeks | VND 18m | Reproducible foundation, contracts, staging and CI | Accept foundation and G2 start |
| G2 — Security P0 | 6–11 | 6 weeks | VND 32m | Enforce P0 controls, including MVP policy and lineage minimums | Independent security gate and G3 start |
| G3 — AI Office MVP | 12–19 | 8 weeks | VND 42m | Deliver no more than three workflows and measured AI quality | Accept MVP and G4 start |
| G4 — Control Plane P1 | 20–24 | 5 weeks | VND 23m | Complete policy/lineage/quota and essential resilience | Accept P1 gate and G5 start |
| G5 — Customer pilot | 25–30 | 6 weeks | VND 22m | Controlled pilot, value measurement and unit economics | Accept pilot and G6 start |
| G6 — Production readiness | 31–34 | 4 weeks | VND 20m | Production hardening, legal/commercial and Go/No-Go | Separate production release decision |
| Schedule reserve | 35–36 | 2 weeks | No automatic spend | Absorb critical-path slippage/defect remediation only | Owner decision to consume |

Phase ceilings total VND 165m. The VND 15m contingency is additional and owner-controlled, giving a maximum envelope of VND 180m. The schedule reserve does not authorize extra scope or additional budget. The schedule may move only through an approved change decision.

### 4.1 Critical path

G0 → G1 → G2 → G3 → G4 → G5 → G6. No phase is skipped. Work may run in parallel only when the approved work order documents independent inputs, owners and acceptance evidence. Legal/data governance runs as a continuous workstream from G0 through G6.

### 4.2 Phase authorization

For every phase, the Project Owner must record both:
- **Start authorization:** named phase and work packages, budget ceiling, start window, resource assumption and constraints.
- **Exit acceptance / next-phase authorization:** gate evidence, residual risks, actual/forecast spend and explicit GO/NO-GO for the next phase.

A passing test, green CI, merged documentation PR or completion report is not phase approval. No automatic progression is permitted.

## 5. Technical sequencing and security baseline

Core Platform V2.2 remains the architectural authority. Keep the approved stack: Next.js/React/TypeScript, Python/FastAPI, gRPC, PostgreSQL/pgvector, Redis, NATS JetStream, MinIO through Storage Adapter, Docker, OpenTelemetry, Prometheus/Grafana, Sentry and GitHub Actions. No Kubernetes/Kafka or new provider/framework is added without evidence and approved CR/ADR.

| Capability | G2 — mandatory P0 minimum on MVP path | G4 — complete P1 capability | G6 — production maturity |
|---|---|---|---|
| Policy | Server-side decision, policy version, deny-by-default, expiry/revoke and revalidation before provider egress/tool call | Full immutable Policy Registry lifecycle, review/approval/activation/revocation, cache invalidation and audit | Operational review, policy-change monitoring and recovery runbooks |
| Data lineage | Source-to-derived provenance for every supported MVP path; classification inheritance and ACL intersection | Full lineage graph across OCR, normalized files, chunks, embeddings, indexes, caches, jobs, context and outputs | Lineage/deletion monitoring, evidence retention and operational reconciliation |
| Deletion/revocation | Immediate access denial; deletion/revocation reaches all derivatives used by MVP; incomplete deletion remains blocked and visible | Complete registered-descendant deletion, retry/reconciliation and evidence | Deletion SLA dashboards, exception runbooks and provider-retention assurance |
| Resilience | Bounded timeouts, idempotency and fail-closed behavior for protected paths | Circuit breaker, bounded retry with jitter, bulkhead, DLQ/poison handling and only policy-approved fallback | Production tuning, alerting, load/soak/chaos testing and on-call procedures |
| Quota/cost | Safe hard-deny when quota dependency is unavailable on protected/billable paths | Atomic reservation, immutable usage ledger, idempotent reconciliation, versioned rate card and tenant budgets | Reconciliation, anomaly alerts, cost-to-serve and margin reporting |

Non-negotiable rules:
- Unknown classification is deny by default. C2/C3 do not go to external AI; C3 is excluded from AI unless a separate isolated design is approved.
- Provider egress occurs only through the approved AI Gateway workload.
- RAG ACL is checked server-side at retrieval and immediately before protected execution; caller-supplied resource lists are not authorization.
- Derived data inherits the highest applicable classification and the strictest applicable ACL.
- Protected operations fail closed when policy, AuthZ, DLP, lineage, quota or audit dependencies are unavailable.
- NATS delivery is at-least-once; outbox/inbox and idempotency are required; do not claim exactly-once.
- Security-sensitive changes require independent human review. A test pass covers only the tested scope.

## 6. Quality, SLO and acceptance baseline

The binding measurement definitions are in:
- docs/implementation/AI_QUALITY_AND_SLO_BASELINE_V1.1.md
- docs/implementation/LEGAL_DATA_GOVERNANCE_REGISTER_V1.1.md
- docs/implementation/INVESTMENT_BASELINE_V1.1.md

G3 must run a versioned benchmark of at least 120 cases (at least 40 per approved workflow). Minimum gates include retrieval Recall@5 ≥90%, citation correctness ≥95%, grounded/useful answer rate ≥90%, abstention precision ≥95% on no-evidence/unauthorized cases, zero cross-tenant/ACL leakage and zero critical safety/security error. Report model/provider latency, P50/P95, error cases and cost separately; do not let an aggregate score hide critical errors.

The initial production SLO candidate is 99.5% monthly availability, non-AI API P95 ≤800ms, standard assistant response P95 ≤20 seconds under the approved workload, RPO ≤24 hours, RTO ≤8 hours, ACL revocation deny-at-next-request with derivative-cache invalidation objective ≤60 seconds, and completion of approved MVP-path deletion within 24 hours. G5 measures feasibility; G6 either confirms these values or submits a CR before release.

## 7. Investment envelope and spend control

| Phase | Ceiling |
|---|---:|
| G0 | VND 8,000,000 |
| G1 | VND 18,000,000 |
| G2 | VND 32,000,000 |
| G3 | VND 42,000,000 |
| G4 | VND 23,000,000 |
| G5 | VND 22,000,000 |
| G6 | VND 20,000,000 |
| **Phase budget subtotal** | **VND 165,000,000** |
| Owner-controlled contingency | VND 15,000,000 |
| **Maximum investment envelope** | **VND 180,000,000** |

The bottom-up categories, person-day and rate assumptions, period cash-flow forecast, VAT treatment, exclusions and recurring OPEX gate are in the Investment Baseline. The VND 180m is a hard maximum proposal, not a supplier quote. No forecast overrun may be absorbed silently. Unused amounts are not automatically transferred between phases.

**Financial stop rules**
- No purchase order, supplier contract, subscription commitment or paid API usage before the relevant phase approval and approved work order.
- At 75% of a phase ceiling, refresh estimate-to-complete; at 90%, freeze new discretionary scope and submit a recovery plan; at 100%, stop affected commitments unless a CR is approved.
- Contingency requires a separate CR identifying cause, amount, alternatives and impact. The agent cannot approve it.
- G0 must obtain current all-in quotes and verify the effort/capacity plan. If the quotes do not fit, reduce scope or extend/replan; do not assume the VND 180m ceiling increases.
- G5 must calculate actual monthly recurring OPEX and prepare a 12-month cash forecast before any production release.

## 8. Staffing and delivery accountability

The planning model is a lean core team with time-boxed external specialists. Role names below are responsibilities, not evidence that a person has been hired.

| Role | Minimum responsibility | Required evidence/capacity |
|---|---|---|
| Project Owner / Product Owner | ICP, product scope, prioritization, customer decisions, approvals, budget and risk acceptance | Named owner; reserve at least 16 hours/week during active delivery |
| Technical Owner / Architect | Architecture, service boundaries, estimates, technical acceptance and vendor coordination | Named technical accountable person; weekly capacity plan |
| Backend/platform engineer | Identity/tenant, APIs, document/knowledge/workflow and control-plane implementation | Work-package estimate and code-owner assignment |
| Frontend engineer / UX | Approved workflows, administration, accessibility and user feedback | G3 work-package estimate |
| QA / Security reviewer | Test strategy, negative tests, regression, independent security review | Reviewer independent of the author for security-sensitive changes |
| DevOps / SRE | CI, staging, secrets, monitoring, backup/restore, deployment and runbooks | G1/G6 named coverage |
| BA / UX researcher | Interviews, workflow baseline, requirements and pilot usability | G0/G3/G5 evidence |
| Legal / privacy advisor | Applicable law assessment, contracts, data transfer and IP/licensing review | Qualified external review where needed |

Before G0 exits, record named individuals or suppliers, availability, substitution plan, day-rate/SOW, deliverables, acceptance, IP assignment, confidentiality, data-access controls and termination/handback terms. If the Project Owner cannot provide the stated capacity, the schedule must be changed before baseline approval.

## 9. Commercial and pilot gates

G5 targets 3–5 controlled SME pilots. Each pilot needs a signed scope, named sponsor, approved tenant/data map, lawful purpose, support contacts and baseline measurement. At least two customers must show credible paid-conversion intent; the evidence must identify buyer, expected price range, budget path and purchase timing. A verbal compliment is not a conversion signal.

Measure per tenant and per workflow:
- baseline vs post-implementation median handling time and error/rework rate;
- weekly active usage, completion and abandonment;
- AI/OCR/provider cost, hosting/storage/egress and connector cost;
- onboarding, support and human-review hours;
- total COGS, recurring revenue and gross margin;
- renewal/expansion intent and unresolved blockers.

Direct AI provider cost / recurring revenue target: ≤20% for the same service scope. This is not the whole cost model. Target standard recurring gross margin is ≥55% after variable hosting, AI/OCR, storage, support and other delivery COGS are included. Service/onboarding margin is reported separately. If unit economics fail, reprice, cap usage, simplify workflow or stop the offer; do not hide labor in R&D.

## 10. Legal, privacy and data governance

Maintain the Legal & Data Governance Register throughout the project. Before real customer data is used, document customer and startup roles, purpose and lawful basis, data categories/classification, data-subject handling, notice/consent where required, DPA, subprocessors, provider terms, region and cross-border assessment, retention/deletion, incident process, access logs and approved AI use.

The legal baseline must be checked against laws and implementing instruments in force on the actual processing/release date. Do not rely on the former Decree 13/2023 as the current primary basis after its replacement takes effect. Do not assume a startup exemption applies without counsel reviewing the actual service role, data sensitivity and scale. Do not train shared models on customer content without a separate documented lawful basis, contract and approval.

No production customer data may be placed in development tools, external AI providers or test environments merely because credentials or a technical connector exist.

## 11. Release and operational requirements

Docker Compose is for development and controlled testing, not a production high-availability design. G6 must deliver:
- production topology, threat model and data-flow map;
- least-privilege identities and managed secrets with rotation;
- CI security scanning, dependency/licence checks and release provenance;
- tenant-isolation, policy, deletion and quota regression;
- backup restore evidence and timed recovery drill;
- load/soak tests under the agreed pilot-to-launch workload;
- SLO dashboards, paging/escalation ownership, incident and rollback runbooks;
- provider/subprocessor inventory and current contracts;
- approved pricing, terms, privacy information, DPA, support boundaries and 12-month operating forecast.

Production deployment is a separate Go/No-Go decision after G6; approval of G6 work does not authorize release.

## 12. Change control, evidence and risk

Any material change to product scope, ICP, workflow count, architecture, provider/model/region, data classification, legal basis, security control, acceptance threshold, SLO, phase budget, schedule, staffing or supplier requires an approved CR before the changed work begins.

Every gate pack records: scope/version, owner, environment, test commands/methods, dataset/version, observed result, evidence location, reviewer, cost forecast/actual, open risks, residual-risk owner and explicit GO/NO-GO request.

CI validates repository structure and metadata only. It does not prove that business assumptions, legal compliance, security, cost or customer demand are true.

## 13. Current project state and approval

| Item | State |
|---|---|
| Plan V1.1 | PROPOSED — awaiting Project Owner decision |
| CR-001 | PROPOSED — awaiting Project Owner decision |
| G0–G6 | LOCKED / NOT STARTED / NOT AUTHORIZED |
| Contingency VND 15m | LOCKED / NOT AUTHORIZED |
| Production release | NOT AUTHORIZED |

**Project Owner decision:** PENDING  
**Approved plan version:** none  
**Phase currently authorized:** none  
**Evidence:** to be recorded in docs/implementation/APPROVAL_REGISTER.md

This plan becomes the approved investment and execution baseline only after the Project Owner explicitly accepts the exact V1.1 proposal, budget and schedule. Each phase still requires its own start authorization and exit decision.
