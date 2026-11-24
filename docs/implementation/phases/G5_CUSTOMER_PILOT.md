# G5 — Customer Pilot and Value Validation

**Plan version:** 1.1  
**Status:** LOCKED — pending explicit user approval  
**Target window:** Weeks 25–30
**Planning ceiling:** VND 22,000,000
**Gate:** G5 → G6  
**Accountable owner:** Product Owner / Customer Success Owner

## 1. Purpose

Validate AI Office with real business users under controlled, documented conditions. The pilot must establish value, reliability, adoption and unit economics before production commercialization.

## 2. Entry conditions

- G4 is accepted and the user explicitly authorizes G5.
- G2 P0 and G4 P1 security gates are accepted for the pilot scope.
- At least 2 design partners are confirmed; target 3–5 participating SMEs.
- Customer contracts, data-processing terms, privacy notices/consents or other lawful basis, subprocessors and data location have been reviewed by qualified counsel as applicable.
- Each tenant has an approved data inventory, classification map, role matrix, retention/deletion plan and contact owner.
- Support, incident and escalation contacts are named.

## 3. Work packages

| ID | Work package | Required activities | Deliverable |
|---|---|---|---|
| G5-01 | Pilot selection | Confirm 3–5 SMEs, use cases, sponsor, users and success measures | Signed pilot register |
| G5-02 | Legal/data onboarding | Contract, data-processing terms, provider/subprocessor disclosure, data inventory and retention | Tenant onboarding pack |
| G5-03 | Tenant setup | Configure tenant, roles, policies, quotas, approved connectors and audit | Tenant configuration record |
| G5-04 | Workflow rollout | Start with 1–3 approved workflows per customer; train users | Pilot workflow checklist |
| G5-05 | User support | Weekly feedback, issue triage, training and release notes | Support and feedback log |
| G5-06 | Measurement | Baseline and measure processing time, quality, adoption, failure, cost and satisfaction | KPI dashboard/report |
| G5-07 | Commercial validation | Test willingness to pay, package fit, onboarding effort and renewal intent | Pricing/value report |
| G5-08 | Pilot closeout | Reconcile data, deletion/export commitments, open issues and recommendation | G5 Gate Review |

## 4. In scope

- 3–5 SME pilots where practical and explicitly approved.
- One to three approved workflows per customer.
- Human review of generated outputs and human approval for high-impact/external actions.
- Support hours, response channels and issue severity agreed before pilot.
- Controlled release cadence and auditable configuration changes.

## 5. Out of scope

- General public self-service release.
- Processing customer data outside the approved tenant, purpose, provider or retention scope.
- Using one customer's data to serve another customer or train shared models without a separately approved lawful basis and contract.
- Custom development that changes the shared roadmap without a Change Request.
- Treating pilot participation as permission to publish customer names, logos, data or testimonials.

## 6. KPI definitions and proposed targets

| KPI | Definition | Initial target / decision rule |
|---|---|---|
| Active pilot customers | Customers with at least one workflow used during the measurement period | 3–5 target |
| Paid conversion intent | Customers willing to sign a paid plan or letter of intent | At least 2 |
| Time saved | Difference in median end-to-end task time vs measured baseline | ≥30% on at least 2 workflows |
| Answer quality | Human-reviewed grounded/useful score on approved benchmark | ≥90% target; critical errors reported separately |
| Adoption | Weekly active pilot users / onboarded pilot users | Baseline and trend; approve target after week 1 |
| AI cost ratio | Direct AI provider cost / recurring revenue for the same service scope | Work toward ≤20%; flag unprofitable workflows |
| Severe data incidents | Confirmed severity-1 privacy/security incidents | Zero |
| Support burden | Support and onboarding hours per tenant | Measure and use for packaging |

These are proposed decision thresholds, not guaranteed results. The Product Owner must approve the measurement window, sample, baseline and any target changes before pilot measurement begins.

## 7. Required deliverables

