
# AI AGENT CODING GOVERNANCE & SERVICE IMPLEMENTATION PLAYBOOK
**Phiên bản:** 1.0  
**Phạm vi:** Core Platform – Engineering Implementation Package v1  
**Đối tượng:** AI coding agents, Founder/Tech Lead, Backend Engineer, Frontend Engineer, QA Engineer  
**Nguyên tắc bắt buộc:** Không được tự ý thay đổi kiến trúc, thứ tự triển khai, database ownership, API/gRPC/event contracts hoặc tiêu chí nghiệm thu nếu chưa có phê duyệt của Tech Lead.

---

## 1. Mục tiêu và nguyên tắc điều hành

Tài liệu này là bộ quy tắc làm việc bắt buộc cho mọi AI Agent tham gia phát triển Core Platform. Mục tiêu không chỉ là tạo code chạy được, mà là tạo từng chức năng có thể kiểm chứng, an toàn đa tenant, dễ bảo trì, có khả năng mở rộng và không làm hỏng chức năng đã nghiệm thu.

### 1.1 Nguyên tắc không được vi phạm

1. **Làm đúng thứ tự phụ thuộc:** không triển khai service phụ thuộc khi service nền tảng chưa qua acceptance gate.
2. **Không tự ý mở rộng phạm vi:** chỉ làm đúng ticket/user story được giao; không thêm framework, service, bảng, package hoặc tính năng ngoài phạm vi.
3. **Database ownership tuyệt đối:** mỗi service chỉ được ghi vào schema do service đó sở hữu. Service khác truy cập qua gRPC hoặc event contract; không đọc/ghi trực tiếp bảng của service khác.
4. **Contract-first:** cập nhật và review OpenAPI, `.proto`, event JSON Schema trước hoặc đồng thời với implementation; không tự ý phá vỡ backward compatibility.
5. **Tenant isolation mặc định deny:** mọi truy vấn, cache key, object key, event consumer và background job phải được giới hạn tenant. Không tin `tenant_id` do frontend tự gửi nếu chưa xác minh membership/quyền.
6. **Test trước khi báo hoàn thành:** không được tuyên bố “done”, “fixed”, “working” nếu chưa chạy và ghi lại test thực tế.
7. **Frontend và backend phải được kiểm tra cùng nhau:** API unit test đơn lẻ không đủ nghiệm thu chức năng người dùng.
8. **Không che lỗi bằng fallback giả:** không dùng mock data trong production path, không nuốt exception, không trả success giả, không bỏ qua test đang fail.
9. **Bảo vệ dữ liệu:** không ghi access token, refresh token, mật khẩu, API key, raw prompt nhạy cảm hoặc nội dung tài liệu riêng tư vào log.
10. **Thay đổi nhỏ, có thể rollback:** ưu tiên PR nhỏ, một mục tiêu, migration có kế hoạch và feature flag khi cần.

### 1.2 Thứ tự ưu tiên khi có xung đột

| Ưu tiên | Quy tắc |
|---|---|
| P0 | Bảo mật, tenant isolation, tính đúng đắn dữ liệu, không mất dữ liệu |
| P1 | Kiến trúc đã duyệt, database ownership, contract compatibility, dependency order |
| P2 | Chức năng nghiệp vụ và acceptance criteria |
| P3 | Hiệu năng, khả năng vận hành, khả năng bảo trì |
| P4 | UI/UX, tiện ích và tối ưu không ảnh hưởng correctness |

Nếu yêu cầu mới xung đột với P0/P1, agent phải dừng, mô tả xung đột và đề xuất phương án; không được tự chọn cách “tiện nhất”.

---

## 2. Kiến trúc mục tiêu và ranh giới service

### 2.1 Các service trong baseline

1. **API Gateway / BFF** – public REST ingress, xác thực token, rate limit, request validation, correlation ID, routing.
2. **Identity Service** – user, organization, membership, role, permission, session và quyền truy cập.
3. **Core Business Service** – workspace, module entitlement, tenant limits, business settings.
4. **Document Service** – metadata tài liệu, version, upload/download session, processing jobs và artifact metadata; object bytes nằm trong MinIO.
5. **AI Engine Service** – provider/model abstraction, prompt versions, generation, embedding, quota và usage metering.
6. **Knowledge Service** – knowledge base, sources, chunks, indexing, hybrid/vector search và ACL filtering.
7. **Workflow Service** – workflow definitions/versions, runs, tasks, approval transitions và audit history.
8. **Integration Service** – webhook subscriptions/deliveries, notifications, connector metadata và outbound integrations.
9. **Frontend Web App** – UI theo quyền, gọi public REST API; không gọi DB, không gọi trực tiếp private gRPC service.

> Tên và số lượng service phải khớp với Technical Specification v2 và Engineering Implementation Package v1. Nếu tài liệu kiến trúc được cập nhật, Tech Lead phải phát hành revision mới trước khi agent đổi code.

### 2.2 Topology giao tiếp

