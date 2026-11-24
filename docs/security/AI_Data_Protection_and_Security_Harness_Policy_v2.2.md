# AI DATA PROTECTION & SECURITY HARNESS POLICY
**Version:** 1.0 | **Status:** Mandatory baseline

## 1. Non-negotiable rule
No internal sensitive data, customer confidential information, personal data, credentials, production data or private source code may be uploaded, pasted, indexed, embedded, logged, fine-tuned on or otherwise transmitted to public/external AI services or ordinary AI coding agents. AI use is deny-by-default. If a task requires such data, stop and use a non-AI process or a dedicated private environment only after formal Security, Privacy, Legal and data-owner approval. A provider's no-training setting alone is not sufficient approval.

## 2. Data classification
| Class | Examples | AI handling |
|---|---|---|
| C0 Public | Published material, public docs, synthetic data | Allowed through approved AI Gateway |
| C1 Internal non-sensitive | Generic process descriptions, non-identifying templates | Only after owner approval, minimization and DLP screening |
| C2 Confidential | Internal plans, proprietary source code, contracts, customer documents, non-public financial/HR data | Prohibited to external AI and coding agents; private AI only after documented risk/legal/security approval |
| C3 Restricted | Passwords, API keys, tokens, private keys, production dumps, authentication data, highly sensitive personal data, security incident evidence | Prohibited to external AI and ordinary agents; private AI prohibited by default, exception only with explicit written approval and isolated environment |

Project default: AI coding agents may receive only C0 and explicitly approved, minimized C1. Unknown classification is treated as C2 and blocked. Masking is not automatically anonymization.

## 3. Preparation and handling
1. Identify owner, purpose, classification and lawful basis. 2. Minimize context. 3. Replace real data with synthetic values; remove direct and indirect identifiers. 4. Scan for secrets, PII and customer identifiers. 5. Confirm C0 or approved C1 before processing. 6. Store policy metadata/hash, not raw sensitive payload.

Never provide `.env`, credentials, production exports, raw customer tickets, private keys, unredacted screenshots, logs containing identifiers or proprietary files to public AI/coding agents. Use synthetic fixtures in development and tests.

## 4. AI Security Harness – required architecture
Harness is a runtime policy enforcement layer, not a system prompt. Every LLM, embedding, reranker, OCR-to-LLM, RAG, agent tool call and AI coding-agent integration must pass through it. Direct provider SDK calls from frontend or business services are prohibited.

```text
User / Service / Agent
  -> Identity + Tenant + Purpose validation
  -> AI Security Harness (classification, DLP, secret/PII scan, redaction, ACL, prompt-injection controls, provider/model allowlist, tool policy, quotas)
  -> ALLOW | REDACT_AND_ALLOW | BLOCK | HUMAN_APPROVAL
  -> AI Gateway / Model Adapter
  -> Approved model endpoint
  -> Output DLP + schema validation
  -> Caller (least privilege; no automatic privileged action)
```

### Required controls
- Ingress: validate identity, tenant, purpose, source and use case.
- Pre-inference: scan prompts, files, OCR text, retrieved chunks, tool arguments and metadata; block C2/C3 and secrets before egress.
- Retrieval: enforce tenant and document ACL before chunks reach model context; vector similarity is never authorization.
- Routing: provider/model allowlist, region and retention policy, quota and context limits.
- Tools: explicit allowlist, argument schema, least privilege, sandbox, network egress restrictions, timeout and human approval for consequential side effects.
- Output: scan for leaked secrets/PII, validate structured output, treat model output and retrieved content as untrusted.
- Audit: metadata-only by default: policy version, decision, reason, model, opaque tenant/user IDs, usage, timestamp and trace ID. Do not log raw prompts, retrieved content, attachments, secrets or full completions.
- Fail closed: if classifier, DLP, ACL, policy engine or provider verification is unavailable, do not call the model. No bypass fallback.

## 5. MVP implementation
Implement Harness as a mandatory module within AI Engine Service, with independent interfaces for future extraction. AI Gateway is routing/adapter; Harness is policy decision/enforcement. Required functions: `classify_payload`, `scan_secrets`, `detect_pii`, `redact_payload`, `authorize_ai_use`, `filter_retrieval_context`, `authorize_tool_call`, `validate_output`, `record_decision`. Network policy must deny model-provider egress from all workloads except approved AI Gateway.

