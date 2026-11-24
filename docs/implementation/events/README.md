# NATS event rules
- Subject format: `<domain>.v<major>.<event>`; e.g. `document.v1.uploaded`.
- JetStream durable consumers use at-least-once delivery. Deduplicate by eventId.
- Producer writes business state + outbox row in one DB transaction.
- Relay publishes outbox; consumer records inbox and business effects in one transaction; ACK after commit.
- Retry bounded exponential backoff with jitter; after max deliveries route to parking/DLQ stream and alert.
- Events contain references and metadata only; no raw documents, credentials, access tokens or unnecessary PII.
- Additive optional fields are compatible; semantic/breaking changes require a new major subject/schema.