1. Pilot/customer register and signed scope.
2. Tenant data inventory, contract and onboarding evidence.
3. User training and support records.
4. Weekly issue and feedback log.
5. KPI report with raw measurement definitions and baseline.
6. Cost and margin analysis by tenant/workflow.
7. Customer feedback and paid-conversion evidence.
8. Data export/deletion closeout record.
9. G5 Gate Review and recommendation: proceed, extend with approval, narrow or stop.

## 8. Acceptance criteria

- At least 3 pilots are targeted; any lower count requires a documented decision by the user.
- At least 2 customers show credible paid-conversion intent or a documented reason to revise the offer.
- At least 2 workflows show measurable time reduction; initial target is 30% or better.
- Quality, unsupported answers, failure rates and costs are measured and reported separately.
- No severe data/security incident occurs; any incident is handled under the approved response process.
- Customer data is handled within approved purpose, access, provider and retention boundaries.
- Product gaps are ranked by repeated customer evidence, not by isolated requests.
- The user explicitly accepts G5 and authorizes G6.

## 9. Risks and controls

- **Pilot data overexposure:** minimum necessary data and least privilege.
- **Misleading ROI:** establish baseline before using the product.
- **Feature requests create scope creep:** log, score and submit Change Requests.
- **Free-pilot bias:** explicitly test willingness to pay and buying process.
- **Customer dependency:** do not promise custom roadmap changes without owner approval.

## 10. Exit gate

**GO to G6** requires measured product value, acceptable quality/security, unit-cost evidence, documented customer feedback, resolved data closeout and explicit user approval.

**NO-GO** if severe unresolved incidents, noncompliant data flows, unmeasured operating costs or no credible market willingness to pay remain.


## 11. V1.1 amendment — controlled pilot, legal gate and full unit economics

### Pilot environment
G5 is a controlled pre-production/private pilot, not a general production launch. Each pilot tenant must be isolated, separately configured, least-privilege and auditable. The environment must use an approved provider egress path, policy/ACL/lineage/quota controls, restricted administrative access, tested backup, incident contacts, manual fallback and a customer-agreed support window. Development Docker Compose is not accepted as a customer pilot hosting topology.

### Legal and data precondition
Before onboarding each real-data tenant, obtain counsel-reviewed customer scope and applicable contract/data-processing terms, identify controller/processor/subprocessor roles, confirm purpose and lawful basis, document data categories and regions, approve provider/subprocessor routes, retention/deletion, user notices/rights handling and incident escalation. Record the tenant approval checklist in the Legal & Data Governance Register. No data path is enabled from a verbal customer request alone.

### Expanded KPI definitions
Measure per tenant and per workflow:
- baseline and median elapsed handling time, error/rework and human-review time;
- weekly active use, task completion, abandonment and user feedback;
- direct AI/OCR cost, infrastructure/storage/egress, connector and third-party charges;
- onboarding and integration hours, support hours and human quality-assurance time;
- total variable COGS, recurring revenue and gross margin;
- buyer, purchase process, willingness-to-pay range, budget timing and renewal intent.

Direct AI provider cost / same-scope recurring revenue ≤20% remains a target, not a substitute for total COGS. The standard recurring gross-margin target is ≥55% after variable delivery COGS. Report one-time onboarding/integration services separately.

### Additional pilot exit criteria
- 3–5 pilots remain the target; any smaller sample needs an explicit written rationale and owner decision.
- At least two customers provide credible paid-conversion evidence with named buyer, price/budget range and purchase path.
- At least two workflows demonstrate the agreed time/value result against a pre-pilot baseline.
- No severe privacy/security incident; all incident and data-subject requests are handled under approved procedures.
- A data return/deletion/retention closeout plan is agreed for each pilot.
- The Project Owner receives a 12-month operating-cost forecast based on observed usage before authorizing G6 production-readiness work.

The pilot does not authorize public release, new customer segments, unapproved custom work or use of customer data for model training.
