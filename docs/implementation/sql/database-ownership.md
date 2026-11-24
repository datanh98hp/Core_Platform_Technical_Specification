# Database ownership

| Schema | Owner | Runtime writer | Cross-service access |
|---|---|---|---|
| identity | identity-service | identity role only | gRPC/events |
| core | core-business-service | core role only | gRPC/events |
| document | document-service | document role only | gRPC/events |
| knowledge | knowledge-service | knowledge role only | gRPC/events |
| ai | ai-engine-service | ai role only | gRPC/events |
| workflow | workflow-service | workflow role only | gRPC/events |
| integration | integration-service | integration role only | gRPC/events |

The starter bootstrap does not create production service roles. Provision one migration role and one least-privilege runtime role per service. Avoid granting every service access to every schema. `platform_shared.outbox_events` and `consumer_inbox` are infrastructure patterns, not cross-service business data stores.