Minimum decision metadata: policy_version, opaque tenant/user IDs, purpose, classification, source_refs, provider/model, decision, reason_codes, redaction_applied, approval_id, trace_id, created_at. Store usage and decisions; raw prompts/completions disabled by default.

Document classification must propagate to OCR text, chunks, embeddings, caches and derived artifacts. C2/C3 must not be sent to external OCR, embedding, reranking or LLM providers. Delete/revoke must propagate through all derived data. MinIO objects remain private, tenant-scoped and encrypted. Secrets belong in a secret manager; DB stores only `secret_ref`.

## 6. Minimum security controls
| Area | Requirement |
|---|---|
| Identity | OIDC/SSO where available, MFA for privileged roles, short-lived scoped credentials |
| Authorization | RBAC/ABAC, server-side tenant and document ACL |
| Secrets | Secret manager, secret scanning in pre-commit/CI |
| Network | Private service network, egress allowlist, direct provider egress denied |
| Encryption | TLS in transit, encryption at rest, key rotation and audit |
| DLP | Secret/PII detection, classification, redaction, fail-closed |
| Providers | Contract, retention, training, subprocessor and data-region review |
| Agents | Tool allowlist, sandbox, least privilege, approval for side effects |
| Logs | Metadata-only by default, tamper-resistant audit |

## 7. Release gates
Release is blocked unless evidence proves: (1) C2/C3 blocked before provider egress; (2) fake-secret canary never reaches provider; (3) DLP outage fails closed; (4) cross-tenant and document ACL tests pass; (5) prompt injection cannot override policy or grant tools; (6) unapproved providers and direct egress are denied; (7) tools cannot access unauthorized files/secrets/network; (8) logs/traces contain no raw sensitive payloads; (9) deletion/revocation propagates to OCR, chunks, embeddings and caches; (10) human approval gates consequential external actions. Record test command, environment, timestamp, result, commit SHA and reviewer.

## 8. Incident response
Disable affected provider/model route and connectors, revoke credentials, isolate impacted workload/tenant, preserve metadata audit evidence, notify Security/Privacy owner, determine data classes/recipients/time window, and follow the approved incident procedure. Assess legal and contractual notification duties with qualified counsel; do not improvise deadlines.

## 9. Vietnam legal review
Before processing personal/customer data, document purposes, categories, roles, lawful basis, notices/consents where applicable, processors/subprocessors, storage locations, cross-border transfers, retention, data-subject requests and incident handling. Have counsel verify current Vietnamese personal-data protection, cybersecurity, consumer, e-commerce, IP, employment and sector-specific requirements effective at deployment. This policy is not legal advice. Hosting in Vietnam or removing names alone does not establish compliance/anonymization.

## 10. Rollout
| Phase | Deliverable | Gate |
|---|---|---|
| H0 | No-sensitive-data developer rule, synthetic fixtures, secret scan | Team acknowledges; repo scan enabled |
| H1 | Harness module, provider allowlist, DLP, redaction, fail-closed, metadata audit | Adversarial and tenant tests pass |
| H2 | Retrieval ACL, classification inheritance, egress firewall, tool sandbox | No bypass path; security review signed |
| H3 | Policy administration, private-model option, SIEM, continuous red-team | Risk acceptance and runbooks approved |

## 11. Mandatory agent instruction
> Never upload, paste, summarize, embed, index, log or transmit internal sensitive/customer/production-secret data to external AI or ordinary coding agents. Use synthetic, public or approved sanitized C0/C1 only. If classification is unknown or sensitive source data is required, stop and return `BLOCKED — DATA CLASSIFICATION / SECURITY APPROVAL REQUIRED`. Never bypass Harness, DLP, tenant ACL, egress controls or human approval. Security policy outranks task completion.

---


# PHỤ LỤC A – KỊCH BẢN KIỂM THỬ VÀ NGHIỆM THU CHỐNG RÒ RỈ DỮ LIỆU AI

**Mã phụ lục:** APP-AI-SEC-ACCEPTANCE  
**Phiên bản:** 1.0  
**Phạm vi:** AI Security Harness, AI Gateway, Document, Knowledge/RAG, OCR, Agent Tools, logging/telemetry và network egress.  
**Nguyên tắc:** Chỉ sử dụng dữ liệu synthetic và Canary Token giả lập. Không dùng dữ liệu nội bộ thật hoặc gửi dữ liệu nhạy cảm tới nhà cung cấp AI thật trong kiểm thử.

