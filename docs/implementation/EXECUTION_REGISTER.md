# Execution Register

This register is the single status view for project phases and approved work packages. Update it only from recorded owner decisions and reproducible evidence.

## Project status

- Plan: CP-V2.2-EXEC-001 V1.1
- Overall state: PROPOSED — awaiting Project Owner approval
- Change Request: CR-001 — PROPOSED
- Active phase: NONE
- Current approved work order: NONE
- Current release environment: none authorized
- Budget committed/spent: VND 0 recorded; not yet authorized
- Phase budget subtotal: VND 165,000,000 proposed; not authorized
- Contingency: VND 15,000,000 locked
- Maximum proposed envelope: VND 180,000,000
- Delivery horizon: 36 weeks proposed (34 delivery + 2 schedule reserve)

## Phase status

| Phase | State | Planned window | Planning ceiling | Start approval | Exit decision |
|---|---|---:|---:|---|---|
| G0 Discovery | LOCKED | Weeks 1–2 | VND 8m | None | Not reviewed |
| G1 Foundation | LOCKED | Weeks 3–5 | VND 18m | None | Not reviewed |
| G2 Security P0 | LOCKED | Weeks 6–11 | VND 32m | None | Not reviewed |
| G3 AI Office MVP | LOCKED | Weeks 12–19 | VND 42m | None | Not reviewed |
| G4 Control Plane P1 | LOCKED | Weeks 20–24 | VND 23m | None | Not reviewed |
| G5 Customer Pilot | LOCKED | Weeks 25–30 | VND 22m | None | Not reviewed |
| G6 Production Readiness | LOCKED | Weeks 31–34 | VND 20m | None | Not reviewed |
| Schedule reserve | LOCKED | Weeks 35–36 | No automatic spend | None | Not reviewed |
| Contingency | LOCKED | Owner-controlled | VND 15m | None | Not reviewed |

## Work-order register

| Work Order | Phase / package | Owner | Status | PR / issue | Evidence | CR |
|---|---|---|---|---|---|---|
| None | No work order approved | — | — | — | — | — |

## Planning artifacts

| Artifact | State | Purpose |
|---|---|---|
| PHASE_EXECUTION_PLAYBOOK_V1.1.md | DRAFT / not authorized | Detailed work-package sequence for G0–G6 |
| PHASE_TASK_WORK_ORDER_TEMPLATE.md | TEMPLATE | Convert each approved package into a bounded work order |
| PHASE_GATE_REVIEW_TEMPLATE.md | TEMPLATE | Record test evidence, cost, risks and owner gate decision |

## Rules

- Only the Project Owner may authorize a phase start or phase acceptance.
- A phase cannot enter IN_PROGRESS until the start approval is present in APPROVAL_REGISTER.md.
- Each implementation task must have an approved work order or an exact owner instruction.
- The playbook's Work Package IDs are planning identifiers, not authorizations.
- Status must not be advanced based on an agent's assertion alone.
- At the end of a task, link actual test output, review evidence and PR.
- The next phase remains LOCKED until a separate owner GO decision is recorded.
