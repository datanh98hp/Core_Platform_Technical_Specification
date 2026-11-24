CREATE TABLE knowledge.knowledge_bases (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 workspace_id uuid REFERENCES core.workspaces(id),
 name text NOT NULL,
 visibility text NOT NULL DEFAULT 'private' CHECK(visibility IN ('private','workspace','organization')),
 status text NOT NULL DEFAULT 'active', created_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(organization_id,name)
);
CREATE TABLE knowledge.knowledge_sources (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 knowledge_base_id uuid NOT NULL REFERENCES knowledge.knowledge_bases(id) ON DELETE CASCADE,
 document_id uuid NOT NULL, document_version_id uuid NOT NULL,
 status text NOT NULL DEFAULT 'pending' CHECK(status IN ('pending','indexing','indexed','failed','deleting')),
 created_at timestamptz NOT NULL DEFAULT now(), indexed_at timestamptz,
 UNIQUE(knowledge_base_id,document_version_id)
);
CREATE TABLE knowledge.knowledge_chunks (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 source_id uuid NOT NULL REFERENCES knowledge.knowledge_sources(id) ON DELETE CASCADE,
 chunk_index integer NOT NULL, content text NOT NULL, token_count integer,
 metadata_json jsonb NOT NULL DEFAULT '{}'::jsonb, embedding vector(1536),
 created_at timestamptz NOT NULL DEFAULT now(), UNIQUE(source_id,chunk_index)
);
CREATE INDEX ix_chunks_tenant_source ON knowledge.knowledge_chunks(organization_id,source_id);
CREATE INDEX ix_chunks_embedding ON knowledge.knowledge_chunks USING hnsw(embedding vector_cosine_ops);
CREATE TABLE knowledge.indexing_runs (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 organization_id uuid NOT NULL REFERENCES identity.organizations(id),
 source_id uuid NOT NULL REFERENCES knowledge.knowledge_sources(id),
 status text NOT NULL DEFAULT 'queued' CHECK(status IN ('queued','running','completed','failed')),
 chunk_count integer NOT NULL DEFAULT 0, error_code text,
 started_at timestamptz, finished_at timestamptz, created_at timestamptz NOT NULL DEFAULT now()
);
