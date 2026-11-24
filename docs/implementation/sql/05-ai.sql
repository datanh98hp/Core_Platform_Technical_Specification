CREATE TABLE ai.providers (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(), provider_key text NOT NULL UNIQUE,
 display_name text NOT NULL, enabled boolean NOT NULL DEFAULT true,
 secret_ref text, config_json jsonb NOT NULL DEFAULT '{}'::jsonb,
 created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE ai.models (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 provider_id uuid NOT NULL REFERENCES ai.providers(id), model_key text NOT NULL,
 capabilities_json jsonb NOT NULL DEFAULT '{}'::jsonb, enabled boolean NOT NULL DEFAULT true,
 UNIQUE(provider_id,model_key)
);
CREATE TABLE ai.prompt_templates (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(), prompt_key text NOT NULL UNIQUE,
 description text, created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE ai.prompt_versions (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 prompt_template_id uuid NOT NULL REFERENCES ai.prompt_templates(id),
 version integer NOT NULL, content text NOT NULL,
 variables_json jsonb NOT NULL DEFAULT '{}'::jsonb,
 status text NOT NULL DEFAULT 'draft' CHECK(status IN ('draft','published','retired')),
 created_at timestamptz NOT NULL DEFAULT now(), UNIQUE(prompt_template_id,version)
);
CREATE TABLE ai.ai_requests (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 user_id uuid REFERENCES identity.users(id), model_id uuid REFERENCES ai.models(id),
 prompt_version_id uuid REFERENCES ai.prompt_versions(id), purpose text NOT NULL,
 status text NOT NULL DEFAULT 'queued' CHECK(status IN ('queued','running','completed','failed','cancelled')),
 latency_ms integer, input_tokens integer, output_tokens integer, error_code text,
 created_at timestamptz NOT NULL DEFAULT now(), finished_at timestamptz
);
CREATE INDEX ix_ai_requests_tenant ON ai.ai_requests(organization_id,created_at DESC);
CREATE TABLE ai.ai_usage_records (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 request_id uuid NOT NULL UNIQUE REFERENCES ai.ai_requests(id),
 input_tokens integer NOT NULL DEFAULT 0, output_tokens integer NOT NULL DEFAULT 0,
 cost_estimate numeric(18,8) NOT NULL DEFAULT 0, currency char(3) NOT NULL DEFAULT 'USD',
 recorded_at timestamptz NOT NULL DEFAULT now()
);
