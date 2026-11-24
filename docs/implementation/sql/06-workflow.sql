CREATE TABLE workflow.workflow_definitions (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 workflow_key text NOT NULL, name text NOT NULL,
 status text NOT NULL DEFAULT 'draft' CHECK(status IN ('draft','published','archived')),
 created_at timestamptz NOT NULL DEFAULT now(), UNIQUE(organization_id,workflow_key)
);
CREATE TABLE workflow.workflow_versions (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 definition_id uuid NOT NULL REFERENCES workflow.workflow_definitions(id),
 version integer NOT NULL, definition_json jsonb NOT NULL,
 published_at timestamptz, created_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(definition_id,version)
);
CREATE TABLE workflow.workflow_runs (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 workflow_version_id uuid NOT NULL REFERENCES workflow.workflow_versions(id),
 business_ref text, status text NOT NULL DEFAULT 'running'
 CHECK(status IN ('running','waiting','completed','failed','cancelled')),
 input_json jsonb NOT NULL DEFAULT '{}'::jsonb, started_at timestamptz NOT NULL DEFAULT now(),
 finished_at timestamptz, idempotency_key text NOT NULL, UNIQUE(organization_id,idempotency_key)
);
CREATE INDEX ix_workflow_runs_status ON workflow.workflow_runs(organization_id,status,started_at DESC);
CREATE TABLE workflow.workflow_tasks (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 run_id uuid NOT NULL REFERENCES workflow.workflow_runs(id) ON DELETE CASCADE,
 assignee_user_id uuid REFERENCES identity.users(id), task_type text NOT NULL,
 status text NOT NULL DEFAULT 'pending'
 CHECK(status IN ('pending','in_progress','completed','rejected','cancelled')),
 due_at timestamptz, task_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
 created_at timestamptz NOT NULL DEFAULT now(), completed_at timestamptz
);
CREATE INDEX ix_workflow_task_inbox ON workflow.workflow_tasks(organization_id,assignee_user_id,status,due_at);
CREATE TABLE workflow.task_events (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 task_id uuid NOT NULL REFERENCES workflow.workflow_tasks(id) ON DELETE CASCADE,
 event_type text NOT NULL, actor_user_id uuid,
 payload_json jsonb NOT NULL DEFAULT '{}'::jsonb, occurred_at timestamptz NOT NULL DEFAULT now()
);
