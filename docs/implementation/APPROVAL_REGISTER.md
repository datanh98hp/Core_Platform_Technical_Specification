# Project Approval Register

This is the audit ledger for plan, phase, change and release decisions. Append new entries; do not erase, fabricate or backdate decisions.

## Current baseline status

| Item | Current state | Approval evidence |
|---|---|---|
| CP-V2.2-EXEC-001 plan V1.0 | PROPOSED — awaiting Project Owner review | Initial plan PR; merge/approval pending |
| G0 Discovery | LOCKED — not authorized | None |
| G1 Platform Foundation | LOCKED — not authorized | None |
| G2 Security P0 | LOCKED — not authorized | None |
| G3 AI Office MVP | LOCKED — not authorized | None |
| G4 Control Plane P1 | LOCKED — not authorized | None |
| G5 Customer Pilot | LOCKED — not authorized | None |
| G6 Production Release | LOCKED — not authorized | None |
| Contingency reserve VND 15m | LOCKED — not authorized | None |

## Approval recording rules

An approval entry must state the decision-maker, timestamp in Asia/Ho_Chi_Minh, exact scope, phase/work package or CR ID, approved budget/time limit where relevant, conditions, and a durable reference to the user instruction, GitHub issue comment, approved PR review or merge.

A plan-document PR approval does not authorize phase execution unless it explicitly says so. A phase exit approval does not authorize unrelated work. Silence, vague acknowledgement and an agent-authored status are not approvals.

## Decision log

| Decision ID | Date/time (UTC+7) | Decision maker | Scope / phase / CR | Decision | Conditions / limits | Evidence |
|---|---|---|---|---|---|---|
| — | — | — | — | No phase approvals recorded | G0–G6 remain locked | — |

## Pending proposals

| ID | Description | Status | Decision required |
|---|---|---|---|
| CR-000 | Create and adopt initial phase execution plan and AI agent change-control documents | PROPOSED | Project Owner review of initial documentation PR |