- Frontend → HTTPS → API Gateway/BFF → service APIs.
- Service-to-service synchronous call → gRPC có deadline, authentication và trace propagation.
- Asynchronous integration → NATS JetStream event; at-least-once, consumer idempotent.
- Document binary → direct signed URL upload/download tới MinIO; API chỉ cấp quyền và xác minh object.
- PostgreSQL: schema ownership riêng; không dùng chung ORM model giữa service.
- Redis chỉ dùng cache/ephemeral coordination; không là nguồn dữ liệu nghiệp vụ chính.

### 2.3 Database ownership bắt buộc

| Schema | Owner | Các service khác |
|---|---|---|
| `identity` | Identity | Chỉ qua Identity gRPC/events |
| `core` | Core Business | Chỉ qua Core gRPC/events |
| `document` | Document | Chỉ qua Document gRPC/events |
| `ai` | AI Engine | Chỉ qua AI gRPC/events |
| `knowledge` | Knowledge | Chỉ qua Knowledge gRPC/events |
| `workflow` | Workflow | Chỉ qua Workflow gRPC/events |
| `integration` | Integration | Chỉ qua Integration gRPC/events |
| `platform_shared` | Platform infrastructure | Chỉ outbox/inbox theo quyền hẹp; không chứa business data dùng chung |

Mọi truy vấn dữ liệu tenant phải có tenant scope rõ ràng. Dùng PostgreSQL RLS nếu đã được quyết định trong ADR; application-level filter vẫn bắt buộc, RLS là lớp phòng vệ bổ sung chứ không thay thế authorization.

---

## 3. Trình tự phát triển bắt buộc và điều kiện mở khóa

Không được bỏ qua gate hoặc triển khai song song các service phụ thuộc nếu chưa có chấp thuận bằng văn bản.

| Thứ tự | Thành phần | Phụ thuộc | Điều kiện mở khóa |
|---|---|---|---|
| 0 | Architecture & repo foundation | Không | ADR, coding standards, CI, local compose, secret policy được duyệt |
| 1 | Identity | Foundation | Auth flow, tenant membership, RBAC, negative tenant tests đạt |
| 2 | Core Business | Identity | Workspace, entitlements, tenant limits API và contract tests đạt |
| 3 | API Gateway/BFF | Identity + Core contracts | Auth propagation, permission enforcement, error mapping, rate limit đạt |
| 4 | gRPC + NATS backbone | Foundation + contracts | Deadline, tracing, outbox/inbox, replay/dedup test đạt |
| 5 | Document + MinIO | Identity/Core/Gateway + NATS | Signed upload, checksum, object isolation, async job và retry test đạt |
| 6 | AI Engine | Identity/Core + NATS | Provider abstraction, quota, timeout, cost metering và secret handling đạt |
| 7 | Knowledge | Document + AI + Identity | ACL-aware indexing/search, deletion propagation, citation test đạt |
| 8 | Workflow | Identity + Core + NATS + Integration contract | Versioning, state machine, idempotency, human approval test đạt |
| 9 | Integration | NATS + Identity + Core | Webhook signature, SSRF guard, retry/DLQ, notification test đạt |
| 10 | Frontend feature integration | Gateway + từng service đã nghiệm thu | E2E UI/API, accessibility cơ bản, permission-state test đạt |
| 11 | Hardening & pilot | Tất cả P0/P1 | Load, security, restore, monitoring, UAT và rollback đạt |

**Quy tắc:** Frontend có thể phát triển shell/layout và design system từ sớm, nhưng không được giả lập hoàn tất nghiệp vụ bằng mock data rồi coi là tích hợp. Mỗi feature chỉ được nghiệm thu khi kết nối backend thật trên môi trường test/staging.

---

## 4. Quy trình làm việc chuẩn cho mọi AI coding agent

Mỗi ticket phải được thực hiện qua đủ các bước sau. Không được bỏ qua bước chỉ vì thay đổi “nhỏ”.

### Bước 1 – Đọc và xác nhận phạm vi
- Đọc ticket, user story, acceptance criteria, service README, ADR liên quan và contract hiện hành.
- Xác định service owner, schema owner, dependencies, endpoint/event liên quan và phần frontend bị ảnh hưởng.
- Ghi rõ những gì **không nằm trong phạm vi**.
- Nếu yêu cầu thiếu thông tin hoặc mâu thuẫn, hỏi lại; không suy đoán về nghiệp vụ, quyền hoặc data retention.

**Đầu ra:** Implementation plan ngắn, file dự kiến sửa, dependency list, test plan.

### Bước 2 – Kiểm tra baseline trước khi sửa
- Kiểm tra branch, working tree, commit hiện tại.
- Chạy lint, type-check, unit test và integration test hiện có.
- Ghi nhận lỗi baseline có sẵn; không quy lỗi cũ cho thay đổi mới.
- Kiểm tra migration status, OpenAPI/proto/event schema version.

**Đầu ra:** Baseline test report.

