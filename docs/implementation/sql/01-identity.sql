CREATE TABLE identity.users (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 email_normalized text NOT NULL UNIQUE,
 display_name text NOT NULL,
 status text NOT NULL DEFAULT 'active' CHECK (status IN ('active','invited','suspended','deleted')),
 password_hash_ref text,
 created_at timestamptz NOT NULL DEFAULT now(),
 updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE identity.organizations (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 name text NOT NULL, slug text NOT NULL UNIQUE,
 status text NOT NULL DEFAULT 'active' CHECK (status IN ('active','suspended','closed')),
 created_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE identity.memberships (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 user_id uuid NOT NULL REFERENCES identity.users(id),
 status text NOT NULL DEFAULT 'active' CHECK (status IN ('invited','active','suspended','removed')),
 joined_at timestamptz, created_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(organization_id,user_id)
);
CREATE INDEX ix_memberships_user ON identity.memberships(user_id,status);
CREATE TABLE identity.departments (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 parent_id uuid REFERENCES identity.departments(id),
 name text NOT NULL, status text NOT NULL DEFAULT 'active',
 UNIQUE(organization_id,name)
);
CREATE TABLE identity.roles (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid REFERENCES identity.organizations(id),
 role_key text NOT NULL, name text NOT NULL, is_system boolean NOT NULL DEFAULT false,
 UNIQUE(organization_id,role_key)
);
CREATE TABLE identity.permissions (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 permission_key text NOT NULL UNIQUE, description text
);
CREATE TABLE identity.role_permissions (
 role_id uuid REFERENCES identity.roles(id) ON DELETE CASCADE,
 permission_id uuid REFERENCES identity.permissions(id) ON DELETE CASCADE,
 PRIMARY KEY(role_id,permission_id)
);
CREATE TABLE identity.membership_roles (
 membership_id uuid REFERENCES identity.memberships(id) ON DELETE CASCADE,
 role_id uuid REFERENCES identity.roles(id) ON DELETE CASCADE,
 PRIMARY KEY(membership_id,role_id)
);
CREATE TABLE identity.user_sessions (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 user_id uuid NOT NULL REFERENCES identity.users(id),
 refresh_token_hash text NOT NULL, expires_at timestamptz NOT NULL,
 revoked_at timestamptz, created_at timestamptz NOT NULL DEFAULT now()
);
