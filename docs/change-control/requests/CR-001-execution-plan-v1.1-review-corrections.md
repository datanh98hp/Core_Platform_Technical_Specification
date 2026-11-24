# CR-001 — Execution Plan V1.1 Review Corrections

**CR ID:** CR-001  
**Status:** PROPOSED — awaiting Project Owner decision  
**Raised:** 2026-11-25  
**Raised by:** Project Owner request, prepared for repository review  
**Affected baseline:** CP-V2.2-EXEC-001 / V1.0  
**Proposed baseline:** CP-V2.2-EXEC-001 / V1.1  
**Authorization boundary:** This CR authorizes preparation and review of the plan correction only. It does not authorize G0–G6, spending, supplier commitment, production-data processing or release.

## 1. Current baseline

Plan V1.0 was a useful strategic execution outline but did not sufficiently reconcile security dependencies, estimate basis, delivery capacity, AI acceptance, production SLOs, legal/data controls or technical enforcement of approvals. The overall review rated the plan 6.8/10 and recommended a conditional revision before investment-baseline approval.

## 2. Requested change

Prepare and review Plan V1.1 with the following controlled corrections:

1. Move minimum server-side policy lifecycle, source-to-derivative provenance, ACL/classification inheritance and deletion/revocation behavior onto the MVP path in G2; retain full lifecycle/graph completion in G4.
2. Move essential circuit breaker and policy-approved fallback into G4 before the customer pilot; reserve advanced production tuning and operational maturity for G6.
3. Reallocate the unchanged VND 180m maximum envelope: VND 165m phase-controlled subtotal and VND 15m separate owner-controlled contingency.
4. Replace the 30-week target with 34 planned delivery weeks plus two schedule-reserve weeks (36 weeks total).
5. Add named-role/capacity requirements, effort/rate assumptions, phase cash-flow forecast, procurement rules, stop thresholds and recurring OPEX approval gate.
6. Define a versioned benchmark of at least 120 cases, per-workflow quality thresholds and hard-zero security leakage gates.
7. Define candidate production SLOs, capacity assumptions, RTO/RPO and deletion/revocation objectives.
8. Add ICP selection, SaaS packaging, total COGS/gross-margin measurement and pilot commercial evidence.
9. Add a Vietnam Legal & Data Governance Register using the laws/instruments applicable on the actual processing/release date.
10. Strengthen repository validation for V1.1 documents while preserving the requirement for human Project Owner approval and separate phase authorization.

## 3. Reason and expected benefit

The corrections remove release-blocking dependency gaps, make the budget and calendar auditable, prevent averaged AI metrics from hiding critical failures, expose total cost-to-serve, and create explicit legal/security/data gates before customer data or production release.

## 4. Impact assessment

| Dimension | Proposed impact |
|---|---|
| Product scope | No expansion: AI Office and up to three approved workflows remain the first product |
| Architecture | No architecture replacement; sequence implementation of required V2.2 controls |
| Security | Stronger acceptance; no weakening or waiver of P0 invariants |
| Budget | Maximum remains VND 180m; phase subtotal reallocated to VND 165m; reserve remains VND 15m |
| Schedule | Extends from 30 to 36 weeks including two schedule-reserve weeks |
| Staffing | Requires named Technical Owner and independent QA/security reviewer; Project Owner capacity assumption documented |
| Legal/data | Adds formal register and counsel review before real data and release |
| Commercial | Adds ICP and full COGS/unit economics; no guaranteed sales or revenue |
| Operations | Adds measurable SLO/RTO/RPO and launch capacity envelope |
| Execution authorization | None. G0–G6 remain LOCKED until independently approved |

## 5. Alternatives

- **A — Approve V1.1 as the revised proposed baseline:** preferred only after owner review of the cost assumptions, legal register, capacity and 36-week plan.
- **B — Retain V1.0:** preserves the old proposal but leaves the review findings open; no execution should begin on unresolved blockers.
- **C — Defer:** keep G0–G6 locked while obtaining missing quotes, customer evidence or legal advice.

## 6. Decision record

**Decision:** PENDING  
**Decision maker:** Project Owner  
**Decision date/time (Asia/Ho_Chi_Minh):** PENDING  
**Approved scope/conditions:** PENDING  
**Evidence reference:** PENDING  
**Budget authorization:** NONE  
**Phase authorization:** NONE

A plan-document review or CI pass is not acceptance of this CR. Only the Project Owner may change this decision record. Do not mark this CR APPROVED or update the approval ledger as approved without explicit owner evidence.
