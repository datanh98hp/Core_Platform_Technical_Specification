# Investment Baseline V1.1 — Core Platform V2.2

**Plan:** CP-V2.2-EXEC-001 / V1.1  
**Status:** PROPOSED — not a purchase authorization or supplier quotation  
**Currency:** VND  
**Maximum envelope:** VND 180,000,000  
**Phase-controlled subtotal:** VND 165,000,000  
**Owner-controlled contingency:** VND 15,000,000  
**Basis date:** 2026-11-25

## 1. Investment decision

The investment ceiling is capped at VND 180m. VND 165m is allocated to defined phase ceilings; VND 15m is held centrally and may be used only through a separate approved Change Request. This envelope funds discovery through production-readiness work for one AI Office product and a controlled pilot. It does not fund a second product line or unlimited custom implementation.

This is a planning model. Rates, vendor availability, cloud/provider prices and tax treatment must be validated with written all-in quotations before the relevant commitment.

## 2. Phase ceilings and allocation by cost category

Amounts below are in VND millions. Categories are budget caps, not guaranteed invoices.

| Phase | Engineering | QA / security | BA / UX | Legal / privacy | Cloud + AI | Tools | Pilot ops | Data/test assets | Admin | Total |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| G0 | 0 | 0 | 4 | 1 | 0.5 | 0 | 0 | 0 | 2.5 | **8** |
| G1 | 11 | 1 | 1 | 0 | 2 | 1 | 0 | 0 | 2 | **18** |
| G2 | 17 | 8 | 0 | 1 | 2 | 1 | 0 | 0 | 3 | **32** |
| G3 | 30 | 2 | 4 | 1 | 4 | 1 | 0 | 0 | 0 | **42** |
| G4 | 15 | 2 | 0 | 0 | 3 | 1 | 0 | 0 | 2 | **23** |
| G5 | 7 | 1 | 2 | 2 | 4 | 0 | 5 | 1 | 0 | **22** |
| G6 | 6 | 2 | 0 | 3 | 1.5 | 0 | 5 | 2.5 | 0 | **20** |
| **Total** | **86** | **16** | **11** | **8** | **17** | **4** | **10** | **3.5** | **9.5** | **165** |

| Funding component | Amount |
|---|---:|
| Phase-controlled budgets | VND 165,000,000 |
| Owner-controlled contingency | VND 15,000,000 |
| **Maximum proposed investment** | **VND 180,000,000** |

The higher G2 and G4 allocations reflect security engineering, independent testing and control-plane work. G3 remains the largest product build package but is limited to three approved workflows.

## 3. Cost category definitions

- **Engineering — VND 86m:** external platform/backend/frontend implementation, integration and technical documentation.
- **QA/security — VND 16m:** independent security review, test design, automated regression, load and release verification. The implementer cannot approve their own security-sensitive work.
- **BA/UX — VND 11m:** discovery, workflow mapping, user research, product requirements and usability.
- **Legal/privacy — VND 8m:** contract and data-processing review, privacy/legal issue review, IP/licence and launch-document review. The allowance is not a legal compliance guarantee.
- **Cloud + AI — VND 17m:** development/staging compute, storage, monitoring, network and bounded LLM/OCR/API usage. Production run-rate beyond the approved launch setup must be forecast separately.
- **Tools — VND 4m:** necessary design, repository, test, monitoring and developer-tool licences.
- **Pilot operations — VND 10m:** onboarding, customer training, controlled support and pilot operations.
- **Data/test assets — VND 3.5m:** synthetic/anonymized test data preparation, document corpus and approved migration test assets.
- **Administration — VND 9.5m:** project operations, procurement, accounting/tax administration and documented coordination. Founder salary is not included.

## 4. Effort and rate assumptions

Initial external effort envelope (to be reconciled against SOWs in G0):

| Workstream | Planning rate assumption | Implied effort range from category ceiling |
|---|---:|---:|
| Engineering | VND 0.75–1.00m / person-day | 86–115 person-days |
| QA / security | VND 0.80–1.20m / person-day | 13–20 person-days |
| BA / UX | VND 0.60–0.85m / person-day | 13–18 person-days |
| Legal/privacy | Quote-based by counsel and scope | Not converted to generic person-days |

