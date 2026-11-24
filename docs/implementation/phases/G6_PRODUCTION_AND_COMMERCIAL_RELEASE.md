# G6 — Production Hardening and Commercial Release

**Plan version:** 1.0  
**Status:** LOCKED — pending explicit user approval  
**Target window:** Weeks 27–30  
**Planning ceiling:** VND 20,000,000  
**Gate:** G6 → Commercial Operations  
**Accountable owner:** Technical Owner and Product Owner

## 1. Purpose

Convert the validated pilot service into a supportable production offering. G6 closes operational, security, reliability, commercial and legal readiness gaps for the exact released scope.

## 2. Entry conditions

- G5 is accepted and the user explicitly authorizes G6.
- Pilot results, customer commitments, operating costs and known gaps are available.
- Production scope, target environment, SLOs, support model and data locations are approved.
- A named operational owner and incident escalation path exist.
- Legal review confirms required product, customer and supplier documents for the launch scope.

## 3. Work packages and backlog mapping

| ID | Work package | Required activities | Backlog mapping |
|---|---|---|---|
| G6-01 | Runtime resilience | Deadlines, bounded retry+jitter, idempotency and circuit breaker validation | BL-019…021 |
| G6-02 | Isolation and queues | Bulkheads, concurrency limits, DLQ, poison-message handling and audited redrive | BL-022…023 |
| G6-03 | Observability | SLI/SLO dashboards and alerts for latency, errors, queue age, spend, policy and deletion lag | BL-024, BL-028 |
| G6-04 | Security pipeline | SAST, SCA, secret, IaC/container checks and sanitized DAST | BL-025 |
| G6-05 | Secrets and credentials | Production secret manager, least privilege and rotation | BL-026 |
| G6-06 | Backup/restore | Encrypted offsite/immutable backup and restore drills | BL-027 |
| G6-07 | Operational readiness | Runbooks, incident response, load/soak/chaos tests and support roster | BL-028 |
| G6-08 | Storage review | MinIO licensing, support, lifecycle, durability and restore assessment | BL-029 |
| G6-09 | Deployment model | Document pilot vs production topology; confirm Compose is not HA | BL-030 |
| G6-10 | Commercial/legal | Pricing, subscription terms, privacy/data terms, SLA/support and onboarding pack | Project/legal workstream |

## 4. In scope

- Production infrastructure for the approved AI Office scope.
- Security, reliability, backup/restore, observability and incident response.
- Pricing, onboarding, support, product documentation and contract readiness.
- A staged release with controlled tenant onboarding and rollback.

## 5. Out of scope

- Opening the service to unlimited self-service tenants before capacity and abuse controls are validated.
- New product modules or major architecture changes.
- Claims of certifications, legal compliance or availability levels that have not been independently verified.
- Production deployment using development-only Docker Compose as a high-availability design.
- Unapproved spend, provider, region or retention changes.

## 6. Required deliverables

1. Production architecture and deployment diagram.
2. CI security scan and release evidence.
3. Secret-management and credential-rotation evidence.
4. Backup policy and successful restore-drill report.
5. SLO/SLI definition, dashboards, alerts and escalation runbooks.
6. Load/soak/chaos results for agreed workloads.
7. Storage-provider assessment and decision.
8. Customer support, SLA, pricing and onboarding documentation.
9. Legal/privacy/contract review record for launch scope.
10. Production Go/No-Go review with rollback plan.

## 7. Acceptance criteria

- All applicable P0/P1 acceptance tests pass on the release candidate.
- No unresolved critical/high security finding remains unless the authorized owner explicitly accepts a documented residual risk; legal/security prohibitions cannot be waived by a product preference.
- Production secrets are not stored in source control; access is least-privilege and rotation is documented.
- Backup restore has been executed successfully and recovery evidence is retained.
- Load/soak tests meet the SLOs explicitly approved for the expected launch workload.
- Monitoring and on-call/escalation ownership are active before onboarding production tenants.
- Rollback and incident-response procedures have been rehearsed.
- Contracts, privacy disclosures, data-processing terms and subprocessors are reviewed for the released scope.
- Production deployment is explicitly approved by the user after the Go/No-Go pack is presented.

## 8. Risks and controls

- **Pilot-to-production gap:** use measured pilot workload and make SLOs explicit.
- **Backup exists but cannot restore:** require timed restore drill.
- **Unexpected provider cost:** hard budgets, alerts and kill switch.
- **Unclear support obligations:** publish supported hours, severity definitions and response commitments.
- **Storage licensing/support risk:** record decision and approved alternative before launch.

## 9. Exit gate

**GO to commercial release** requires a signed Go/No-Go decision, accepted operational evidence, approved production configuration, legal/customer documentation, pricing and support ownership.

**NO-GO** for unresolved critical security findings, failed restore, unowned incident response, unapproved provider/data route, or production configuration that does not meet the approved SLO.
