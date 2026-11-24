# Execution Register

This register is the single status view for project phases and approved work packages. Update it only from recorded owner decisions and reproducible evidence.

## Project status

- Plan: CP-V2.2-EXEC-001 V1.0
- Overall state: PROPOSED — awaiting owner approval
- Active phase: NONE
- Current approved work order: NONE
- Current release environment: none authorized
- Budget committed/spent: not yet recorded
- Contingency: VND 15,000,000 locked

## Phase status

| Phase | State | Planned window | Planning ceiling | Start approval | Exit decision |
|---|---|---:|---:|---|---|
| G0 Discovery | LOCKED | Weeks 1–2 | VND 8m | None | Not reviewed |
| G1 Foundation | LOCKED | Weeks 3–5 | VND 20m | None | Not reviewed |
| G2 Security P0 | LOCKED | Weeks 6–10 | VND 30m | None | Not reviewed |
| G3 AI Office MVP | LOCKED | Weeks 11–17 | VND 45m | None | Not reviewed |
| G4 Control Plane P1 | LOCKED | Weeks 18–21 | VND 18m | None | Not reviewed |
| G5 Customer Pilot | LOCKED | Weeks 22–26 | VND 24m | None | Not reviewed |
| G6 Production Release | LOCKED | Weeks 27–30 | VND 20m | None | Not reviewed |

## Work-order register

| Work Order | Phase / package | Owner | Status | PR / issue | Evidence | CR |
|---|---|---|---|---|---|---|
| None | No work order approved | — | — | — | — | — |

## Rules

- Only the Project Owner may authorize a phase start or phase acceptance.
- A phase cannot enter IN_PROGRESS until the start approval is present in APPROVAL_REGISTER.md.
- Each implementation task must have an approved work order or an exact owner instruction.
- Status must not be advanced based on an agent's assertion alone.
- At the end of a task, link actual test output, review evidence and PR.
- The next phase remains LOCKED until a separate owner GO decision is recorded.