### Bước 3 – Thiết kế contract và dữ liệu
- Nếu đổi API: cập nhật OpenAPI trước; xác định request/response, status code, error shape, pagination, idempotency.
- Nếu đổi gRPC: cập nhật `.proto`, giữ nguyên field number đã phát hành; không tái sử dụng field number đã xóa; thêm field mới theo nguyên tắc tương thích.
- Nếu đổi event: cập nhật JSON Schema, subject/version, producer/consumer impact, replay strategy.
- Nếu đổi DB: migration forward-only có rollback/forward-fix plan; index theo query; constraint/foreign key; tenant scope.
- Không để frontend hoặc service khác phụ thuộc trực tiếp schema DB nội bộ.

**Đầu ra:** Contract diff, migration plan, compatibility note.

### Bước 4 – Implement backend trước
- Xây domain/service layer, repository layer và transport/controller tách biệt.
- Validate input ở boundary; kiểm tra authn/authz ở server.
- Áp dụng timeout/deadline, retry có giới hạn, circuit breaker khi gọi dependency.
- Với NATS: transactional outbox; consumer inbox/dedup; ACK sau commit.
- Với MinIO: bucket/key có tenant scope; signed URL TTL ngắn; xác minh size, MIME, checksum và quyền truy cập.
- Không chạy OCR/LLM/file parsing nặng trong HTTP request thread.
- Không để business logic trong controller hoặc frontend.

**Đầu ra:** Backend implementation, migration, contract tests, unit/integration tests.

### Bước 5 – Kiểm thử backend
Bắt buộc chạy:
1. Unit tests cho domain/service.
2. Repository tests trên PostgreSQL thật hoặc test container tương thích.
3. API/gRPC contract tests.
4. Authorization tests: unauthenticated, wrong tenant, wrong role, revoked session.
5. Validation tests: thiếu field, sai format, payload quá lớn, duplicate idempotency key.
6. Failure tests: DB timeout, NATS unavailable, MinIO unavailable, AI provider timeout.
7. Migration tests: database trống → migrate lên; database phiên bản trước → upgrade.
8. Regression tests cho chức năng liên quan.

**Không đạt:** sửa code hoặc ghi rõ blocker; không được chuyển sang “done”.

### Bước 6 – Implement frontend
- Dùng đúng OpenAPI-generated types/client hoặc contract type đã duyệt.
- Không hardcode tenant/user/role; lấy context từ phiên xác thực và backend.
- Có đầy đủ loading, empty, success, validation error, permission denied, network error, retry state.
- Không hiển thị action nếu không có quyền; backend vẫn phải kiểm tra quyền độc lập.
- Chống double submit với idempotency cho hành động tạo/duyệt/thanh toán hoặc hành động có side effect.
- Không đưa secret/API provider key vào browser bundle.

**Đầu ra:** UI component/page, state handling, frontend tests.

### Bước 7 – Kiểm thử tích hợp frontend/backend
Mỗi user flow phải được chạy từ UI qua API tới database/queue/object storage và trở lại UI:
- Happy path.
- Validation failure.
- Permission denied.
- Wrong tenant / resource not found.
- Network interruption / timeout.
- Duplicate submission.
- Refresh/reopen page và kiểm tra trạng thái được khôi phục đúng.
- Kiểm tra responsive ở kích thước màn hình mục tiêu.

Dùng Playwright/Cypress hoặc công cụ E2E đã được repo chuẩn hóa. Không thay test E2E bằng screenshot thủ công.

**Đầu ra:** E2E report, video/trace hoặc screenshot khi test fail, defect list.

### Bước 8 – Kiểm tra hiệu năng và bảo mật theo mức thay đổi
- API read/write: p50/p95/p99, throughput, error rate.
- DB: query plan, index usage, connection pool, lock contention.
- Queue: publish/consume latency, backlog, redelivery, DLQ.
- AI: time-to-first-token, timeout, token usage, cost per request.
- Tenant noisy-neighbor: quota, rate limit, worker concurrency.
- Security: IDOR, privilege escalation, injection, SSRF, upload abuse, secret leakage.
Không yêu cầu load test quy mô lớn cho mọi commit; nhưng mọi thay đổi ảnh hưởng hot path, query, concurrency, worker hoặc payload phải có benchmark phù hợp.

### Bước 9 – Review, staging và release
- Chạy full CI.
- Review contract compatibility, DB ownership, migration, observability, logs và secrets.
- Deploy staging; chạy smoke test và E2E critical path.
- Có rollback hoặc forward-fix plan.
- Chỉ release khi Tech Lead/QA chấp thuận acceptance evidence.

### Bước 10 – Báo cáo hoàn thành
Agent phải báo cáo:
- Phạm vi đã làm và không làm.
- Danh sách file thay đổi.
- Migration/contract/event thay đổi.
- Lệnh test đã chạy và kết quả thực tế.
- Test chưa chạy và lý do.
- Rủi ro còn lại.
- Hướng dẫn chạy/review.
Không được tuyên bố “all tests pass” nếu không có output thực tế.

