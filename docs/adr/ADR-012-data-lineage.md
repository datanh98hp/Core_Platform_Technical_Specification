# ADR-012 — Data Lineage Governs Derived Data

**Status:** Accepted for V2.2

## Decision
Maintain a source-to-derived lineage graph for document, OCR, normalized text, chunk, embedding, RAG context, AI request and output. Derived data inherits the highest parent classification and intersection of parent ACLs. Deletion/revocation propagates through all descendants and processing queues.

## Consequences
- No transformation may lower classification or widen ACL.
- Current ACL is checked server-side before retrieval.
- Delete/revoke completion is auditable; failures are retried and surfaced.
- Raw content is not stored in lineage metadata.