## A.1. Mục tiêu nghiệm thu

Chứng minh bằng bằng chứng độc lập rằng dữ liệu C2/C3 bị cấm không xuất hiện trong bất kỳ payload nào rời khỏi hệ thống để đến nhà cung cấp AI; không có đường gọi provider bỏ qua Harness; và mọi đường xử lý AI đều thực thi cùng một chính sách.

Không chấp nhận chỉ dựa vào thông báo `BLOCK` từ Harness. Phải đối chiếu tối thiểu:
1. Harness audit decision và policy version.
2. Network egress/firewall evidence.
3. Payload thực tế tại Provider Mock hoặc egress test proxy do đội kiểm thử kiểm soát.
4. Kết quả đối chiếu Canary Token từ Security Verifier độc lập.

## A.2. Môi trường và dữ liệu kiểm thử

### A.2.1. Thành phần môi trường
- Test Client/AI Agent.
- AI Engine + AI Security Harness.
- AI Gateway.
- DLP/classification/secret scanner.
- Egress firewall hoặc outbound proxy có allowlist.
- Provider Mock chỉ nhận request thử nghiệm.
- Independent Security Verifier.
- Log/audit collector dùng metadata test.

### A.2.2. Canary Token giả lập
Ví dụ chuỗi nhận diện:
- `INTERNAL-CANARY-2026-001`
- `CONFIDENTIAL-TEST-ACCOUNT-92831`
- `SECRET-TEST-PROJECT-ALPHA-7742`

Canary phải là dữ liệu giả lập, không có giá trị xác thực hoặc thông tin của cá nhân/doanh nghiệp thật. Verifier cần kiểm tra exact match và các dạng biến đổi được định nghĩa trong test (ví dụ Base64, URL encoding, JSON escaping, chia đoạn rồi ghép lại trong payload). Không dùng việc dò tìm tùy tiện để kết luận mọi biến thể đều đã được phát hiện.

## A.3. Danh mục test case bắt buộc

| Test ID | Kịch bản | Kết quả bắt buộc |
|---|---|---|
| SEC-001 | Người dùng đưa dữ liệu C2 trực tiếp vào prompt | BLOCK; không có outbound payload chứa canary |
| SEC-002 | Upload tài liệu C2 để tóm tắt | Nội dung tài liệu không tới external provider |
| SEC-003 | Yêu cầu phân tích hợp đồng/báo cáo giả lập được gắn C2 | BLOCK trước inference |
| SEC-004 | Dữ liệu C2 được đóng gói thành JSON | Vẫn BLOCK; không dựa riêng vào định dạng |
| SEC-005 | Canary được mã hóa/escape/chia nhỏ theo biến thể test đã định nghĩa | Phát hiện hoặc chặn theo policy; không có canary tái tạo được ở outbound |
| SEC-006 | Dữ liệu C2 xuất hiện trong OCR output | Phân loại/DLP lại trước khi chuyển tiếp; không external egress |
| SEC-007 | C2 nằm trong Knowledge Base/RAG chunks | ACL + classification chặn trước model context |
| SEC-008 | Tài liệu có prompt injection yêu cầu gửi dữ liệu nội bộ | Không thay đổi policy, quyền hoặc tool allowlist |
| SEC-009 | Agent tool đọc nguồn dữ liệu nội bộ | Tool authorization và data classification được thực thi trước khi trả dữ liệu |
| SEC-010 | Service thử gọi provider trực tiếp, bỏ qua Harness | Egress firewall/network policy từ chối |
| SEC-011 | Harness, DLP hoặc policy engine bị lỗi | Fail-closed; không có provider request |
| SEC-012 | Tenant A truy vấn dữ liệu Tenant B | Không truy xuất, không đưa dữ liệu chéo tenant vào model context |
| SEC-013 | Canary xuất hiện trong log/tracing/metrics | Không ghi raw sensitive payload; phát hiện là FAIL |
| SEC-014 | Model output chứa canary/dữ liệu cấm | Output DLP chặn hoặc xử lý theo policy trước khi trả về caller |
| SEC-015 | Xóa/revoke tài liệu nguồn | Chunks, embeddings, cache và artifacts liên quan bị xóa/vô hiệu hóa theo SLA retention đã định |