---

## 5. Hướng dẫn chuyên biệt theo từng service

### 5.1 Identity Service – P0, nền tảng đầu tiên
**Sở hữu:** `identity.*`  
**Chịu trách nhiệm:** users, organizations, memberships, departments, roles, permissions, sessions.

**Không được làm:**
- Không tin `organization_id` từ request nếu không xác minh membership.
- Không trả dữ liệu user/organization ngoài phạm vi caller.
- Không lưu plaintext password hoặc refresh token.
- Không cho service khác truy vấn trực tiếp bảng identity.
- Không cho phép client tự gán role hoặc permission.

**Backend tests:** password/session lifecycle, refresh rotation, logout/revocation, RBAC matrix, membership suspended/removed, enumeration resistance, rate limit login.

**Frontend tests:** login/logout, session expiry, refresh, organization switch, unauthorized page/action, invite/member role management theo quyền.

**Gate:** 100% negative cross-tenant tests pass; không còn critical/high auth finding; audit log cho thay đổi quyền.

### 5.2 Core Business Service – P0
**Sở hữu:** `core.*`  
**Chịu trách nhiệm:** workspace, module entitlements, tenant limits, business settings.

**Không được làm:**
- Không quyết định entitlement chỉ ở frontend.
- Không cho phép vượt quota bằng cách gọi endpoint trực tiếp.
- Không dùng settings để lưu secret.
- Không đọc identity tables trực tiếp; xác minh qua Identity contract/cache có TTL và invalidation rõ.

**Backend tests:** workspace tenant scoping, entitlement enabled/disabled/expired, quota boundary, concurrent usage update, settings versioning.

**Frontend tests:** workspace create/list/switch, module locked/active state, quota warning, admin-only settings, stale entitlement refresh.

**Gate:** quota/entitlement enforcement server-side; concurrency test không vượt limit ngoài sai số được chấp thuận.

### 5.3 API Gateway / BFF – P0
**Chịu trách nhiệm:** ingress, routing, token verification, rate limit, correlation, response normalization.

**Không được làm:**
- Không chứa domain business logic.
- Không bypass service authorization.
- Không expose private gRPC/NATS/DB/MinIO admin ports.
- Không log Authorization header/body nhạy cảm.

**Tests:** JWT invalid/expired, route permission, rate limit, request size limit, timeout propagation, correlation ID, consistent error response, CORS policy.

**Frontend tests:** refresh token, global error handling, retry chỉ với request an toàn/idempotent, network offline/reconnect.

**Gate:** chỉ public HTTPS ingress; private services không public; gateway không tạo quyền vượt quá quyền backend.

### 5.4 Document Service – P1 sau Identity/Core/Gateway
**Sở hữu:** `document.*`; object bytes tại MinIO qua Storage Adapter.

**Không được làm:**
- Không lưu file binary trong PostgreSQL.
- Không dùng object key có thể đoán hoặc không có tenant namespace.
- Không tin MIME type do browser khai báo; xác minh nội dung.
- Không xử lý OCR/parser đồng bộ trong request.
- Không trả signed URL dài hạn hoặc URL không ràng buộc object/operation.
- Không xóa object trước khi metadata/retention workflow xác nhận.

**Backend tests:** signed upload, object ownership, checksum, max size, MIME sniffing, versioning, duplicate upload, processing retries, malware-scan hook, soft delete/retention, MinIO outage.

**Frontend tests:** upload progress, cancel/retry, unsupported file, oversize, duplicate, processing state, preview/download permission, deleted/expired state.

**Gate:** upload/download chỉ đúng tenant; checksum và metadata được xác minh; job retry idempotent; file delete lifecycle được kiểm chứng.

### 5.5 AI Engine Service – P1
**Sở hữu:** `ai.*`  
**Chịu trách nhiệm:** provider/model registry, prompt versions, generation, embedding, usage/cost.

**Không được làm:**
- Không gọi AI provider trực tiếp từ frontend hoặc service nghiệp vụ.
- Không hardcode API keys; chỉ dùng secret reference.
- Không gửi dữ liệu cá nhân/nhạy cảm tới provider nếu chưa có căn cứ, cấu hình và thỏa thuận phù hợp.
- Không mặc định model output là sự thật hoặc cho phép tự động quyết định nghiệp vụ rủi ro cao.
- Không retry vô hạn; không retry request không idempotent nếu có side effect.
- Không ghi raw prompt/output nhạy cảm vào log.

**Backend tests:** provider timeout, quota, model fallback policy, token/cost metering, prompt version pinning, malformed output, rate limit, circuit breaker, provider unavailable.

**Frontend tests:** streaming/loading, cancel, timeout, retry, quota reached, citation rendering khi dùng RAG, phân biệt generated content với dữ liệu nguồn.

**Gate:** mọi request có tenant/user/purpose; quota và usage metering hoạt động; secrets không lộ; fallback theo policy; có evaluation set.

