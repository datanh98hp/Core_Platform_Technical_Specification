# Project Approval Register

This is the audit ledger for plan, phase, change and release decisions. Append new entries; do not erase, fabricate or backdate decisions.

## Current baseline status

| Item | Current state | Approval evidence |
|---|---|---|
| CP-V2.2-EXEC-001 plan V1.0 | Historical proposal; superseded by V1.1 proposal for review only | Prior PR history; no phase authority |
| CP-V2.2-EXEC-001 plan V1.1 | PROPOSED — awaiting Project Owner decision | CR-001 / review PR; no acceptance recorded |
| CR-001 | PROPOSED — awaiting Project Owner decision | None |
| G0 Discovery | LOCKED — not authorized | None |
| G1 Platform Foundation | LOCKED — not authorized | None |
| G2 Security P0 | LOCKED — not authorized | None |
| G3 AI Office MVP | LOCKED — not authorized | None |
| G4 Control Plane P1 | LOCKED — not authorized | None |
| G5 Customer Pilot | LOCKED — not authorized | None |
| G6 Production Release | LOCKED — not authorized | None |
| Contingency reserve VND 15m | LOCKED — not authorized | None |
| Production deployment | NOT AUTHORIZED | None |

## Approval recording rules

Only the Project Owner, or a delegate whose authority is explicitly recorded by the Project Owner, may approve a phase, Change Request, budget, release or material risk.

An approval entry must state the decision-maker, timestamp in Asia/Ho_Chi_Minh, exact scope, phase/work package or CR ID, approved budget/time limit where relevant, conditions, and a durable reference to the user instruction, GitHub issue comment, approved PR review or merge.

A plan-document PR approval does not authorize phase execution unless it explicitly says so. A phase exit approval does not authorize unrelated work. Silence, vague acknowledgement and an agent-authored status are not approvals.

## Decision log

| Decision ID | Date/time (UTC+7) | Decision maker | Scope / phase / CR | Decision | Conditions / limits | Evidence |
|---|---|---|---|---|---|---|
| — | — | — | — | No plan V1.1, CR-001, phase or production approval recorded | G0–G6 and contingency remain locked | — |

## Pending proposals

| ID | Description | Status | Decision required |
|---|---|---|---|
| CR-000 | Create initial phase execution plan and AI agent change-control documents | Historical proposal | Retain audit history |
| CR-001 | Correct cross-phase security sequencing, investment model, schedule, AI quality, SLO, legal and commercial gates | PROPOSED | Project Owner decision on exact V1.1 baseline |

## Repository controls still requiring administrator verification

- Require pull requests to merge into main.
- Require at least one approving review and Code Owner approval.
- Require both plan-governance and AI-agent-instructions status checks.
- Dismiss stale approvals after new commits and require conversation resolution.
- Block force-push and branch deletion; restrict bypass to a documented emergency path.
- Protect production GitHub Environments with required reviewers and scoped secrets.
- Verify the settings in GitHub itself; a CODEOWNERS file or green workflow does not prove branch protection is enabled.
