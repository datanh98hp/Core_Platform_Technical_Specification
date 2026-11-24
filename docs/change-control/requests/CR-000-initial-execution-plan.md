# CR-000 — Initial Execution Plan and Agent Change-Control Baseline

**Status:** PROPOSED — awaiting Project Owner review  
**Requested by:** Project Owner through explicit request in the project conversation  
**Date:** 2026-11-24 (Asia/Ho_Chi_Minh)  
**Related plan:** CP-V2.2-EXEC-001 V1.0  
**Related phase:** Documentation baseline only; no phase start is requested or implied  
**Approval evidence:** Pending review of this pull request

## 1. Current baseline

The repository contains Core Platform V2.2 architecture/security specification, implementation backlog, acceptance matrix and tool-neutral AI-agent instructions. It does not yet contain a controlled 30-week phase plan or formal owner approval workflow.

## 2. Requested change

Create:
- one master execution plan for G0–G6, 30 weeks and a VND 180m planning envelope;
- seven phase-specific implementation plans with scope, work packages, prerequisites, deliverables, testable acceptance criteria and GO/NO-GO gates;
- mandatory AI agent execution/change-control policy;
- change-request, phase-gate and task-work-order templates;
- approval and execution registers;
- repository review controls and CI checks that make the documents discoverable and structurally verifiable.

Update the canonical AGENTS.md, docs navigation and Copilot adapter to require these documents.

## 3. Rationale

Keep all coding agents within a single owner-approved delivery baseline. Prevent unrequested scope changes, architecture drift, phase skipping, unapproved spend, relaxation of security acceptance and silent production changes.

## 4. Impact

- Scope: documentation and repository governance only.
- Runtime/application code: no change.
- Database schema: no change.
- Architecture: V2.2 remains authoritative; no architecture deviation proposed.
- Security: strengthens human approval, traceability and CI documentation checks; does not replace runtime controls or GitHub branch protection.
- Budget: no project implementation spend authorized by this CR.
- Timeline: execution schedule is proposed only.
- Release: no deployment or phase implementation authorized.

## 5. Decision requested

Project Owner to review and accept/reject the document baseline PR. Approval of this documentation PR adopts the proposed documents as the controlled plan baseline only. It does **not** authorize G0–G6 to start, approve the VND 180m spend, or approve production deployment. G0 requires separate explicit start authorization.

## 6. Decision record

- Decision: PENDING
- Approver: PENDING
- Decision date: PENDING
- Conditions: PENDING
- Approval evidence: PENDING
