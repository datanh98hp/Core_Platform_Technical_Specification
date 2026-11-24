# Core Platform Documentation — V2.2 Active Baseline

**Mandatory entrypoint for every AI coding agent, developer and reviewer.** Read this file before any repository task. The repository-wide instruction contract is ../AGENTS.md; tool adapters are provided for Codex, GitHub Copilot, Claude Code and Gemini CLI. Other agents must be configured to load the canonical contract or follow ../AI_AGENT_START_HERE.md manually.

## 1. Document precedence

1. AGENTS.md and this README define repository-wide agent entry requirements.
2. governance/AI_Agent_Coding_Governance_v2.2.md governs agent workflow and completion criteria.
3. governance/AI_AGENT_EXECUTION_CONTROL_V1.md governs phase authorization, task scope and Change Requests.
4. architecture/Core_Platform_Technical_Specification_V2.2.md is the active architecture/security baseline.
5. Accepted ADRs under adr/ are binding decisions.
6. implementation/EXECUTION_PLAN_V2.2.md and the current phase document control scope, stage sequence, budget and acceptance gates.
7. SQL, gRPC, OpenAPI, event contracts, security acceptance matrix, backlog and approved work orders define implementation contracts.

V2.2 supersedes V2.1 wherever they conflict. V1/V2.1 material is historical reference only and must not be treated as the active specification.

## 2. Core Platform V2.2 scope

- Modular multi-tenant Core Platform with API Gateway/BFF and domain services.
- Mandatory AI Security Harness and trusted server-side policy enforcement.
- Security Policy Registry with immutable, approved policy versions.
- Data Lineage for source and derived data, classification/ACL inheritance and deletion propagation.
- Quota & Cost Governance with atomic reservations, usage ledger and reconciliation.
- Resilience with timeouts, bounded retries, idempotency, circuit breaker, bulkheads, DLQ and policy-aware fallback.
- Per-service database ownership; no cross-service foreign keys or direct cross-service database access.

## 3. Mandatory reading and execution order

1. ../AI_AGENT_START_HERE.md when using a tool without automatic instruction discovery.
2. ../AGENTS.md — canonical project instruction contract.
3. governance/AI_Agent_Coding_Governance_v2.2.md.
4. governance/AI_AGENT_EXECUTION_CONTROL_V1.md.
5. architecture/Core_Platform_Technical_Specification_V2.2.md.
6. implementation/EXECUTION_PLAN_V2.2.md.
7. implementation/APPROVAL_REGISTER.md and implementation/EXECUTION_REGISTER.md.
8. The phase-specific plan under implementation/phases/ for the explicitly authorized active phase.
9. Applicable ADRs, security policy, schemas/protos/OpenAPI/event contracts, backlog and acceptance matrix.
10. The approved task/work order and its owner authorization reference.

If a required file, approved phase or work order is missing or inaccessible, stop and report. Do not implement based on assumptions or previous chat context.

## 4. Execution plan and phase gates

The execution plan proposes G0–G6 over 30 weeks with a VND 180m planning envelope. The detailed stage documents are:

- implementation/phases/G0_DISCOVERY_AND_SCOPE.md
- implementation/phases/G1_PLATFORM_FOUNDATION.md
- implementation/phases/G2_SECURITY_P0.md
- implementation/phases/G3_AI_OFFICE_MVP.md
- implementation/phases/G4_CONTROL_PLANE_P1.md
- implementation/phases/G5_CUSTOMER_PILOT.md
- implementation/phases/G6_PRODUCTION_AND_COMMERCIAL_RELEASE.md

At initial publication, all phases are LOCKED / NOT APPROVED. A phase requires explicit Project Owner start approval and a separate exit/next-phase decision. Passing CI or a gate does not automatically start the next phase.

## 5. Change control

Any deviation to requirements, scope, phase order, architecture, API/schema, dependencies, providers, data handling, security/privacy controls, legal assumptions, acceptance criteria, budget, schedule, rollout or release requires either a direct and unambiguous Project Owner instruction or a Change Request with impact analysis and recorded approval.

No approval means no implementation of the deviation. Do not silently change the plan, relax tests, spend contingency, add providers or move to a later phase. Use docs/templates/CHANGE_REQUEST_TEMPLATE.md and record owner decisions in implementation/APPROVAL_REGISTER.md.

## 6. Development and approval templates

- templates/PHASE_TASK_WORK_ORDER_TEMPLATE.md
- templates/PHASE_GATE_REVIEW_TEMPLATE.md
- templates/CHANGE_REQUEST_TEMPLATE.md
- governance/GITHUB_REPOSITORY_PROTECTION_SETUP.md

## 7. Release principle

Security controls must be enforced at runtime and tested with negative, cross-tenant, outage/fail-closed, idempotency and deletion-propagation cases. A prompt instruction or agent self-report is not evidence of enforcement. Security-sensitive changes require independent human review. Agents must branch and open a PR; they must not merge or deploy.
