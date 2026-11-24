# G2 — Security Foundation and P0 Release Blockers

**Plan version:** 1.1  
**Status:** LOCKED — pending explicit user approval  
**Target window:** Weeks 6–11
**Planning ceiling:** VND 32,000,000
**Gate:** G2 → G3  
**Accountable owner:** Security Owner / Technical Owner

## 1. Purpose

Implement and independently verify the P0 security controls required before the MVP can process real customer information. Security must be enforced in server-side code, policy and network boundaries—not by agent prompts or UI checks alone.

## 2. Entry conditions

- G1 is accepted and the user explicitly authorizes G2.
- Source, schema, provider routes and data flows have been inventoried.
- Provider test doubles/mocks and a controlled test environment are available.
- An independent reviewer is named for security-sensitive changes.
- Test data is synthetic or approved for the test purpose.

## 3. Work packages and backlog mapping

| ID | Work package | Required activities | Backlog mapping |
|---|---|---|---|
| G2-01 | Baseline inventory | Freeze V2.2 assumptions; inventory code, deployed schema, credentials and provider egress | BL-001 |
| G2-02 | Trusted identity | Establish trusted tenant/actor context; reject caller authority escalation | BL-002 |
| G2-03 | AI Security Harness | Enforce controls for prompts, files, OCR, RAG, embeddings, tools and outputs | BL-003 |
| G2-04 | Provider egress | Only approved AI Gateway workload may reach approved providers | BL-004 |
| G2-05 | Retrieval authorization | Current server-side tenant/resource ACL before RAG context assembly | BL-005 |
| G2-06 | Classification | Block UNKNOWN/C2/C3 from external AI; enforce derivative inheritance | BL-006 |
| G2-07 | Fail-closed behavior | Deny protected operations when policy/AuthZ/DLP/Lineage/Quota controls fail | BL-007 |
| G2-08 | Database isolation | Inventory and safely remove prohibited cross-service FKs/grants using reviewed migrations | BL-008 |
| G2-09 | Security test automation | Automate P0 acceptance tests with provider mock and independent verifier | BL-009 plus SEC matrix |

## 4. Mandatory security acceptance set

At minimum, evidence must cover:

- SEC-001…SEC-017: classification bypass, prompt/file/OCR/RAG leakage, prompt injection, tool permissions, provider egress bypass, fail-closed controls, tenant isolation, telemetry, output scanning, forged authority and stale policy.
- SEC-022: policy/lineage/quota dependency outage fails closed.
- SEC-023: no cross-service FK or direct runtime DB access.
- SEC-024: no sensitive data in telemetry.
- SEC-015 deletion/revocation behavior for implemented source/derivative paths.

The acceptance matrix is authoritative. If it changes, treat the change as controlled scope; do not silently weaken a test or mark an unimplemented test as passed.

## 5. In scope

- Server-enforced authentication/authorization, tenant isolation and classification.
- Mandatory AI Security Harness and AI Gateway enforcement.
- Policy resolution and revalidation for protected MVP paths.
- RAG ACL enforcement and safe output handling.
- Network egress controls, telemetry redaction and negative tests.
- Reviewed database-isolation migration work where required by actual inventory.

## 6. Out of scope

- Live customer rollout before G2 passes.
- Treating a successful prompt-injection demo as security certification.
- Broad compliance certification or unscoped penetration testing.
- Automatic destructive migrations in production.
- Any exception allowing UNKNOWN/C2/C3 to reach external AI without a separate approved legal/security design and superseding ADR.

## 7. Required deliverables

1. Threat model and data-flow diagram covering implemented AI paths.
2. Trusted identity and tenant-isolation implementation evidence.
3. Harness policy and tests for every supported ingress/egress path.
4. Provider egress allowlist/deny evidence.
5. RAG ACL tests and cache-isolation evidence.
6. Classification/lineage inheritance tests for derived artifacts.
7. Database inventory, reviewed migration and rollback plan where applicable.
8. SEC acceptance results, test artefacts and audit evidence.
9. Independent security review report with findings and dispositions.
10. G2 Gate Review.

## 8. Acceptance criteria

- All P0 tests applicable to shipped scope pass with reproducible evidence.
- No C2/C3 or UNKNOWN canary appears in external provider payloads.
- No direct provider egress exists outside the approved AI Gateway path.
- Cross-tenant retrieval and usage disclosure tests show zero unauthorized access.
- Protected operations fail closed when mandatory controls are unavailable.
- No raw prompts, OCR, retrieved chunks, secrets or sensitive payloads appear in logs/traces/metrics.
- Database boundaries comply with V2.2; migrations have backup, sanitized-clone validation and rollback notes.
- Security-sensitive code has independent human review.
- The user explicitly approves G2 exit and G3 start.

A passing test suite proves only the tested scope and does not prove absence of unknown vulnerabilities.

## 9. Stop conditions

Stop the affected AI/data path if a canary leaks, tenant isolation fails, policy can be bypassed, provider egress can be bypassed or sensitive telemetry is observed. Preserve safe evidence, report impact and wait for an authorized remediation decision. Do not hide failure by changing the test or relaxing the policy.

## 10. Exit gate

**GO to G3** only after the mandatory security acceptance set passes, independent review is complete, critical/high findings are fixed or explicitly dispositioned by the authorized owner, and the user grants next-stage approval.

**NO-GO** for any unresolved P0 security blocker.


## 11. V1.1 amendment — P0 Policy, Lineage and Deletion on the MVP path

This amendment is mandatory and overrides any interpretation that defers minimum policy, provenance or deletion behavior to G4.

### Additional work packages
| ID | Work package | Required activities | Backlog mapping |
|---|---|---|---|
| G2-10 | MVP Policy Decision Minimum | Server-side allow/deny decision, immutable policy version reference, deny-by-default, expiry/revoke, current-policy revalidation immediately before provider egress and tool execution | Minimum slice of BL-010/011 |
| G2-11 | MVP Lineage and Derivative Controls | Record source-to-OCR/normalized-file/chunk/embedding/index/context/output provenance for every shipped MVP path; propagate classification at highest level and ACL by strictest intersection | Minimum slice of BL-012/013 |
| G2-12 | MVP Revocation and Deletion | Immediately deny access on revoke/delete; mark descendants unavailable; propagate deletion to all registered MVP derivatives, caches and queued jobs; expose incomplete/retry state | Minimum slice of BL-014 |

G2 does not need the complete enterprise Policy Registry or full generalized lineage graph; it must implement the minimum enforceable controls for the exact MVP paths. G4 completes the lifecycle and scale.

### Additional security acceptance
- SEC-016 forged classification or forged external-AI permission is rejected server-side.
- SEC-017 stale, expired or revoked policy blocks egress/tool execution; cache invalidation is evidenced.
- SEC-015 deletion/revocation is tested end-to-end across every source and derivative type actually used by the MVP.
- An unauthorized/deleted source cannot enter RAG context; a revoked permission is denied at the next protected request.
- Derivative records inherit the highest source classification and the strictest ACL; caller-supplied tags/ACLs cannot lower restrictions.
- If lineage, policy or deletion state cannot be confirmed, the affected operation fails closed.
- No MVP work package is accepted with an unimplemented or mocked-only deletion/revocation control on a path that can process customer data.

### Explicit G2/G4 boundary
G2 delivers a minimum secure vertical slice for the three approved workflows. G4 adds full immutable Policy Registry lifecycle, generalized lineage graph, complete descendant reconciliation and operational dashboards. A G4 backlog label or dependency does not justify postponing a G2 P0 acceptance requirement.

The gate remains NO-GO for unresolved P0 findings.
