-- V2.2 control-plane baseline. Review against live schema before applying.
-- No cross-service foreign keys. Tenant/resource UUIDs are validated via owning services.
BEGIN;
CREATE SCHEMA IF NOT EXISTS security;
CREATE SCHEMA IF NOT EXISTS lineage;
CREATE SCHEMA IF NOT EXISTS governance;
CREATE SCHEMA IF NOT EXISTS resilience;

CREATE TABLE IF NOT EXISTS security.policy_versions (
  policy_id UUID NOT NULL,
  version INTEGER NOT NULL CHECK (version > 0),
  tenant_id UUID NULL,
  scope TEXT NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('DRAFT','REVIEW','APPROVED','ACTIVE','SUPERSEDED','REVOKED')),
  policy_document JSONB NOT NULL,
  content_hash TEXT NOT NULL,
  effective_from TIMESTAMPTZ,
  effective_until TIMESTAMPTZ,
  created_by UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (policy_id, version)
);
CREATE UNIQUE INDEX IF NOT EXISTS uq_policy_active_scope
  ON security.policy_versions (COALESCE(tenant_id,'00000000-0000-0000-0000-000000000000'::uuid), scope)
  WHERE status='ACTIVE';
CREATE TABLE IF NOT EXISTS security.policy_approvals (
  approval_id UUID PRIMARY KEY,
  policy_id UUID NOT NULL,
  policy_version INTEGER NOT NULL,
  reviewer_id UUID NOT NULL,
  decision TEXT NOT NULL CHECK (decision IN ('APPROVE','REJECT')),
  reason TEXT NOT NULL,
  decided_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS security.policy_decisions (
  decision_id UUID PRIMARY KEY,
  tenant_id UUID NOT NULL,
  actor_id UUID NOT NULL,
  purpose TEXT NOT NULL,
  resource_refs JSONB NOT NULL DEFAULT '[]'::jsonb,
  classification TEXT NOT NULL CHECK (classification IN ('C0','C1','C2','C3','UNKNOWN')),
  decision TEXT NOT NULL CHECK (decision IN ('ALLOW','DENY','REQUIRE_APPROVAL')),
  reason_code TEXT NOT NULL,
  policy_id UUID NOT NULL,
  policy_version INTEGER NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL,
  correlation_id UUID NOT NULL,
  decided_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS ix_policy_decisions_tenant_time ON security.policy_decisions(tenant_id, decided_at DESC);

CREATE TABLE IF NOT EXISTS lineage.nodes (
  node_id UUID PRIMARY KEY,
  tenant_id UUID NOT NULL,
  resource_type TEXT NOT NULL,
  resource_id UUID NOT NULL,
  parent_fingerprint TEXT,
  classification TEXT NOT NULL CHECK (classification IN ('C0','C1','C2','C3','UNKNOWN')),
  acl_version TEXT NOT NULL,
  policy_id UUID,
  policy_version INTEGER,
  content_fingerprint TEXT,
  storage_ref TEXT,
  processor TEXT,
  processor_version TEXT,
  retention_class TEXT,
  deletion_state TEXT NOT NULL DEFAULT 'ACTIVE' CHECK (deletion_state IN ('ACTIVE','PENDING_DELETE','DELETED','LEGAL_HOLD','FAILED')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  deleted_at TIMESTAMPTZ,
  UNIQUE (tenant_id, resource_type, resource_id)
);
CREATE INDEX IF NOT EXISTS ix_lineage_nodes_tenant_resource ON lineage.nodes(tenant_id, resource_id);
CREATE TABLE IF NOT EXISTS lineage.edges (
  edge_id UUID PRIMARY KEY,
  tenant_id UUID NOT NULL,
  parent_node_id UUID NOT NULL,
  child_node_id UUID NOT NULL,
  transformation TEXT NOT NULL,
  provenance JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (tenant_id, parent_node_id, child_node_id, transformation)
);
CREATE INDEX IF NOT EXISTS ix_lineage_edges_parent ON lineage.edges(tenant_id, parent_node_id);
CREATE INDEX IF NOT EXISTS ix_lineage_edges_child ON lineage.edges(tenant_id, child_node_id);
CREATE TABLE IF NOT EXISTS lineage.deletion_jobs (
  job_id UUID PRIMARY KEY,
  tenant_id UUID NOT NULL,
  root_node_id UUID NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('QUEUED','RUNNING','COMPLETED','PARTIAL','FAILED')),
  requested_by UUID NOT NULL,
  reason TEXT NOT NULL,
  attempts INTEGER NOT NULL DEFAULT 0,
  last_error_code TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  completed_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS governance.quota_policies (
  quota_policy_id UUID PRIMARY KEY,
  tenant_id UUID NOT NULL,
  scope_type TEXT NOT NULL CHECK (scope_type IN ('TENANT','USER','MODULE','MODEL','PROVIDER')),
  scope_key TEXT NOT NULL,
  metric TEXT NOT NULL,
  soft_limit NUMERIC(20,6),
  hard_limit NUMERIC(20,6) NOT NULL CHECK (hard_limit >= 0),
  burst_limit NUMERIC(20,6),
  window_seconds INTEGER NOT NULL CHECK (window_seconds > 0),
  policy_id UUID NOT NULL,
  policy_version INTEGER NOT NULL,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS governance.usage_reservations (
  reservation_id UUID PRIMARY KEY,
  tenant_id UUID NOT NULL,
  actor_id UUID NOT NULL,
  idempotency_key TEXT NOT NULL,
  request_id UUID NOT NULL,
  metric TEXT NOT NULL,
  reserved_amount NUMERIC(20,6) NOT NULL CHECK (reserved_amount >= 0),
  status TEXT NOT NULL CHECK (status IN ('RESERVED','RECONCILED','RELEASED','EXPIRED')),
  expires_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (tenant_id, idempotency_key)
);
CREATE TABLE IF NOT EXISTS governance.usage_ledger (
  usage_id UUID PRIMARY KEY,
  tenant_id UUID NOT NULL,
  actor_id UUID NOT NULL,
  module TEXT NOT NULL,
  feature TEXT NOT NULL,
  provider TEXT,
  model TEXT,
  request_id UUID NOT NULL,
  reservation_id UUID,
  idempotency_key TEXT NOT NULL,
  usage_type TEXT NOT NULL,
  quantity NUMERIC(20,6) NOT NULL,
  estimated_cost NUMERIC(20,8),
  actual_cost NUMERIC(20,8),
  currency CHAR(3) NOT NULL,
  rate_card_version TEXT,
  source TEXT NOT NULL,
  reconciliation_status TEXT NOT NULL CHECK (reconciliation_status IN ('ESTIMATED','RECONCILED','DISPUTED')),
  occurred_at TIMESTAMPTZ NOT NULL,
  recorded_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (tenant_id, idempotency_key, usage_type)
);
CREATE INDEX IF NOT EXISTS ix_usage_ledger_tenant_time ON governance.usage_ledger(tenant_id, occurred_at DESC);
CREATE TABLE IF NOT EXISTS governance.rate_cards (
  rate_card_id UUID PRIMARY KEY,
  provider TEXT NOT NULL,
  model TEXT NOT NULL,
  usage_type TEXT NOT NULL,
  unit_price NUMERIC(20,10) NOT NULL CHECK (unit_price >= 0),
  currency CHAR(3) NOT NULL,
  version TEXT NOT NULL,
  effective_from TIMESTAMPTZ NOT NULL,
  effective_until TIMESTAMPTZ,
  UNIQUE (provider, model, usage_type, version)
);

CREATE TABLE IF NOT EXISTS resilience.circuit_states (
  circuit_key TEXT PRIMARY KEY,
  provider TEXT NOT NULL,
  model TEXT,
  operation TEXT NOT NULL,
  state TEXT NOT NULL CHECK (state IN ('CLOSED','OPEN','HALF_OPEN')),
  failure_count INTEGER NOT NULL DEFAULT 0,
  success_count INTEGER NOT NULL DEFAULT 0,
  opened_at TIMESTAMPTZ,
  next_probe_at TIMESTAMPTZ,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  config JSONB NOT NULL DEFAULT '{}'::jsonb
);
CREATE TABLE IF NOT EXISTS resilience.provider_health_events (
  event_id UUID PRIMARY KEY,
  provider TEXT NOT NULL,
  model TEXT,
  operation TEXT NOT NULL,
  outcome TEXT NOT NULL,
  latency_ms INTEGER,
  error_code TEXT,
  correlation_id UUID NOT NULL,
  occurred_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Runtime roles should receive schema-scoped least privilege; do not grant broad cross-schema access.
COMMIT;