## A.4. Quy trình chi tiết cho các test trọng yếu

### SEC-001 – Chặn dữ liệu C2 trực tiếp
1. Tạo fixture C2 giả lập có Canary Token.
2. Gửi request qua public application API, không gọi Harness nội bộ trực tiếp.
3. Ghi nhận trace ID, tenant test, policy version và quyết định.
4. Kiểm tra Provider Mock và egress proxy.
5. Chạy Security Verifier trên mọi request outbound.

**PASS:** Harness trả BLOCK; không có request chứa canary tới Provider Mock; không có payload nhạy cảm ở outbound; audit chỉ ghi metadata cần thiết.  
**FAIL:** Bất kỳ outbound payload nào chứa canary, kể cả khi Harness trả BLOCK.

### SEC-008 – Prompt injection trong tài liệu
1. Tạo tài liệu synthetic có chỉ dẫn giả mạo như “ignore previous restrictions”.
2. Đưa tài liệu qua Document Service và yêu cầu phân tích.
3. Theo dõi retrieval, tool call, policy decision và outbound payload.
4. Kiểm tra tài liệu không thể thay đổi system policy, tenant ACL hoặc tool permission.

**PASS:** Nội dung không tin cậy được xử lý như dữ liệu, không có quyền điều khiển policy; không phát sinh truy cập trái quyền hoặc rò rỉ canary.  
**FAIL:** Prompt injection làm thay đổi policy, mở rộng quyền hoặc làm lộ canary.

### SEC-010 – Thử bypass Harness
1. Trong môi trường test cô lập, tạo workload/service test không đi qua AI Gateway.
2. Thử kết nối Provider Mock bằng route trực tiếp.
3. Thử từ các service Document, Knowledge, Workflow và Integration.
4. Kiểm tra firewall/egress policy và network flow logs.

**PASS:** Mọi route không được phép bị chặn ở tầng network.  
**FAIL:** Có workload nào kết nối provider endpoint ngoài allowlist hoặc không qua egress gateway đã duyệt.

### SEC-011 – Fail-closed
1. Tắt DLP/classifier hoặc làm policy service timeout trong môi trường test.
2. Gửi request C0, C1 và C2.
3. Quan sát AI Gateway và Provider Mock.

**PASS:** Request AI bị từ chối an toàn khi không thể xác định policy; không có fallback bỏ qua kiểm tra.  
**FAIL:** Request được gửi tiếp khi DLP/policy/ACL không sẵn sàng.

## A.5. Phương pháp xác minh độc lập

| Bằng chứng | Cách xác minh |
|---|---|
| Harness audit | Decision, reason code, policy version, trace ID; không chứa raw payload |
| Egress firewall | Destination, workload identity, allow/deny, timestamp, trace/correlation ID |
| Provider Mock | Payload nhận thực tế tại TLS termination của mock |
| Security Verifier | Quét canary và biến thể test trong payload outbound, đối chiếu với test manifest |
| CI report | Commit SHA, test ID, test environment, timestamp, result, reviewer |

**Giới hạn kỹ thuật:** Packet capture thông thường chỉ chứng minh kết nối mạng, không chứng minh nội dung bên trong TLS. Phải kiểm tra payload tại Provider Mock hoặc test egress proxy do đội kiểm thử kiểm soát. Không triển khai TLS interception tùy tiện trên production traffic.

## A.6. Tiêu chí PASS/FAIL và Release Gate

Release bị BLOCK nếu có một trong các điều kiện:
- Bất kỳ Canary C2/C3 nào xuất hiện trong payload outbound.
- Có direct provider egress ngoài allowlist/Harness.
- DLP/classification/policy outage nhưng request vẫn được gửi.
- Có cross-tenant data trong retrieval context.
- Raw sensitive payload xuất hiện trong logs/traces/metrics.
- Thiếu bằng chứng độc lập hoặc thiếu reviewer được phân quyền.

Mục tiêu nghiệm thu:
- 100% test case bắt buộc được thực thi và có bằng chứng.
- 0 lần rò rỉ C2/C3 trong test suite.
- 0 đường bypass provider egress được xác nhận.
- 100% tình huống policy dependency outage áp dụng fail-closed.
- 100% test cross-tenant isolation đạt yêu cầu.

