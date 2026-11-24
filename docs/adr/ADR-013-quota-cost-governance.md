# ADR-013 — Reserve Usage Before Execution and Reconcile After

**Status:** Accepted for V2.2

## Decision
Use atomic, idempotent quota reservations and an immutable usage ledger. Version rate cards; separate estimates from provider-reported actuals; enforce tenant/user/module/model/provider budgets and audited overrides.

## Consequences
- No protected/billable execution bypasses hard limits.
- Retried work cannot double-reserve or double-charge.
- Provider costs and usage are attributable to tenant, feature and request.
- Quota-control outage denies protected/billable work.
