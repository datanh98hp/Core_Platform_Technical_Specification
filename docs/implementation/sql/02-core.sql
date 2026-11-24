CREATE TABLE core.workspaces (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 name text NOT NULL, status text NOT NULL DEFAULT 'active',
 created_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(organization_id,name)
);
CREATE INDEX ix_workspaces_org ON core.workspaces(organization_id);
CREATE TABLE core.module_entitlements (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 module_key text NOT NULL, enabled boolean NOT NULL DEFAULT false,
 limits_json jsonb NOT NULL DEFAULT '{}'::jsonb, valid_until timestamptz,
 updated_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(organization_id,module_key)
);
CREATE TABLE core.business_settings (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 workspace_id uuid REFERENCES core.workspaces(id),
 setting_key text NOT NULL, value_json jsonb NOT NULL DEFAULT '{}'::jsonb,
 version integer NOT NULL DEFAULT 1, updated_by uuid, updated_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(organization_id,workspace_id,setting_key)
);