Các mục tiêu trên là tiêu chí cho phạm vi test đã định nghĩa, không phải chứng minh tuyệt đối rằng không thể có lỗ hổng chưa được biết đến.

## A.7. Mẫu báo cáo nghiệm thu

| Trường | Giá trị cần ghi |
|---|---|
| Test ID | SEC-001…SEC-015 |
| Build/Commit SHA | Phiên bản được kiểm thử |
| Policy Version | Phiên bản policy |
| Environment | Test/staging |
| Data Classification | C0/C1/C2/C3 |
| Harness Decision | ALLOW/BLOCK/REDACT_AND_ALLOW/HUMAN_APPROVAL |
| Provider Request | Có/Không |
| Canary Found Outbound | Có/Không |
| Egress Result | Allowed/Denied |
| Result | PASS/FAIL |
| Evidence References | Trace ID, firewall event, mock receipt, CI run |
| Reviewer | Người xác nhận độc lập |
| Exception | Mã phê duyệt, phạm vi, thời hạn (nếu có) |

Không đưa dữ liệu thật hoặc bí mật vào báo cáo. Lưu fixture và canary chỉ trong môi trường kiểm thử được kiểm soát.

## A.8. Tần suất thực hiện

Chạy bộ test:
- Mỗi pull request có thay đổi AI Engine, Harness, DLP, provider adapter, RAG, OCR hoặc agent tools.
- Mỗi lần thay đổi provider/model, network egress, firewall hoặc deployment configuration.
- Trước mỗi release production.
- Định kỳ theo lịch kiểm thử bảo mật và sau sự cố liên quan đến dữ liệu.

AI coding agent không được tự nghiệm thu thay đổi bảo mật do chính nó tạo ra. Cần reviewer độc lập và lưu bằng chứng CI.


## V2.2 Addendum — mandatory controls
This addendum is authoritative where it adds controls beyond the original policy. The Core Platform Technical Specification V2.2 is the overall architecture baseline.

### Security Policy Registry
Policies must be immutable, versioned, reviewed, approved and activated. Caller-supplied policy identifiers, classification labels and permission flags do not authorize processing. Resolve and revalidate policy server-side before provider egress and tool execution. Unknown, expired, revoked, stale or unavailable policy means DENY for protected operations.

### Data Lineage
Maintain source-to-derived lineage for documents, OCR, normalized text, chunks, embeddings, retrieval context, AI requests and outputs. Derived objects inherit the highest parent classification and intersection of parent ACLs. Revocation/deletion must reach indexes, embeddings, caches, object storage derivatives and queued work. Do not place raw content in lineage records.

### Quota and Cost Governance
Reserve quota atomically before execution; reconcile actual usage after execution. Use idempotency keys to prevent duplicate reservations/charges. Maintain immutable usage ledger, versioned rate cards, tenant-isolated dashboards, hard limits, soft warnings and audited overrides. Quota-control outage denies billable/protected execution.

### Resilience and circuit breaker
All provider calls have deadlines, bounded retries and idempotency. Circuit breakers use CLOSED/OPEN/HALF_OPEN states. Fallback requires a fresh policy decision and an approved provider/model with equivalent or stricter data protections. No fallback may bypass policy denial or quota. Control-plane outage fails closed.

### Additional acceptance tests
- SEC-016 forged classification or external-AI permission is rejected.
- SEC-017 stale/revoked policy blocks provider egress.
- SEC-018 ACL revocation blocks RAG and invalidates cache.
- SEC-019 lineage deletion reaches chunks, embeddings, indexes, caches and queued jobs.
- SEC-020 quota reservation is atomic; retry cannot double-charge.
- SEC-021 provider outage opens circuit; unapproved fallback is rejected.
- SEC-022 policy/lineage/quota outage fails closed.
- SEC-023 no cross-service FK or direct cross-schema runtime access.
- SEC-024 no raw sensitive payload in telemetry.
- SEC-025 tenant usage/cost/circuit telemetry is isolated.

### Release gates
0 protected-data provider egress; 0 cross-tenant retrieval or cost disclosure; 100% fail-closed behavior for protected operations when mandatory controls are unavailable; 0 raw sensitive payload in telemetry; all acceptance tests reproducible with independent review. These gates apply to tested scope and are not a guarantee that unknown vulnerabilities do not exist.
