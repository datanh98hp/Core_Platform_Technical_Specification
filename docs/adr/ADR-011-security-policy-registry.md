# ADR-011 — Security Policy Registry as Source of Truth

**Status:** Accepted for V2.2

## Decision
Adopt an immutable, versioned Security Policy Registry with review, approval, activation, supersede and revoke lifecycle. Resolve and revalidate policy server-side for AI purposes, provider/model routing, tools, retention, quota and fallback.

## Consequences
- Caller-supplied policy/classification/allow flags cannot authorize protected actions.
- Stale, revoked or unavailable policy denies protected processing.
- Policy decisions include ID/version, reason, expiry and audit reference.
- Changes require human approver and regression tests.