These are estimating assumptions only, not market quotations. They imply roughly 112–153 external specialist person-days across engineering, QA/security and BA/UX. The exact mix must be converted into named work packages, supplier availability and deliverable-based SOWs before G0 is closed.

Founder/Project Owner time is not a cash cost in this envelope. The execution model assumes at least 16 hours/week of Product Owner availability during active delivery. If that capacity is unavailable, reschedule before locking the baseline; do not silently substitute unreviewed agent decisions.

## 5. Four-week cash-flow forecast

This is a forecast of the VND 165m phase subtotal, spread proportionally across each phase window. It is a planning profile, not permission to spend. Actual cash timing follows approved contracts, invoices and phase authorization.

| Period | Forecast cash envelope |
|---|---:|
| Weeks 1–4 | VND 20.00m |
| Weeks 5–8 | VND 22.00m |
| Weeks 9–12 | VND 21.25m |
| Weeks 13–16 | VND 21.00m |
| Weeks 17–20 | VND 20.35m |
| Weeks 21–24 | VND 18.40m |
| Weeks 25–28 | VND 14.67m |
| Weeks 29–32 | VND 17.33m |
| Weeks 33–36 | VND 10.00m |
| **Total phase forecast** | **VND 165.00m** |
| Contingency (not forecast to be spent) | VND 15.00m |
| **Maximum envelope** | **VND 180.00m** |

## 6. Tax, VAT, procurement and commitment rules

- All cost ceilings are gross cash ceilings. Supplier quotes must state VAT, withholding, transaction fees, foreign-exchange basis and any pass-through charge. Do not assume input VAT is recoverable; accounting must confirm treatment.
- Compare suppliers on total cost for the same deliverables, IP ownership/assignment, security requirements, support, termination and handover.
- External contracts must cover confidentiality, data-processing instructions, subprocessor approval where applicable, code/IP assignment, open-source obligations, credential management, incident notification, deletion/return of data and access termination.
- No annual prepaid subscription or non-cancellable recurring commitment without an explicit owner decision and a cash-runway check.
- No contractor receives production/customer data by default. Access is least privilege and time bounded.

## 7. Forecast control and stop thresholds

At each weekly review and phase gate, record budget, committed cost, paid cost, forecast-to-complete and variance:

- At 75% of a phase ceiling: update estimate-to-complete and identify remaining acceptance evidence.
- At 90%: freeze discretionary additions and present a recovery/descoping plan.
- At 100%: stop new commitments in that phase. Only an approved CR can authorize a change.
- The contingency is not a general overrun buffer. A CR must quantify the amount, cause, options, impact on runway and the new forecast.
- No automatic reallocation between phases.

## 8. Operating cost and unit economics after pilot

The VND 180m envelope is for the planned build, controlled pilot and production-readiness period through G6. It does not establish an unlimited post-launch operating budget.

G5 must record actual per-tenant monthly run-rate and calculate:
- infrastructure, database, storage, egress, monitoring and backup;
- LLM, embedding, OCR and connector charges;
- human review, onboarding, support and incident handling;
- payment, tax and other variable service-delivery costs.

G6 must approve a 12-month base/downside cash forecast, customer/tenant capacity plan, monthly spend cap and kill-switch thresholds before production release. For a standard recurring subscription, calculate price floor as total variable monthly COGS divided by (1 − target gross margin). The initial gross-margin target is at least 55% after all variable delivery costs, not only AI provider costs. The AI-provider cost ratio target of ≤20% of same-scope recurring revenue is a separate sub-metric.

## 9. Exclusions and re-approval triggers

Excluded from this envelope unless separately approved: founder salary, hardware purchases, formal certification/audit, on-premises or dedicated single-tenant delivery, more than three workflows, broad CRM/ERP/finance/inventory modules, custom model training, unbounded data migration, unapproved connectors, large-scale customer acquisition/paid advertising, and post-launch operating runway beyond the G6-approved launch plan.

Any excluded item requires a new estimate and CR. If validated supplier quotes exceed the ceilings, choose among narrower scope, a later date or no-go. Do not exceed VND 180m implicitly.