### 5.6 Knowledge Service – P1, phụ thuộc Document + AI + Identity
**Sở hữu:** `knowledge.*`  
**Chịu trách nhiệm:** knowledge bases, sources, chunks, indexing, search.

**Không được làm:**
- Không index document chưa được xác minh quyền đọc.
- Không truy xuất vector trước rồi mới lọc tenant/ACL ở frontend.
- Không trả chunk/source vượt quyền.
- Không giữ bản sao dữ liệu đã xóa quá retention policy.
- Không coi vector similarity là authorization.

**Backend tests:** tenant/ACL filtering trước retrieval, indexing idempotency, source versioning, deletion propagation, empty/no-match, embedding model mismatch, hybrid search ranking.

**Frontend tests:** tạo KB, thêm/bỏ nguồn, indexing progress/failure, search result citations, permission-denied, source deleted, empty result.

**Gate:** adversarial cross-tenant retrieval = 0; citations map tới source/version được phép; xóa nguồn được truyền tới index và cache.

### 5.7 Workflow Service – P1
**Sở hữu:** `workflow.*`  
**Chịu trách nhiệm:** definitions, immutable versions, runs, tasks, transitions, audit.

**Không được làm:**
- Không sửa workflow version đã publish; tạo version mới.
- Không cho AI tự approve/reject tác vụ quan trọng nếu không có human authorization policy rõ.
- Không cho client tự quyết định actor identity.
- Không xử lý duplicate event làm task/approval lặp.
- Không bỏ qua state transition validation.

**Backend tests:** state machine, immutable version, idempotent start/complete, concurrent approval, permission matrix, due date/escalation, replay event, audit completeness.

**Frontend tests:** task inbox, detail, approve/reject confirmation, stale task, already completed, unauthorized task, comment validation, optimistic UI rollback.

**Gate:** transition hợp lệ; mọi action có actor/time/audit; duplicate command không tạo side effect lần hai.

### 5.8 Integration Service – P1
**Sở hữu:** `integration.*`  
**Chịu trách nhiệm:** webhooks, notifications, connectors metadata.

**Không được làm:**
- Không cho webhook gọi địa chỉ nội bộ/private IP; chống SSRF và DNS rebinding.
- Không gửi secret trong payload/log.
- Không coi HTTP 2xx là đủ nếu contract đòi chữ ký/response validation.
- Không retry vô hạn hoặc retry ngay không backoff.
- Không lưu connector credentials dạng plaintext.

**Backend tests:** HMAC signature, timestamp/replay protection, SSRF blocklist/allowlist, DNS resolution checks, timeout, retry/backoff, DLQ, duplicate event, secret rotation.

**Frontend tests:** webhook create/edit/pause, endpoint validation, secret shown once, delivery history, retry action permission, notification preferences/read state.

**Gate:** webhook delivery signed, retry bounded, DLQ observable; SSRF tests pass; credentials chỉ lưu secret reference.

### 5.9 Frontend Web App – phát triển theo vertical slice
**Nguyên tắc:** mỗi chức năng frontend phải gắn với API contract và backend đã có hoặc đang được phát triển cùng sprint. Không tạo UI giả như đã hoàn thành.

**Bắt buộc:**
- Typed API client; không duplicate schema thủ công nếu có code generation.
- Auth/tenant context tập trung; không tự gán tenant.
- Permission-aware navigation và component; backend vẫn enforce.
- Mỗi form có validation, loading, success, error, empty, disabled state.
- Mỗi mutation có xử lý duplicate submit và lỗi mạng.
- E2E chạy trên staging/test với backend thật.
- Accessibility cơ bản: keyboard navigation, label, focus, contrast.
- Không lưu token dài hạn trong localStorage nếu auth architecture đã chọn cơ chế cookie httpOnly; tuân theo ADR auth.

**Gate:** mỗi vertical slice có unit/component test, API integration test và ít nhất một E2E critical path.

---

## 6. Bộ test tối thiểu theo từng tầng

| Tầng | Công cụ gợi ý | Bắt buộc kiểm tra |
|---|---|---|
| Backend unit | pytest / Jest | Domain rules, validation, error mapping |
| Repository/integration | Testcontainers | PostgreSQL constraints, transactions, migration |
| API contract | Schemathesis / Dredd / generated tests | Request/response đúng OpenAPI |
| gRPC contract | buf breaking + integration tests | Proto compatibility, deadlines, auth metadata |
| Event contract | JSON Schema validator | Schema validation, unknown optional fields |
| Event reliability | NATS test container | Duplicate, replay, ACK, retry, DLQ |
| Frontend unit/component | Vitest/Jest + Testing Library | State, form, permission rendering |
| E2E | Playwright | UI → Gateway → service → DB/queue/object storage |
| Performance | k6 / Locust | p95/p99, throughput, concurrency, error rate |
| Security | Semgrep, dependency/container scan, DAST | SAST, dependency CVE, authz, SSRF, IDOR |
| Operations | Restore drill, smoke tests | Backup/restore, deployment, rollback |

