# Database Ownership Rules — V2.2

- A service owns its schema, migrations and runtime database role.
- No service reads or writes another service's tables.
- No cross-service foreign keys. Store UUID references and validate through owner-service APIs/events.
- Cross-service synchronous validation uses gRPC; asynchronous integration uses NATS JetStream.
- Use transactional outbox/inbox and idempotent consumers; delivery is at-least-once.
- Runtime roles receive least-privilege grants to their own schema only.
- Before removing existing V2.1 cross-service FKs: inventory deployed constraints, backup, test on a sanitized clone, create explicit reviewed migration and rollback plan.
- The V2.2 SQL baseline adds control-plane schemas; it does not blindly drop production constraints.
