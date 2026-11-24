# ADR-011 — Security Policy Registry is authoritative

**Status:** Accepted for V2.2

## Decision
Adopt immutable, versioned policy bundles with review/approval/activation lifecycle. All protected AI, tool, quota and provider decisions resolve policy server-side. Unknown, stale or unavailable policy denies protected action.

## Rationale
Prevents policy drift and caller-controlled permissions.

## Consequences
- Update contracts, tests, runbooks and audit evidence when implementation changes.
- No agent may bypass this ADR; deviations require a superseding ADR approved by a human.
