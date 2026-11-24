# AI Agent Execution Control & Change Governance V1.0

**Status:** Mandatory repository policy  
**Applies to:** Codex, GitHub Copilot, Claude, Gemini and all other coding agents, contractors and contributors  
**Owner:** Project Owner / Founder  
**Effective baseline:** Only after this policy is approved and merged to main

## 1. Non-negotiable rule

An AI coding agent may implement only work that is:
1. inside the currently approved active phase;
2. explicitly identified in an approved work order/issue or an unambiguous direct instruction from the Project Owner;
3. consistent with V2.2 architecture/security, accepted ADRs, the approved execution plan and phase document; and
4. within approved budget, timeline, dependencies and acceptance criteria.

The agent must not independently decide to change scope, requirements, architecture, technology, provider, data handling, security posture, release order, costs, target date or success criteria.

**No approval means no implementation.** Analysis and read-only inspection may continue to clarify a blocker; coding, migrations, external commitments, production changes and deployment must stop.

## 2. Required reading before every task

Read in full:
1. docs/README.md
2. root AGENTS.md
3. docs/governance/AI_Agent_Coding_Governance_v2.2.md
4. docs/governance/AI_AGENT_EXECUTION_CONTROL_V1.md
5. docs/implementation/EXECUTION_PLAN_V2.2.md
6. the active phase document under docs/implementation/phases/
7. applicable ADRs, technical specification, contracts, security policy, backlog and acceptance matrix
8. the approved work order/issue and relevant approval-register entries

If a document is missing, conflicting, stale or inaccessible, stop and report it. Do not use earlier chat memory or an old working copy as authority over the repository.

## 3. Authorization model

### 3.1 Who may authorize
Only the Project Owner, or a delegate whose authority and scope have been explicitly recorded by the Project Owner, may approve:
- starting or closing a phase;
- changing a planned requirement or acceptance criterion;
- changing scope, budget, schedule, architecture, technology or provider;
- changing data classifications, privacy/security controls or customer-data routes;
- adding a product/module, connector, dependency or supplier;
- accepting material residual risk;
- production release, deployment, rollback or emergency action.

An AI agent cannot approve, a contractor cannot self-approve, and one agent cannot approve another agent's work on behalf of the owner.

### 3.2 What counts as explicit approval
Acceptable evidence:
- a clear written instruction from the Project Owner that names the phase or change and the action authorized; or
- an approved GitHub review/merge or issue decision by the Project Owner on the exact proposal; or
- a written approval from a delegate whose authority is already recorded.

For auditability, record the approver, timestamp, scope, approval evidence reference, budget ceiling (if relevant), phase and limitations in APPROVAL_REGISTER.md.

Not approval:
- silence, lack of objection, a prior approval for another phase, a vague “OK”, “looks good” or “I trust the plan”;
- an agent-generated summary or self-marked status;
- CI passing, a PR being opened, a task being completed or a budget estimate;
- approval of a plan document being misread as authorization to start all phases.

A clear user instruction that directly requests a specific change is authorization for that specifically described change only. The agent must record it and must not extend it to adjacent scope. If the instruction is ambiguous, ask one clarification before acting.

## 4. Phase lifecycle — no automatic progression

Use these states:
- LOCKED: baseline exists, no work authorized.
- PROPOSED: awaiting owner review.
- APPROVED_TO_START: owner explicitly authorized this named phase.
- IN_PROGRESS: only approved work packages may be implemented.
- BLOCKED: a prerequisite, approval, legal, security or test condition is unmet.
- READY_FOR_GATE: evidence pack submitted; no next phase authorized yet.
- ACCEPTED: owner accepted the exit gate.
- CHANGE_PENDING: a Change Request has been submitted; affected work is paused.
- STOPPED: owner stopped or superseded the phase.

Only the Project Owner can move a phase into APPROVED_TO_START or ACCEPTED. The agent may recommend a state, never self-assign owner approval.

**Passing a gate does not start the next phase.** The agent must present the gate report, wait for an explicit GO, record it, then proceed.

## 5. Change control

A Change Request (CR) is mandatory when any proposed action changes or may materially affect:
- user-visible behavior or a requirement outside the approved work order;
- product/module boundary, workflow count, customer segment or supported data/file type;
- architecture, service boundary, database schema ownership, API/proto/event contract or migration strategy;
- framework, language, infrastructure, model provider, model, region, connector or external dependency;
- security, privacy, data classification, retention, ACL, provider egress, human approval or legal/compliance assumptions;
- acceptance criteria, tests, KPI definition, SLO, release gate or risk tolerance;
- budget ceiling, spend commitment, milestone, duration, staffing or supplier;
- release/rollout, production access, data import/export or destructive operation.

