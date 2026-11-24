# GitHub Repository Protection — Required Owner Configuration

**Purpose:** Make owner approval and PR review enforceable at repository merge time. Repository Markdown and AI prompts alone cannot prevent a contributor from pushing directly to an unprotected branch.

## 1. Required protection for main

A repository administrator should configure a branch protection rule or repository ruleset targeting the exact branch name main with:

1. Require a pull request before merging.
2. Require at least one approving review.
3. Require review from Code Owners.
4. Require the relevant status checks:
   - Validate AI agent instructions
   - Validate phase plan and change-control governance
5. Dismiss stale approvals when new commits are pushed, or require approval of the latest reviewable push.
6. Require conversation resolution before merge.
7. Block force pushes and branch deletion.
8. Do not allow routine bypass for administrators, apps or automation. Any exception must be explicitly documented by the Project Owner.
9. Do not allow AI agents or automation tokens to merge or deploy.

Exact setting names may vary between GitHub branch protection rules and repository rulesets. Configure the equivalent enforcement controls for main.

## 2. Code Owner

The repository contains .github/CODEOWNERS assigning the Project Owner to review changes. A CODEOWNERS file does not itself enforce approval: the repository must also enable “Require review from Code Owners” (or the equivalent rule).

## 3. Required pull request practice

- Every PR identifies plan version, phase, work package, approved work order and owner authorization reference.
- Changes to controlled plans, governance, architecture, ADRs, security policy or acceptance criteria include a Change Request document.
- CI checks must pass.
- The Project Owner reviews scope and evidence before merge.
- Security/architecture changes receive independent technical/security review as applicable.
- Merge is not the same as production deployment; production release requires its own gate decision.

## 4. Verification checklist

| Control | Expected setting | Verified by owner |
|---|---|---|
| Main requires PR | Enabled | Pending |
| At least one approval | 1 or more | Pending |
| Code Owner approval | Required | Pending |
| Required status checks | Both governance workflows | Pending |
| Stale approval handling | Enabled | Pending |
| Conversation resolution | Required | Pending |
| Force push/delete | Blocked | Pending |
| Bypass exceptions | None for routine AI/automation | Pending |

## 5. Current verification limitation

At the time this document was prepared, the GitHub rulesets read endpoint returned an empty list. The connected integration could not read the branch-protection endpoint (permission denied), so the current branch-protection configuration could not be verified. Do not assume main is protected until an administrator checks and records the settings above.
