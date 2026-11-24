CREATE TABLE integration.connectors (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 provider text NOT NULL, display_name text NOT NULL,
 status text NOT NULL DEFAULT 'pending' CHECK(status IN ('pending','active','disabled','error')),
 secret_ref text, config_json jsonb NOT NULL DEFAULT '{}'::jsonb,
 created_at timestamptz NOT NULL DEFAULT now(), updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE integration.webhook_subscriptions (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 target_url text NOT NULL, secret_ref text NOT NULL,
 event_filter jsonb NOT NULL DEFAULT '[]'::jsonb,
 status text NOT NULL DEFAULT 'active' CHECK(status IN ('active','paused','disabled')),
 created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE integration.webhook_deliveries (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 subscription_id uuid NOT NULL REFERENCES integration.webhook_subscriptions(id),
 event_id uuid NOT NULL, status text NOT NULL DEFAULT 'pending'
 CHECK(status IN ('pending','delivered','retrying','failed')),
 attempts integer NOT NULL DEFAULT 0, next_attempt_at timestamptz,
 response_status integer, last_error_code text, created_at timestamptz NOT NULL DEFAULT now(),
 delivered_at timestamptz, UNIQUE(subscription_id,event_id)
);
CREATE INDEX ix_webhook_retry ON integration.webhook_deliveries(status,next_attempt_at);
CREATE TABLE integration.notifications (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 recipient_user_id uuid NOT NULL REFERENCES identity.users(id),
 channel text NOT NULL CHECK(channel IN ('in_app','email','sms','push')),
 template_key text NOT NULL, variables_json jsonb NOT NULL DEFAULT '{}'::jsonb,
 status text NOT NULL DEFAULT 'queued' CHECK(status IN ('queued','sent','failed','read','cancelled')),
 created_at timestamptz NOT NULL DEFAULT now(), sent_at timestamptz, read_at timestamptz
);
CREATE INDEX ix_notification_inbox ON integration.notifications(organization_id,recipient_user_id,status,created_at DESC);