**Test không được bỏ qua:** cross-tenant access, permission escalation, duplicate request/event, service dependency outage, migration upgrade, frontend E2E critical path.

---

## 7. Definition of Ready (DoR) – trước khi agent bắt đầu

Một ticket chỉ được nhận khi có:
- Service owner và người phê duyệt.
- Mô tả nghiệp vụ và user role.
- Acceptance criteria có thể kiểm thử.
- API/proto/event contract hoặc xác nhận không thay đổi contract.
- Data owner/schema và tenant scope.
- Dependencies đã qua gate.
- UI state hoặc mô tả UX nếu có frontend.
- Test environment/dataset phù hợp.
- Phạm vi không làm và rủi ro đã nêu.

Nếu thiếu điều kiện P0/P1, agent phải báo “BLOCKED – NEED CLARIFICATION”, không tự phát triển.

## 8. Definition of Done (DoD) – trước khi đóng ticket

- [ ] Đúng service owner và database ownership.
- [ ] Không phá kiến trúc hoặc dependency order.
- [ ] Contract được cập nhật, version và compatibility được kiểm tra.
- [ ] Migration chạy được trên DB mới và upgrade từ version trước.
- [ ] Unit + integration + contract tests pass.
- [ ] Tenant isolation và RBAC negative tests pass.
- [ ] Frontend component/API integration/E2E tests pass nếu có UI.
- [ ] Loading, empty, success, error, forbidden và retry states được xử lý.
- [ ] Logs/metrics/traces có correlation nhưng không lộ dữ liệu nhạy cảm.
- [ ] Timeout/retry/idempotency/DLQ được định nghĩa khi cần.
- [ ] Không có secret hoặc mock production path.
- [ ] CI pass; staging smoke test pass.
- [ ] Có rollback/forward-fix plan và runbook nếu thay đổi vận hành.
- [ ] Agent gửi báo cáo bằng chứng test và rủi ro còn lại.

---

## 9. Mẫu prompt điều phối AI coding agent

### 9.1 System/project instruction dùng chung

> Bạn là AI coding agent trong dự án Core Platform. Tuân thủ tuyệt đối `AI_Agent_Coding_Governance_v1.md`, Technical Specification v2, Engineering Implementation Package v1 và các ADR được duyệt. Không tự ý thay đổi service boundary, database ownership, tenant model, API/gRPC/event contract, technology stack hoặc thứ tự dependency. Làm theo ticket được giao, trước khi code phải đưa implementation plan và test plan. Implement backend trước, kiểm thử backend, sau đó implement frontend và chạy E2E UI→API→DB/queue/object storage. Không tuyên bố hoàn thành khi chưa có test output. Nếu yêu cầu mâu thuẫn hoặc thiếu thông tin P0/P1, dừng và báo BLOCKED.

### 9.2 Prompt giao việc theo service

> **Service:** [SERVICE_NAME]  
> **Ticket:** [TICKET_ID]  
> **Mục tiêu:** [BUSINESS_OUTCOME]  
> **In-scope:** [EXACT_SCOPE]  
> **Out-of-scope:** [EXPLICIT_EXCLUSIONS]  
> **Dependencies đã nghiệm thu:** [DEPENDENCIES]  
> **Contracts:** [OPENAPI/PROTO/EVENT REFERENCES]  
> **Database owner/schema:** [OWNER/SCHEMA]  
> **Acceptance criteria:** [TESTABLE_CRITERIA]  
> **Frontend flow:** [UI_STATES_AND_USER_ROLE]  
> **Bắt buộc:** đọc governance và ADR; báo plan trước khi code; chạy baseline tests; backend trước frontend; test tenant isolation/RBAC; chạy integration và E2E; báo cáo file thay đổi, lệnh test, kết quả thực tế, test chưa chạy, rủi ro. Không mở rộng phạm vi hoặc tự thay contract.

### 9.3 Prompt yêu cầu sửa lỗi

> Tái hiện lỗi bằng test trước khi sửa. Xác định root cause và phạm vi ảnh hưởng. Không thay đổi public contract hoặc schema nếu không cần thiết. Viết regression test chứng minh lỗi trước khi fix và pass sau khi fix. Chạy toàn bộ test liên quan backend/frontend/E2E. Báo rõ lỗi baseline, lỗi mới, kết quả và nguy cơ regression.

### 9.4 Prompt yêu cầu review code

> Review theo thứ tự P0→P4. Ưu tiên tenant isolation, authorization, data integrity, secret handling, database ownership, event idempotency, contract compatibility, failure handling, test coverage và frontend state correctness. Không chỉ nhận xét style. Mỗi finding phải có severity, file/line, kịch bản khai thác hoặc tái hiện, tác động và đề xuất sửa. Không tự sửa nếu chưa được giao.

---

## 10. Quy tắc quản lý thay đổi kiến trúc

