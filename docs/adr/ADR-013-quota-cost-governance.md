# ADR-013 — Reserve usage before execution; reconcile after

**Status:** Accepted for V2.2

## Decision
Use atomic idempotent reservations and immutable usage ledger. Version rate cards and separate estimates from provider-reported actuals. Enforce hard limits and audit overrides.

## Rationale
Prevents uncontrolled spend and duplicate billing.

## Consequences
- Update contracts, tests, runbooks and audit evidence when implementation changes.
- No agent may bypass this ADR; deviations require a superseding ADR approved by a human.
