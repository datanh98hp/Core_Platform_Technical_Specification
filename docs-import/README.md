# Import the original V2.2 ZIP

The repository can materialize the exact original ZIP, including all six binary DOCX files, without reconstructing or abbreviating them.

1. Merge PR #2 so the import workflow is available from `main`.
2. Download the original archive attached to this conversation:
   `Core_Platform_Technical_Specification_V2.2_Architecture_Security_Hardening.zip`
3. Create a new branch from the updated `main` (for example, `docs/upload-v2.2-archive`).
4. Upload the ZIP to this directory using the exact filename:
   `docs-import/Core_Platform_Technical_Specification_V2.2_Architecture_Security_Hardening.zip`
5. Commit the upload. The GitHub Action will create a clean synchronization PR automatically.

The workflow verifies SHA-256
`fd27be4327fd04028142ef2a59001d78d72e2428b4ded283766a1b76afbbef3e`, tests the ZIP,
checks for exactly 56 files, and creates a PR that replaces the repository `docs/`
tree with the exact archive contents, including all six DOCX source documents.

The uploaded ZIP itself is not kept in the final docs tree. The resulting PR must be
reviewed and merged separately. The workflow does not apply SQL migrations or deploy services.
