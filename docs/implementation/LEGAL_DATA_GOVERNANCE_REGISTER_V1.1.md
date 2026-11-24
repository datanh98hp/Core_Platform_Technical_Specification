# Legal & Data Governance Register V1.1 — Vietnam

**Plan:** CP-V2.2-EXEC-001 / V1.1  
**Status:** PROPOSED — counsel review required before real customer-data processing  
**Legal basis snapshot:** 2026-11-25  
**Owner:** Project Owner; legal/privacy counsel reviews applicable obligations

> This register is a product delivery control, not a legal opinion. Counsel must confirm the exact current text, implementing instruments, applicability, exemptions, filing duties, deadlines and contractual roles for the actual customer, data and processing route before launch.

## 1. Core legal reference register

| Area | Reference to verify | Delivery consequence |
|---|---|---|
| Personal data protection | Law No. 91/2025/QH15, effective 2026-01-01; Decree No. 356/2025/ND-CP, effective 2026-01-01 | Identify roles, lawful purpose/basis, data-subject rights, notices/consent where required, processor instructions, impact-assessment duties, cross-border processing/transfer, security and incident obligations |
| Artificial intelligence | Law No. 134/2025/QH15, effective 2026-03-01 | Classify AI system and use case; assess provider/deployer duties, transparency, human oversight, risk management, records and any prohibited/high-risk conditions |
| Cybersecurity | Law No. 116/2025/QH15, effective 2026-07-01; Decree No. 333/2026/ND-CP, effective 2026-08-19 | Assess cybersecurity, incident, service/provider, data-storage and cooperation obligations applicable to the SaaS service and customer sector |
| Data governance | Law No. 60/2024/QH15, effective 2025-07-01; Decree No. 165/2025/ND-CP, effective 2025-07-01 | Classify data and determine applicable requirements for data processing, storage, sharing, transfer and protection of important/core data |
| Electronic transactions | Law No. 20/2023/QH15, effective 2024-07-01; verify consolidated text No. 154/2026/VBHN-LQ-VPQH | Design electronic records, identity, integrity, approvals, audit trails and electronic signatures according to the legal effect required for each workflow |
| Copyright and IP | Intellectual Property Law as amended, including Law No. 131/2025/QH15 effective 2026-04-01; verify consolidated text No. 160/2026/VBHN-LQ-VPQH and current implementing instruments | Confirm rights in software, code, prompts, datasets, customer documents, model outputs, third-party assets and open-source dependencies |
| Tax/accounting and contracts | Current tax, e-invoice, accounting, consumer and commercial rules applicable to the service model | Confirm invoicing, VAT treatment, foreign supplier tax, subscription terms, service scope and customer notices |

Official reference pages:
- Personal Data Protection Law 91/2025/QH15: https://vanban.chinhphu.vn/?docid=214590&pageid=27160
- Decree 356/2025/ND-CP: https://vanban.chinhphu.vn/?docid=216387&pageid=27160
- AI Law 134/2025/QH15: https://vanban.chinhphu.vn/?docid=216334&pageid=27160
- Cybersecurity Law 116/2025/QH15: https://vanban.chinhphu.vn/?docid=216499&pageid=27160
- Decree 333/2026/ND-CP: https://vanban.chinhphu.vn/?docid=219244&pageid=27160
- Data Law 60/2024/QH15: https://vanban.chinhphu.vn/?docid=212488&pageid=27160
- Decree 165/2025/ND-CP: https://vanban.chinhphu.vn/?docid=214331&pageid=27160
- Electronic Transactions Law 20/2023/QH15: https://vanban.chinhphu.vn/?docid=208421&pageid=27160
- IP amendment Law 131/2025/QH15: https://vanban.chinhphu.vn/?docid=216511&pageid=27160

Decree 13/2023/ND-CP is not to be treated as the current primary personal-data-protection instrument after Decree 356/2025/ND-CP took effect. Transitional records and prior processing arrangements must be assessed by counsel; do not automatically discard or automatically assume they remain sufficient.

## 2. Required decisions before processing real customer data

For every pilot or production tenant, record:

1. Customer, startup, provider and subprocessor roles for each processing activity.
2. Data owner, data-subject groups, data categories and sensitivity/classification.
3. Specific purpose, lawful basis and customer instruction for each processing route.
4. Notice/consent and data-subject request workflow where required.
5. Data-processing agreement, confidentiality terms, provider/subprocessor clauses and audit rights.
6. Storage location, provider region, remote access locations and any cross-border transfer/processing assessment.
7. Retention schedule, deletion/export procedure, legal hold and backup expiry.
8. Access control, privileged access, audit logging, incident handling and evidence retention.
9. AI system/use-case risk classification, transparency/notice, human oversight and output review.
10. Customer approval for connectors, tools, model/provider use and any secondary purpose.

Do not assume a startup/SME exemption applies. Counsel must test the actual statutory conditions, including whether the startup provides personal-data-processing services, directly processes sensitive personal data or processes data of a large number of subjects.

## 3. AI-specific and IP controls

- Do not send personal, confidential, C2/C3 or UNKNOWN data to an external provider unless the data category, legal basis, customer contract, security route, provider terms and approved policy expressly permit the specific path.
- Verify model-provider retention, training/use of prompts, human review, region, subprocessors, deletion, security incidents and export before enabling a route.
- Do not use customer content to train, fine-tune or improve a shared model/service without a separately documented right, lawful basis, contract and approval.
- Keep dataset provenance and licence evidence. Do not scrape, ingest, redistribute or expose copyrighted materials without rights or a valid legal basis.
- Require contractor IP assignment/creation terms, confidentiality and return/deletion obligations. Maintain SBOM, OSS licence notices and third-party asset inventory.
- Distinguish AI-generated output from source material; do not promise exclusive ownership or non-infringement without legal review.
- Keep a human decision-maker for consequential workflows. Exclude autonomous hiring, credit, medical, educational or similarly high-impact decisions from MVP unless separately assessed, approved and legally supported.

## 4. Stage responsibilities and legal gate

| Stage | Required action | Gate evidence |
|---|---|---|
| G0 | Map data types, purposes, roles, providers, regions, retention and open legal questions | Initial legal applicability matrix and data inventory |
| G1 | Build data classification, tenant ACL, deletion and audit primitives | Architecture-to-control mapping |
| G2 | Verify safe data paths, policy enforcement, redaction and deletion on MVP flows | Security test evidence and approved data-route matrix |
| G3 | Restrict benchmark/test data, model routes and customer-data entry | Dataset provenance and provider configuration records |
| G4 | Complete policy/lineage/quota auditability and deletion lifecycle | Control evidence and audit trail |
| G5 | Counsel-reviewed pilot contract/DPA/notices/roles/subprocessors and tenant-specific data schedule | Signed customer pack and tenant approval checklist |
| G6 | Refresh legal review against then-current law, approve commercial terms, privacy disclosures, incident and support process | Signed legal/commercial launch checklist |

## 5. Hard stop conditions

Stop the affected data path and escalate when the lawful basis/purpose is unknown, customer authority is missing, sensitive data is routed to an unapproved provider, cross-border processing has not been assessed where required, a data-subject request cannot be handled, deletion cannot be evidenced, a subprocessor is undisclosed/unapproved, or an incident/reporting obligation is not understood.

The Project Owner cannot waive a statutory prohibition or make a legal-compliance claim in place of qualified counsel.
