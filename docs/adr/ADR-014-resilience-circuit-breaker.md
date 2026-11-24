# ADR-014 — Policy-aware Resilience and Circuit Breaker

**Status:** Accepted for V2.2

## Decision
Use explicit deadlines, bounded retries with jitter, idempotency, bulkheads, DLQ and circuit breaker states CLOSED/OPEN/HALF_OPEN. Provider fallback is permitted only after fresh policy validation and only to an approved provider/model with equivalent or stricter controls.

## Consequences
- OPEN circuit fast-fails without provider request.
- Retry applies only to transient, safe-to-retry operations.
- Fallback never converts policy DENY into ALLOW or bypasses quota.
- Circuit transitions and fallback decisions are observable and audited.
