# GitHub Copilot Repository Instructions

**First action for every task:** read `docs/README.md`. Next read `AGENTS.md`, `docs/governance/AI_Agent_Coding_Governance_v2.2.md`, the V2.2 technical specification, applicable ADRs and the V2.2 implementation backlog.

V2.2 is authoritative and supersedes conflicting V2.1 material. Never trust caller-supplied tenant, classification, permission, ACL or policy decisions. Never bypass AI Security Harness, Policy Registry, Data Lineage, quota reservation, server-side RAG authorization, human approvals or provider egress restrictions. No cross-service DB access/FKs. Protected actions fail closed when mandatory controls are unavailable. Security-sensitive changes require independent human review and reproducible test evidence.