### 5.1 Agent procedure
1. Stop before implementing the variance. Do not make a “small improvement” that changes the baseline.
2. Create a CR using docs/templates/CHANGE_REQUEST_TEMPLATE.md.
3. Describe current baseline, requested/proposed change, reason, options, impact on scope/cost/time/security/privacy/operations, dependencies, migration/rollback and affected documents.
4. Classify risk and identify the exact work that must remain paused.
5. Submit the CR for owner decision and reference it in the PR/issue.
6. Wait. No implementation of the proposed variance until approval is recorded.
7. After approval, update the relevant plan/phase/ADR/backlog in a separate reviewed change and link the decision.
8. Implement only the approved change; test and report it. Close the CR with evidence.

If the Project Owner directly requests a specific change, treat that instruction as approval only for the described change. Record it as an owner-directed CR and still follow architectural/security ADR and independent-review requirements.

### 5.2 Decision options
- APPROVE: exact change and conditions accepted.
- APPROVE WITH CONDITIONS: implement only after listed conditions are met.
- REJECT: preserve the current baseline.
- DEFER: keep affected work paused.
- REQUEST MORE INFORMATION: perform only the requested analysis.

No response means the CR remains pending.

## 6. Task execution protocol

Before coding, produce a concise task plan stating:
- active phase and work-package ID;
- approval evidence;
- files/services/data paths affected;
- exact expected changes and acceptance criteria;
- tests and security implications;
- migrations, rollback and operational implications;
- out-of-scope items that will not be touched.

Then:
1. Create a branch; never work directly on main.
2. Keep each PR limited to one approved work order where practical.
3. Do not silently alter adjacent modules or “clean up” unrelated code.
4. Do not add dependencies/services/providers without approval.
5. Implement tests and update documentation with the change.
6. Run the relevant checks and report actual output, including failed or skipped tests.
7. Open a PR with phase, work-package ID, authorization reference, change-request ID (if any), impact, test evidence and rollback notes.
8. Request Project Owner review. Do not merge or deploy.

If the user asks for work outside the currently approved phase, treat it as a new authorization/change request; do not quietly start the later phase.

## 7. Security and production stop rules

Immediately stop the affected path and report when:
- a cross-tenant access or protected-data disclosure is observed;
- C2/C3/UNKNOWN data may reach an external AI provider;
- provider egress can bypass the approved AI Gateway;
- policy/authz/DLP/lineage/quota controls fail open;
- deletion/revocation is incomplete in a way that exposes data;
- secrets or sensitive payloads appear in telemetry or source control;
- a destructive migration has no backup, sanitized-clone validation, approval and rollback plan.

Do not disable a test, weaken a security rule, suppress a finding or use production data to make progress. Any containment action must follow a pre-approved incident runbook or receive explicit owner authorization.

## 8. Pull request, review and merge rules

- All work uses a branch and pull request.
- The PR must identify the approved phase/work item and owner authorization reference.
- All applicable CI checks must pass.
- Changes to plan, governance, architecture, ADR, security or acceptance baseline require a CR document.
- CODEOWNERS names the Project Owner. Repository settings must require a pull request, at least one approving review, Code Owner approval, required CI checks and no bypass for protected branches.
- The implementing agent must not approve its own PR, dismiss review requirements, merge to main or deploy.
- Security/architecture changes require independent human review in addition to owner approval where the reviewers are different roles.

Repository documentation and CI can detect missing records; they cannot force every external agent host to obey instructions. GitHub branch protection/rulesets and Code Owner review must be enabled by a repository administrator for merge enforcement.

## 9. Required final report

Every completed task reports:
- phase, work-package and authorization reference;
- files changed and reason;
- scope confirmation and any CR;
- commands actually run and results;
- security/privacy and tenant-isolation evidence;
- migration/rollback/deployment notes;
- known gaps, residual risks and skipped tests;
- recommended next decision (not automatic progression).

Never claim completion, safety, legal compliance or test success without evidence.

## 10. Audit and recordkeeping

- APPROVAL_REGISTER.md is the approval ledger; append decisions, never fabricate or backdate them.
- EXECUTION_REGISTER.md records phase/work-package status, owner and evidence.
- Each CR is immutable once decided; corrections are new records with links.
- Approved plan changes are versioned through pull requests; preserve prior baseline history.
- Do not place credentials, personal data, customer payloads or confidential content in approval records.

## 11. Initial state

At policy publication:
- Plan CP-V2.2-EXEC-001 is proposed pending owner review.
- G0–G6 are LOCKED / NOT STARTED / NOT APPROVED.
- No implementation phase is authorized.
- The first required decision is owner approval of the execution baseline, followed by a separate G0 start authorization.
