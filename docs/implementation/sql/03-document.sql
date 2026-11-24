CREATE TABLE document.documents (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 workspace_id uuid REFERENCES core.workspaces(id),
 owner_user_id uuid NOT NULL REFERENCES identity.users(id),
 filename text NOT NULL, mime_type text NOT NULL, size_bytes bigint NOT NULL CHECK(size_bytes>=0),
 status text NOT NULL DEFAULT 'upload_pending'
   CHECK(status IN ('upload_pending','uploaded','processing','processed','failed','deleted')),
 current_version_id uuid, created_at timestamptz NOT NULL DEFAULT now(),
 updated_at timestamptz NOT NULL DEFAULT now(), deleted_at timestamptz
);
CREATE INDEX ix_documents_tenant_created ON document.documents(organization_id,created_at DESC);
CREATE TABLE document.document_versions (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 document_id uuid NOT NULL REFERENCES document.documents(id),
 version_no integer NOT NULL, object_bucket text NOT NULL, object_key text NOT NULL,
 checksum_sha256 text NOT NULL, size_bytes bigint NOT NULL CHECK(size_bytes>=0),
 created_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(document_id,version_no), UNIQUE(object_bucket,object_key)
);
ALTER TABLE document.documents ADD CONSTRAINT fk_document_current_version
 FOREIGN KEY(current_version_id) REFERENCES document.document_versions(id) DEFERRABLE INITIALLY DEFERRED;
CREATE TABLE document.processing_jobs (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 document_id uuid NOT NULL REFERENCES document.documents(id),
 job_type text NOT NULL, pipeline_version text NOT NULL,
 status text NOT NULL DEFAULT 'queued' CHECK(status IN ('queued','running','succeeded','failed','cancelled')),
 idempotency_key text NOT NULL, attempts integer NOT NULL DEFAULT 0,
 error_code text, started_at timestamptz, finished_at timestamptz,
 created_at timestamptz NOT NULL DEFAULT now(), UNIQUE(organization_id,idempotency_key)
);
CREATE INDEX ix_processing_queue ON document.processing_jobs(status,created_at);
CREATE TABLE document.document_artifacts (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 document_id uuid NOT NULL REFERENCES document.documents(id),
 job_id uuid REFERENCES document.processing_jobs(id),
 artifact_type text NOT NULL, object_bucket text NOT NULL, object_key text NOT NULL,
 metadata_json jsonb NOT NULL DEFAULT '{}'::jsonb, created_at timestamptz NOT NULL DEFAULT now()
);