Mọi thay đổi sau đây bắt buộc có Architecture Decision Record (ADR) và Tech Lead phê duyệt:
- Tách/gộp service hoặc đổi service boundary.
- Thêm database, schema owner hoặc cho phép cross-service data access.
- Đổi MinIO/object storage, NATS, gRPC, PostgreSQL, Redis hoặc framework nền tảng.
- Đổi tenant isolation, auth model, RBAC hoặc secret management.
- Thay đổi event semantics, subject/version hoặc breaking API/proto.
- Đổi deployment topology, network exposure, data residency hoặc retention.
- Thay đổi yêu cầu performance/SLO hoặc chi phí vận hành đáng kể.

Agent phải mô tả: bối cảnh, lựa chọn, ưu/nhược, chi phí, migration/rollback, security/privacy impact, compatibility và test evidence.

---

## 11. Release gates và chỉ số tối thiểu

Các mục tiêu sau là baseline để xác nhận bằng đo kiểm, không phải cam kết tải mặc định cho mọi môi trường:

- API non-AI p95 ≤ 500 ms trong workload pilot đã định nghĩa.
- API non-AI p99 ≤ 1.000 ms trong workload pilot đã định nghĩa.
- HTTP 5xx < 0,5% trong bài test tải ổn định.
- Cross-tenant data leakage: 0.
- Critical/high security findings: 0 trước pilot.
- Event consumer: duplicate/replay không gây duplicate business side effect.
- Backup/restore: có biên bản test, RPO/RTO đo được và được chủ sản phẩm chấp thuận.
- AI latency/cost được đo riêng, không gộp với API latency.
- Mọi service có health/readiness, structured logs, metrics, traces và runbook.

Nếu chưa đạt, phát hành trạng thái **NOT READY** kèm evidence và remediation plan; không hạ tiêu chí để đánh dấu hoàn thành.

---

## 12. Checklist bắt buộc trước mỗi lần merge

- [ ] Ticket và acceptance criteria đúng phạm vi.
- [ ] Không sửa service/schema ngoài quyền sở hữu.
- [ ] Không có direct DB access xuyên service.
- [ ] Tenant scope được xác minh ở backend.
- [ ] AuthZ được kiểm tra cho mọi mutation và resource.
- [ ] API/proto/event compatibility được kiểm tra.
- [ ] Migration và index đã được review.
- [ ] Retry/deadline/idempotency được xác định.
- [ ] Backend tests pass.
- [ ] Frontend tests pass nếu UI bị ảnh hưởng.
- [ ] E2E critical flow pass.
- [ ] Không có secret/PII trong logs hoặc source.
- [ ] CI, staging smoke test pass.
- [ ] Báo cáo test và rủi ro được đính kèm PR.

---

## 13. Lưu ý pháp lý và dữ liệu tại Việt Nam

AI agent không được tự đưa ra kết luận pháp lý. Với chức năng xử lý dữ liệu cá nhân, dữ liệu nhân sự, tài chính, khách hàng hoặc tài liệu nội bộ:
- Chỉ thu thập/xử lý theo mục đích, phạm vi, căn cứ và thời hạn lưu trữ đã được chủ dự án phê duyệt.
- Phân định vai trò bên kiểm soát/bên xử lý dữ liệu và nhà cung cấp phụ; có thỏa thuận xử lý dữ liệu phù hợp.
- Kiểm soát chuyển dữ liệu ra nước ngoài khi sử dụng AI/cloud provider; đánh giá yêu cầu pháp luật hiện hành trước triển khai.
- Hỗ trợ truy cập, chỉnh sửa, xóa, export và retention theo chính sách đã duyệt.
- Không đưa dữ liệu thật của khách hàng vào môi trường dev/test nếu chưa được phép và chưa khử định danh.
- Dùng synthetic data cho kiểm thử mặc định.
- Rà soát luật hiện hành về bảo vệ dữ liệu cá nhân, an ninh mạng, an toàn thông tin, giao dịch điện tử, sở hữu trí tuệ và quy định chuyên ngành. Cần tư vấn pháp lý Việt Nam trước pilot thương mại.

---

## 14. Tuyên bố vận hành

Tài liệu này là governance baseline cho AI coding agents. Nó không thay thế Technical Specification, ADR, ticket hoặc phê duyệt của Tech Lead. Khi tài liệu mâu thuẫn, thứ tự xử lý là: pháp luật và yêu cầu bảo mật bắt buộc → ADR/kiến trúc đã duyệt → Technical Specification mới nhất → Engineering Implementation Package mới nhất → ticket. Agent phải dừng và xin xác nhận khi có xung đột, không tự diễn giải để tiếp tục.


---

## PHỤ LỤC BẮT BUỘC – AI DATA PROTECTION & SECURITY HARNESS

**Quy tắc dữ liệu:** Không đưa dữ liệu nội bộ nhạy cảm, dữ liệu khách hàng/cá nhân, hợp đồng, source code riêng, production logs/dumps, dữ liệu tài chính/nhân sự chưa công khai, credential, token, API key hoặc private key lên public AI/AI coding agent. Coding agent chỉ được dùng C0 và C1 đã được owner phê duyệt, tối thiểu hóa. Không rõ phân loại thì mặc định C2 và BLOCK.

