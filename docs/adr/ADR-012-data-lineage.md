# ADR-012 — Data Lineage governs derived data

**Status:** Accepted for V2.2

## Decision
Track source-to-derived graph for OCR, normalized text, chunks, embeddings, retrieval contexts and AI outputs. Derived data inherits highest classification and intersected ACL. Delete/revoke propagates through descendants.

## Rationale
Enables audit, revocation and deletion completeness.

## Consequences
- Update contracts, tests, runbooks and audit evidence when implementation changes.
- No agent may bypass this ADR; deviations require a superseding ADR approved by a human.
