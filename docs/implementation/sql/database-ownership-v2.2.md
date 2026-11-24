# Database Ownership Rules — V2.2

- A service owns its schema, migration history and runtime database role.
- No service reads/writes another service's tables.
- No cross-service foreign keys. Store UUID references; validate with owner service APIs or domain events.
- Cross-service workflows use gRPC for synchronous validation and NATS JetStream for asynchronous events.
- Use transactional outbox/inbox, idempotent consumers and at-least-once semantics.
- Migration `08-control-plane-v2.2.sql` adds control-plane schemas only. It does not blindly drop V2.1 foreign keys because deployed constraint names and data state must be introspected first.
- Before rollout: inventory FKs, backup, test migration on sanitized clone, produce explicit reviewed `ALTER TABLE ... DROP CONSTRAINT` statements, validate referential integrity at application layer, then deploy.
- Runtime roles receive least-privilege grants only for their owned schema and approved API access.
