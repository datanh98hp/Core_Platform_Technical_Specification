# ADR-014 — Resilience is bounded and policy-aware

**Status:** Accepted for V2.2

## Decision
Use deadlines, bounded retries with jitter, idempotency, bulkheads, circuit breaker and DLQ. Fallback is allowed only after a fresh policy decision and only to an equivalent or stricter approved provider/model.

## Rationale
Avoids cascading failure and policy downgrade during outage.

## Consequences
- Update contracts, tests, runbooks and audit evidence when implementation changes.
- No agent may bypass this ADR; deviations require a superseding ADR approved by a human.
