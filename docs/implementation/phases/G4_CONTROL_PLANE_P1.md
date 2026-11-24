# G4 — Control Plane P1: Policy, Lineage, Quota and Resilience

**Plan version:** 1.1  
**Status:** LOCKED — pending explicit user approval  
**Target window:** Weeks 20–24
**Planning ceiling:** VND 23,000,000
**Gate:** G4 → G5  
**Accountable owner:** Technical Owner with Security/Finance reviewers

## 1. Purpose

Complete the P1 control-plane capabilities required for reliable multi-tenant operation and a controlled commercial pilot. G4 extends—not replaces—the P0 enforcement built in G2.

## 2. Entry conditions

- G3 MVP is accepted and the user explicitly authorizes G4.
- Actual AI Office flows and dependencies are known from G3.
- Policy, lineage, quota and resilience contracts have been reviewed.
- A test environment supports concurrency, retry and provider-failure simulation.
- An independent reviewer is assigned to security-sensitive changes.

## 3. Work packages and backlog mapping

| ID | Work package | Required activities | Backlog mapping |
|---|---|---|---|
| G4-01 | Policy Registry lifecycle | Immutable versions, draft/review/approve/activate/revoke, cache invalidation | BL-010 |
| G4-02 | Policy revalidation | Server-side decision and revalidation before provider egress/tool execution | BL-011 |
| G4-03 | Data Lineage | Source → OCR → normalized artifact → chunk → embedding → context → request/output | BL-012 |
| G4-04 | Inheritance rules | Classification inheritance, ACL intersection and transformation provenance | BL-013 |
| G4-05 | Deletion/revocation | Propagate to storage derivatives, chunks, vectors, indexes, caches and queued jobs | BL-014 |
| G4-06 | Quota reservation | Atomic reservation, idempotent reconciliation and immutable ledger | BL-015 |
| G4-07 | Cost governance | Versioned rate cards, per-tenant/user/module/model budgets and alerts | BL-016 |
| G4-08 | Resilience route | Approved fallback with fresh policy validation and equivalent/stricter controls | BL-017 |
| G4-09 | Acceptance automation | Race, retry, deletion, tenant and fallback tests | BL-018 |

## 4. Mandatory acceptance set

- SEC-018: ACL revoked before RAG context; no chunk returned and cache invalidated.
- SEC-019: source deletion reaches all descendants and queued jobs.
- SEC-020: reservation/reconciliation is atomic and retries do not double-charge.
- SEC-021: provider outage opens circuit; fallback is approved and equivalent-or-stricter.
- SEC-025: tenant usage/cost/circuit data is isolated.
- Re-run relevant P0 tests for regression, especially SEC-011, SEC-015, SEC-017, SEC-022 and SEC-024.

## 5. In scope

- Registry lifecycle and immutable policy versioning.
- Lineage graph metadata and deletion/revocation lifecycle.
- Quota reservation, reconciliation, usage ledger and rate-card versioning.
- Circuit breaker, bounded retry, deadlines, bulkheads and DLQ controls relevant to MVP.
- Tenant-isolated usage and cost dashboards.
- Integration and acceptance automation.

## 6. Out of scope

- Relaxing any P0 rule or changing classification semantics without approved ADR.
- Unrestricted automatic failover to arbitrary providers/models.
- Cross-tenant aggregation that exposes individual tenant data.
- New product modules or a broad connector marketplace.
- Sophisticated forecasting/chargeback beyond current metering requirements.

## 7. Required deliverables

1. Versioned Policy Registry schema, API and lifecycle audit.
2. Lineage schema/API, source-to-derivative graph and deletion-job evidence.
3. Quota reservation/reconciliation implementation and immutable ledger.
4. Rate-card version history and tenant-safe cost reports.
5. Resilience policy, circuit state transitions and approved fallback matrix.
6. Concurrency, retry, outage, deletion and tenant-isolation test reports.
7. Updated dashboards, runbooks and migration/rollback notes.
8. Independent security review and G4 Gate Review.

## 8. Acceptance criteria

- Only approved, active policy versions authorize protected actions; stale/revoked policy is denied.
- Revoked ACL prevents retrieval immediately within the defined consistency objective; cache invalidation is evidenced.
- Deletion propagates to every registered derivative and queued job; incomplete deletion is visible and retried.
- Concurrent reservations cannot exceed hard quota limits due to race conditions.
- Idempotent retries cannot create duplicate usage charges.
- Provider circuit opens/closes according to tested thresholds; fallback re-evaluates policy and never turns DENY into ALLOW.
- Tenant usage/cost data is isolated by server-side authorization.
- No regression of applicable P0 acceptance tests.
- The user explicitly approves G4 exit and G5 start.

## 9. Risks and controls

- **Partial deletion:** make deletion state observable; never report completion while descendants remain.
- **Quota race:** test with concurrent requests against a real transactional database.
- **Unsafe fallback:** default to no fallback until equivalent controls are established.
- **Policy cache staleness:** version cache keys and test activation/revocation invalidation.

## 10. Exit gate

**GO to G5** requires the mandatory P1 acceptance set, P0 regression evidence, security review, operational visibility and explicit user approval.

**NO-GO** for unresolved ACL revocation, incomplete deletion, duplicate billing, tenant cost leakage or unapproved fallback.


## 11. V1.1 amendment — essential resilience must pass before pilot

This amendment clarifies the G2/G4/G6 boundary and overrides any interpretation that defers all circuit-breaker behavior to G6.

### Essential G4 resilience scope
- Circuit breaker state machine for each approved provider route, including open/half-open/closed behavior, thresholds, cooldown and telemetry.
- Bounded retries with exponential backoff and jitter, request deadlines, idempotency and concurrency bulkheads for protected AI/OCR paths.
- DLQ/poison-message visibility and an audited redrive procedure for supported background jobs.
- Fallback only to an explicitly approved provider/model route with equivalent-or-stricter classification, privacy, region, retention, security and quality controls.
- Every fallback re-evaluates current policy and quota. If no approved equivalent route exists, fail closed and surface a controlled error.

### Mandatory gate interpretation
SEC-021 must pass in G4: provider outage opens the circuit; fallback is used only when approved and must not turn DENY into ALLOW. No fallback is a valid safe outcome when the approved route list is empty.

G4 completes the P1 capabilities:
- full Policy Registry immutable version and review/approve/activate/revoke lifecycle;
- full registered lineage graph and derivative deletion/reconciliation;
- ACL revocation and cache invalidation under concurrency;
- atomic quota reservation, immutable usage ledger and idempotent reconciliation;
- versioned rate cards, tenant budgets and cost attribution;
- tenant-isolated usage/cost/circuit telemetry.

### G6 boundary
G6 performs production tuning, scale/soak/chaos tests, operational alert thresholds, runbooks, incident drills and capacity planning. It must not be the first phase in which a provider circuit breaker or approved fallback exists.

### Additional acceptance
- SEC-018 through SEC-025 pass for the implemented scope, including policy revocation, derivative deletion, quota races, provider outage/fallback and tenant telemetry isolation.
- All fallback paths have a documented provider/model policy matrix, data-region/retention review and regression benchmark.
- Failure of Policy, Lineage, Quota or DLP dependency produces deny/stop behavior for protected paths.
- No unresolved P0 regression is accepted.

A green circuit-breaker unit test alone is insufficient; outage simulation must exercise the actual approved route boundary and audit evidence.
