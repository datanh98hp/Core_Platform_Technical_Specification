# AI Quality and Service SLO Baseline V1.1

**Plan:** CP-V2.2-EXEC-001 / V1.1  
**Status:** PROPOSED — thresholds require approval before benchmark execution  
**Applies to:** AI Office G3, G5 and G6

## 1. Benchmark design

Create a versioned, reproducible benchmark with at least 120 cases. Each of the three approved MVP workflows must have at least 40 cases. The set must include Vietnamese-language inputs and representative file types from the approved MVP scope.

Minimum coverage:

| Case family | Minimum share | Required examples |
|---|---:|---|
| Normal representative work | 35% | Correct, readable source documents and ordinary user questions |
| OCR / noisy / structured content | 20% | Scanned pages, low-quality OCR, tables, mixed layouts, Vietnamese diacritics |
| Missing, contradictory or stale evidence | 15% | No supporting source, conflicting versions, outdated policy |
| Unanswerable / abstention | 10% | Questions outside the authorized knowledge base or unsupported by evidence |
| Prompt injection / poisoned content | 10% | Instructions embedded in files or retrieved content; attempted tool escalation |
| ACL / tenant / revocation negatives | 10% | Unauthorized document, cross-tenant request, revoked permission or deleted source |

Every case records workflow, language, file type, classification, ACL condition, expected sources, expected output/abstention, severity and dataset version. Use synthetic or properly anonymized data unless separately approved for a documented test purpose.

## 2. Minimum quality gates

| Metric | Initial target | Measurement rule |
|---|---:|---|
| Retrieval Recall@5 | ≥90% | Gold supporting source is among top five authorized retrieved sources |
| Citation correctness | ≥95% | Citation resolves to the right source and supporting passage |
| Grounded and useful answer rate | ≥90% | Human rubric says the answer is relevant and supported |
| Factual correctness | ≥92% | Claims match the approved evidence set |
| Abstention precision | ≥95% | No-evidence/unauthorized cases correctly refused or escalated |
| Unsupported material-claim rate | ≤3% | Material unsupported claims / evaluated material claims |
| Critical security/safety error | 0 | Any critical event is a hard fail, not averaged |
| Unauthorized context or cross-tenant disclosure | 0 | No unauthorized chunk, source or payload enters context or output |
| C2/C3/UNKNOWN external-provider payload | 0 | Canary and policy tests confirm blocked egress |

Report results by workflow, document class, case family and model/provider. The overall average cannot hide a failing workflow or any critical leakage/error. A target is not passed until the dataset, code, model/version, provider route, temperature/configuration, evaluation rubric, sample size and reviewer are recorded.

## 3. Model and retrieval controls

- Pin provider, model version, prompt/template, retrieval settings and policy version for each benchmark run.
- Evaluate citations against source passage and document version, not just presence of a URL or file name.
- Keep retrieval, generation and end-to-end metrics separate.
- Re-run the affected benchmark slice and regression suite after model/provider/prompt/embedding/chunking changes.
- Measure refusal/abstention for missing evidence, conflicting content, revoked ACL and disallowed classification.
- Do not train or fine-tune on customer content without separate documented rights, lawful basis, contract and approval.

## 4. Initial service-level objectives

These are proposed first-production objectives for the defined launch workload, not guarantees for unlimited scale.

| SLI / SLO | Initial objective | Measurement conditions |
|---|---:|---|
| Customer-facing service availability | ≥99.5% per calendar month | Production monitoring; publish exclusions and measurement method |
| Non-AI API latency | P95 ≤800ms | Excludes external model/OCR provider processing; fixed load profile |
| Standard AI Assistant end-to-end response | P95 ≤20 seconds | Normal supported request and bounded knowledge corpus; include provider time |
| Queue start delay | 95% of eligible jobs start within 2 minutes | Under approved concurrency and queue workload |
| Standard OCR/ingestion completion | 95% within 5 minutes | Only files within the approved size/page/type limits |
| Recovery Point Objective | ≤24 hours | Production backup and data recovery test |
| Recovery Time Objective | ≤8 hours | Timed restoration drill for launch topology |
| ACL revocation | Deny at the next protected request | Authorization must use current server-side policy |
| Derived cache invalidation | Objective ≤60 seconds | Until invalidated, protected reads fail closed |
| Approved MVP-path deletion | Complete within 24 hours | Includes registered derivatives; unavailable provider erasure must remain disclosed and tracked |

If G5 measurements show that an objective is infeasible or commercially unnecessary, submit a CR with customer impact, risk and alternative. Never loosen a security invariant such as tenant isolation, classification or deny-on-revocation to meet a latency target.

## 5. Capacity envelope for initial pilot and release test

The starting load-test profile is 5 pilot tenants, up to 50 named users and 10 concurrent interactive users, plus the approved background-job mix. These are test assumptions, not a promise of capacity. G5 must collect actual peak usage and G6 must load/soak test at a minimum of 2× observed pilot peak or a separately approved launch forecast, whichever is higher.

## 6. Unit economics measurement

Calculate COGS per tenant and per workflow, including provider/model, OCR, embedding, infrastructure, storage, egress, connectors, human review, onboarding and support. Direct AI provider spend / recurring revenue target is ≤20%. The overall standard recurring gross-margin target is ≥55% after all variable delivery COGS. Report onboarding/service revenue and margin separately from recurring SaaS revenue.

## 7. Evidence and failure handling

Retain benchmark dataset version/hash, anonymization status, evaluation harness version, model/provider configuration, raw aggregate measurements, adjudication notes and reviewer. Redact customer content and personal data from general telemetry. A critical leakage or authorization failure blocks the affected path and the gate until remediated and independently re-tested.