| Lớp | Mô tả | Quy tắc |
|---|---|---|
| C0 Public | Công khai/synthetic | Qua AI Gateway được duyệt |
| C1 Internal non-sensitive | Nội bộ không nhạy cảm/không định danh | Chỉ sau owner approval + DLP + minimization |
| C2 Confidential | Source code riêng, hợp đồng, dữ liệu khách hàng, kế hoạch nội bộ | Cấm external AI và coding agent |
| C3 Restricted | Secrets, production dump, dữ liệu cá nhân nhạy cảm | Cấm external AI và agent thông thường |

**Harness bắt buộc:** Mọi LLM, embedding, reranker, OCR-to-LLM, RAG và agent tool call phải qua AI Security Harness trong AI Engine. Cấm gọi trực tiếp provider SDK từ frontend/business service. Harness thực thi identity/tenant/purpose, classification, DLP, secret/PII scan, redaction, retrieval ACL, provider/model allowlist, tool allowlist/sandbox, output validation và metadata-only audit. Kết quả: ALLOW, REDACT_AND_ALLOW, BLOCK, HUMAN_APPROVAL. DLP/policy/ACL/provider verification lỗi thì fail-closed.

**Release gates:** C2/C3 block trước egress; secret canary không đến provider; DLP outage fail-closed; cross-tenant ACL; prompt-injection; provider allowlist; direct egress denied; sandbox; metadata-only logs; deletion propagation.

**Agent directive:** Nếu không rõ phân loại hoặc task cần dữ liệu nhạy cảm, dừng và trả `BLOCKED — DATA CLASSIFICATION / SECURITY APPROVAL REQUIRED`. Không bypass Harness, DLP, tenant ACL, egress controls hoặc approval. Security policy ưu tiên hơn hoàn thành ticket.

Chi tiết: `docs/security/AI_Data_Protection_and_Security_Harness_Policy_v1.md`.


## PHỤ LỤC NGHIỆM THU BẢO MẬT AI – BẮT BUỘC

Mọi thay đổi liên quan AI Engine, AI Gateway, DLP, RAG, OCR, provider adapter hoặc agent tools phải chạy bộ test `APP-AI-SEC-ACCEPTANCE` trong `docs/security/AI_Data_Protection_and_Security_Harness_Policy_v1.md` (SEC-001 đến SEC-015). Release bị BLOCK nếu có Canary C2/C3 trong outbound payload, có đường bypass Harness, fail-open khi policy dependency lỗi, rò rỉ cross-tenant hoặc raw sensitive payload trong telemetry. Kết quả phải có bằng chứng độc lập từ Harness audit, egress firewall, Provider Mock và Security Verifier; AI agent không được tự nghiệm thu thay đổi của chính nó.


## V2.2 Mandatory Baseline Override
**V2.2 supersedes V2.1.** Before coding, read `architecture/Core_Platform_Technical_Specification_V2.2.md`, all accepted ADRs, security policy addendum, control-plane SQL/proto and `implementation/backlog/v2.2-implementation-backlog.md`. Do not continue from V2.1 assumptions.

### Agent prohibitions
- Never bypass AI Security Harness, Security Policy Registry, server-side ACL, lineage, quota or approval.
- Never trust caller-supplied tenant, classification, `external_ai_allowed`, policy decision or RAG `allowed_resource_ids`.
- Never call AI providers directly from domain services, workers, cron or frontend; provider egress is restricted to approved AI Gateway.
- Never create cross-service foreign keys or direct cross-schema runtime DB access.
- Never lower classification or widen ACL on derived data.
- Never write prompts, OCR, retrieved chunks, secrets or raw sensitive content to telemetry.
- Never implement fallback without fresh policy revalidation and equivalent-or-stricter provider policy.
- Never bypass quota reservation or create non-idempotent retries for billable operations.

### Required implementation sequence
1. Freeze and inspect V2.1 code/schema/config; document gaps before modifying.
2. Implement trusted context, authorization, Harness and egress controls (P0).
3. Implement Policy Registry and server-side decision/revalidation.
4. Implement lineage, classification/ACL inheritance and deletion propagation.
5. Implement quota reservation, ledger and reconciliation.
6. Implement timeouts, retry, circuit breaker, bulkheads, DLQ and approved fallback.
7. Add telemetry, dashboards, CI security scans, backup/restore and runbooks.
8. Run relevant SEC-001…SEC-025, contract, migration, tenant-isolation, outage, idempotency and chaos tests.
9. Obtain independent human security review; the implementing agent cannot approve its own security work.
10. Report exact commands, test outputs, evidence, migration/rollback plan and residual risks.

### Definition of done
No task is complete without tests and evidence, updated docs/contracts, migration safety, rollback notes, observability and human review for security-sensitive changes. Agent self-report is not evidence.
