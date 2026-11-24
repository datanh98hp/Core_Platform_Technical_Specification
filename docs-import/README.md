# Import the original V2.2 ZIP

The repository can materialize the exact original ZIP, including all six binary DOCX files, without reconstructing or abbreviating them.

1. Download the archive attached to this conversation:
   `Core_Platform_Technical_Specification_V2.2_Architecture_Security_Hardening.zip`
2. On GitHub, switch to branch `docs/v2.2-agent-governance`.
3. Upload the archive to this directory using this exact filename:
   `Core_Platform_Technical_Specification_V2.2_Architecture_Security_Hardening.zip`
4. Commit the upload to that branch.

The GitHub Action `.github/workflows/materialize-v2.2-docs.yml` verifies SHA-256
`fd27be4327fd04028142ef2a59001d78d72e2428b4ded283766a1b76afbbef3e`, tests the ZIP,
checks for exactly 56 files, and then creates a clean PR from current `main` containing
the exact archive contents under `docs/`.

The uploaded ZIP itself is not copied into the production docs tree. The resulting PR
must be reviewed and merged separately. The workflow does not apply SQL migrations or
deploy services.
