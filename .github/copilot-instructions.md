# GitHub Copilot — Repository Instructions

**Required first step for every task:** read `docs/README.md` in full. Then follow the canonical repository contract in `AGENTS.md`, specifically Governance V2.2, Technical Specification V2.2, relevant accepted ADRs, contracts and the V2.2 backlog. If mandatory files are missing, stop and report the blocker.

V2.2 supersedes V2.1 wherever they conflict. Preserve service-owned database boundaries; do not create cross-service foreign keys or direct cross-service DB access. Never bypass trusted tenant authorization, AI Security Harness, Security Policy Registry, classification, Data Lineage, quota controls, approval requirements or provider-egress restrictions. Unknown/C2/C3 content must not reach external AI. Derived data inherits restrictive classification/ACL. Protected operations fail closed when mandatory controls are unavailable. Retries are bounded/idempotent; fallback requires fresh policy validation. Do not log sensitive prompts, OCR, RAG chunks or secrets.

Before completion, run relevant tests and report actual commands/results, migration/rollback notes and known gaps. Security-sensitive changes require independent human review.