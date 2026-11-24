# AI Data Protection and Security Harness Policy V2.2

## 1. Data classification
- **C0 Public:** may use approved AI under policy.
- **C1 Internal:** allowed only with explicit tenant policy and approved provider.
- **C2 Confidential:** prohibited from external AI.
- **C3 Restricted:** prohibited from external AI; excluded from AI by default.
- **UNKNOWN:** blocked until classified.

Classification is assigned by trusted server-side ingestion rules or authorized reviewer. Caller metadata is not authority. Transformations cannot lower classification.

## 2. Mandatory AI Security Harness
Every AI path must pass through the approved AI Gateway and Security Harness: prompts, attachments, OCR text, RAG chunks, embeddings/reranking, tool arguments and model outputs. Harness is policy enforcement, not a system-prompt instruction. Policy/AuthZ/DLP dependency failure is fail-closed.

Only the approved AI Gateway workload may connect to approved provider endpoints. Domain services, workers, cron jobs, browser clients and agent runtimes must not have direct provider egress. Test egress restrictions for IPv4/IPv6, proxies, DNS and worker paths.

Do not send C2/C3 to external model providers. Unknown classification is deny. Do not store raw prompts, OCR, retrieved chunks, secrets or sensitive outputs in logs/traces/metrics.

## 3. Security Policy Registry
Policy bundles are immutable, versioned, reviewed and approved. Lifecycle: DRAFT → REVIEW → APPROVED → ACTIVE → SUPERSEDED/REVOKED. Policy covers classification, purposes, provider/model/region allowlists, retention, tool permissions, approval, quota and fallback profiles.

Resolve and revalidate policies server-side immediately before provider egress and tool execution. Client policy IDs, classification labels, role flags and `external_ai_allowed` cannot authorize. Expired/revoked/stale/invalid/unavailable policy means DENY on protected paths. Cache keys include tenant/scope/version and policy activation invalidates caches.

## 4. Data Lineage
Track source → extraction/OCR → normalized content → chunks → embeddings → retrieval context → AI request → output. Store lineage metadata, fingerprints, processing versions, classification, ACL/policy version, retention and deletion status; do not store raw content in lineage tables.

Derived assets inherit the highest parent classification and intersection of parent ACLs. Revoke/delete must propagate to objects, chunks, vectors, indexes, caches and queued work. Incomplete deletion is auditable and retried. RAG authorization is server-side against current resource ACL; caller-provided resource lists are not permission grants.

## 5. Quota and cost governance
Reserve quota atomically before execution; reconcile actual usage after execution. Use idempotency keys, immutable usage ledger, versioned rate cards and tenant-isolated cost reports. Separate estimated usage from provider-reported actual usage. Hard limits cannot be silently bypassed. Overrides require reason, expiry and audit record. Quota-control outage denies protected/billable execution.

## 6. Resilience
All outbound calls use deadlines, bounded retries with jitter and idempotency. Circuit breaker states are CLOSED/OPEN/HALF_OPEN. Fallback requires fresh policy validation and an approved provider/model with equivalent or stricter data protections, region, retention and training-use constraints. A fallback cannot override policy DENY or quota denial. Use bulkheads and DLQ with audited redrive.

## 7. Acceptance suite
Retain SEC-001…SEC-015 and run SEC-016…SEC-025 as defined in `implementation/backlog/acceptance-matrix.csv`. New cases cover forged classification, stale/revoked policy, RAG ACL revoke, lineage deletion, double charging, provider outage/fallback, fail-closed control-plane outage, DB ownership, telemetry leakage and tenant cost isolation.

## 8. Release gates
- Zero C2/C3 canaries in external provider payload.
- Zero provider egress bypass.
- Zero cross-tenant retrieval or governance-data disclosure.
- 100% protected actions fail closed when mandatory policy/AuthZ/lineage/quota dependencies are unavailable.
- Zero raw sensitive payload in telemetry.
- 100% acceptance tests have reproducible evidence and independent review.

These gates apply to tested scope and do not prove absence of unknown vulnerabilities.
