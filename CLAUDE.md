# Instructions for Claude Code

Before every task, read `docs/README.md` first. Then follow `AGENTS.md`, `docs/governance/AI_Agent_Coding_Governance_v2.2.md`, the V2.2 technical specification, applicable ADRs and the V2.2 backlog.

V2.2 supersedes V2.1. Do not implement from V2.1 assumptions. If the mandatory README or policy documents are missing, stop and report the blocker.

All security controls are runtime enforcement requirements, not prompt-only guidance. Do not bypass the Harness, Policy Registry, server-side ACL, Data Lineage, Quota & Cost Governance or policy-aware resilience controls. Human approval is required for security-sensitive architecture deviations and destructive/high-impact actions.
