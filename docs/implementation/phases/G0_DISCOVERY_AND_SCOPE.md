# G0 — Discovery, Business Validation & Scope Freeze

**Plan version:** 1.0  
**Status:** LOCKED — pending explicit user approval  
**Target window:** Weeks 1–2 from approved project start  
**Planning ceiling:** VND 8,000,000  
**Gate:** G0 → G1  
**Accountable owner:** Product Owner / Founder

## 1. Purpose

Validate the first product scope before implementation. G0 prevents assumptions from being treated as requirements.

The first product target is AI Ops Desk / AI Office, built on Core Platform V2.2. The first release is a focused combination of Document, Knowledge, Assistant and Workflow capabilities for SME operations.

## 2. Entry conditions

- The user has explicitly authorized G0 in writing.
- The current plan revision and V2.2 baseline are accessible.
- A named Product Owner is available to make scope decisions.
- No customer production data is used without a documented lawful basis and approved handling plan.

Without these conditions, agents may perform read-only analysis and prepare questions, but must not implement, commit to suppliers or incur spend.

## 3. Work packages

| ID | Work package | Required activities | Deliverable |
|---|---|---|---|
| G0-01 | Customer discovery | Interview 8–12 SME decision makers/users; capture workflow, pain, volume, time and error cost | Interview notes and evidence summary |
| G0-02 | Problem selection | Rank problems by frequency, value, data availability, feasibility and buyer urgency | Ranked problem statement |
| G0-03 | Design partners | Identify 2–3 candidate design partners; target at least 3 qualified prospects | Design-partner register |
| G0-04 | Workflow baseline | Map 3 candidate workflows, exceptions and human approvals | AS-IS / TO-BE workflow maps |
| G0-05 | Data and legal discovery | Identify data categories, owners, systems, processing locations, providers, retention and permissions | Data inventory and legal issue list |
| G0-06 | Product requirements | Define roles, journeys, functional/non-functional requirements and acceptance criteria | AI Office PRD V1 |
| G0-07 | Delivery baseline | Confirm architecture reuse, dependencies, backlog, ceiling, milestones and risks | G0 gate pack |

## 4. In scope

- Discovery, interviews, workflow mapping and business-value hypotheses.
- Data-flow and data-classification inventory at design level.
- Initial AI Office product requirements and success hypotheses.
- Selection of no more than three MVP workflows.
- Identification of legal questions for qualified review.

## 5. Out of scope

- Production code, customer-data ingestion or production deployment.
- Supplier contracts, recurring commitments or spend above the approved G0 ceiling.
- Adding CRM, ERP, Finance, Marketing, Inventory or Production to MVP.
- Changing Core Platform V2.2 architecture or security controls.
- Treating interview statements as contractual customer commitments.

## 6. Required deliverables

1. AI Office PRD V1 with personas, problems, use cases, journeys and acceptance criteria.
2. Three workflow specifications including happy path, failure path, human approval and audit requirements.
3. Data inventory: owner, category/classification, source, purpose, storage/region, retention and deletion.
4. Customer discovery evidence summary with anonymized notes where appropriate.
5. Design-partner shortlist and written participation status.
6. Risk, assumption, dependency and open-question register.
7. G0 Gate Review using the project template.

## 7. Acceptance criteria

G0 is accepted only when all are evidenced:

- At least 8 documented interviews, or the Product Owner approves a documented alternative sample and rationale.
- At least 3 recurring business problems have evidence; no more than 3 workflows are selected for MVP.
- At least 2 prospective design partners have expressed willingness to evaluate a pilot; target is 3.
- Each selected workflow has an identified user, trigger, input, output, exception path, human decision point and baseline metric.
- Data sources, owners, classifications and intended AI processing routes are recorded. Unknown classification remains blocked.
- Legal/privacy/provider issues are assigned for qualified review; unresolved blockers are not treated as approved.
- PRD, backlog, estimates and risks are reviewed by the Product Owner.
- The user explicitly approves the G0 exit and G1 start.

## 8. Risks and controls

- Weak customer signal: return to discovery rather than coding speculative features.
- No lawful data access: use synthetic or properly anonymized data; block real-data processing.
- Unbounded MVP: reject features not tied to an approved workflow.
- Unverified ROI: mark assumptions as hypotheses and measure them during pilot.

## 9. Exit gate

**GO to G1** requires an accepted G0 Gate Review, approved PRD V1, selected workflows, initial data/legal review, named design partners and explicit user authorization.

**NO-GO** if customer evidence, lawful data path or MVP boundary is unclear. Record the blocker and request a decision; do not silently broaden discovery or start G1.
