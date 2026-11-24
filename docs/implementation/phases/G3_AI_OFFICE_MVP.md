# G3 — AI Ops Desk / AI Office MVP

**Plan version:** 1.0  
**Status:** LOCKED — pending explicit user approval  
**Target window:** Weeks 11–17  
**Planning ceiling:** VND 45,000,000  
**Gate:** G3 → G4  
**Accountable owner:** Product Owner

## 1. Purpose

Deliver the first usable product on Core Platform V2.2. The MVP combines AI Document, AI Knowledge, AI Assistant and simple Workflow capabilities. It is not a general-purpose ERP or autonomous office agent.

## 2. Entry conditions

- G2 P0 security gate is accepted; user explicitly authorizes G3.
- AI Office PRD V1 and no more than three MVP workflows are approved.
- Data sources and processing purposes are approved for development/test.
- AI provider/model routes are approved in policy and quota configuration.
- Benchmark dataset and evaluation rubric are approved.

Do not ingest real customer confidential or personal data unless legal, security and contractual approvals are documented.

## 3. MVP work packages

| ID | Work package | Required functionality | Deliverable |
|---|---|---|---|
| G3-01 | Tenant/admin UX | Workspace, users, roles, admin settings and audit views | Admin console |
| G3-02 | Document module | Upload, version, metadata, supported file types, OCR orchestration and status | Document workspace |
| G3-03 | Knowledge module | Knowledge base, ingestion, chunking, embedding, indexing and permission-aware retrieval | Knowledge base |
| G3-04 | AI Assistant | Grounded Q&A, summaries, extraction and source citations; state when evidence is insufficient | Assistant experience |
| G3-05 | Workflow module | 3 approved workflows, task assignment, approval state and history | Workflow screens/API |
| G3-06 | Usage/cost visibility | Basic per-tenant and per-feature usage reporting | Usage dashboard |
| G3-07 | Evaluation | Golden dataset, retrieval checks, answer rubric and regression tests | Evaluation report |
| G3-08 | Product readiness | Error handling, help text, onboarding and feedback capture | MVP release candidate |

## 4. Candidate MVP workflows

The final set must be selected in G0 PRD; these are candidates, not automatic authorization:

1. Document intake → extract/classify → human verification → store.
2. Internal-policy/document Q&A → retrieve authorized sources → answer with citations.
3. Internal request intake → classify → assign → approve/complete.
4. Report summarization → human review → export.

No workflow may execute an external high-impact action without explicit human approval and audit trail.

## 5. In scope

- Only approved document formats, languages, sources and workflows.
- Tenant-aware document storage, knowledge ingestion and retrieval.
- Grounded assistant actions using approved tools and policy.
- Basic workflow, audit trail and usage visibility.
- Controlled staging/demo environment with synthetic or approved data.

## 6. Out of scope

- CRM, ERP, Finance, Marketing Automation, Inventory or Production modules.
- Autonomous external emails, payments, legal/HR decisions or irreversible actions.
- Unrestricted web browsing or arbitrary connectors.
- Fine-tuning on customer data.
- Multi-provider fallback before G4 policy/resilience acceptance.
- Unapproved custom features for a single prospect.

## 7. Quality and performance evaluation

Create a versioned benchmark of approximately 100 representative questions and expected supporting sources. The initial proposed target is at least 90% of evaluated answers judged sufficiently grounded and useful under the agreed rubric. Track retrieval correctness, citation validity, unsupported claims, refusal quality, latency and cost separately.

For high-impact or policy-sensitive questions, unsupported answers must be refused or escalated; an aggregate score cannot hide critical errors. Performance thresholds must be measured on a stated environment, workload and dataset. Do not claim a target has passed without a benchmark report.

## 8. Required deliverables

1. Working MVP and API/UI documentation.
2. Supported file-type and workflow matrix.
3. Versioned prompt/model/configuration records with policy references.
4. Golden dataset and evaluation script/report.
5. Functional, integration, tenant-isolation and regression test results.
6. Known-issues register and user feedback mechanism.
7. Deploy/rollback instructions for the release candidate.
8. G3 Gate Review.

## 9. Acceptance criteria

- Three approved MVP workflows run end-to-end in staging.
- Every retrieved source is authorized server-side and citations resolve to the correct source.
- Unauthorized documents never enter model context.
- The benchmark meets the approved threshold; unsupported/critical errors are separately reported and assigned.
- Users can see task status, failures, approval history and basic usage/cost.
- Billable operations are traceable and protected against duplicate retries as applicable.
- Usability tests with representative users are recorded.
- No P0 security regression is introduced; relevant acceptance tests pass again.
- The user explicitly accepts G3 and authorizes G4.

## 10. Exit gate

**GO to G4** requires an MVP release candidate, accepted workflow results, benchmark evidence, regression/security results, known gaps and explicit user approval.

**NO-GO** if MVP depends on an unapproved data path, fails tenant ACL, lacks auditability for approvals or cannot demonstrate grounded answers on the agreed benchmark.
