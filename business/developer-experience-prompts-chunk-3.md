
## Developer Experience & CI/CD Prompts (Chunk 3)

### Business Rules & Workflows

1.  **API Parity Check Gate:**
    *   **Prompt:** "Implement the `pronto-api-parity-check` script as a mandatory CI gate. This script must introspect the backend API routes and compare them against the endpoints used in the frontend code (for both `pronto-client` and `pronto-employees`). The build should fail if there is a mismatch, preventing frontend/backend contract drift."

2.  **Contract Change Approval Workflow:**
    *   **Prompt:** "Configure the `pre-commit-ai` hook to protect critical contract files (e.g., inside `pronto-ai/` and `pronto-docs/contracts`). By default, any modification to these files should block a commit. However, provide an escape hatch: the commit must be allowed to proceed if the environment variable `PRONTO_ALLOW_CONTRACT_CHANGES` is set to `1`."

### Technical Rules

1.  **CI/CD Scripting & Tooling:**
    *   **Prompt:** "Fix the `mac/rebuild.sh` script to ensure it runs correctly.
        *   The `PROJECT_ROOT` variable must point to the monorepo root, not the `pronto-scripts/` directory.
        *   `npm run build:*` commands must be executed from within the `pronto-static/` directory.
        *   The Docker Compose service name for the employee app must be corrected from `employee` to `employees`."

2.  **Playwright Test Runner:**
    *   **Prompt:** "Harden the Playwright test runner (`run-tests.sh`).
        *   The script must propagate the exit code from the `npx playwright test` command. If any UI test fails, the script must exit with a non-zero status to correctly fail the CI pipeline. The `|| echo` pattern that suppresses errors must be removed.
        *   Ensure the runner's documentation clearly states that `npx playwright install` must be run on the host machine to download the necessary browser binaries."

3.  **Unified API Test Runner:**
    *   **Prompt:** "Correct the authentication flow in the `run_api_tests.py` script. The `--auth-mode` should authenticate against the correct employee login endpoint (`/system/login`), not the non-existent `/api/employee/auth/login`. The script must properly handle and preserve the JWT cookie (`access_token`) for subsequent authenticated requests."

4.  **Pre-commit Hook Stability:**
    *   **Prompt:** "Fix the following blocking issues in the local pre-commit hooks:
        *   Ensure a minimal `.pre-commit-config.yaml` file exists in the `pronto-employees` repository so that `git commit` is not blocked by a 'file not found' error.
        *   Correct the typo in the main `.git/hooks/pre-commit` script, renaming the function call `add_inconsistencia` to the correctly defined `add_inconsistency`."

5.  **Python Version Compatibility:**
    *   **Prompt:** "Refactor the `pronto-rules-check` script to ensure it is compatible with Python versions older than 3.10. Replace the `list[str] | None` type hint (PEP 604) with `typing.Optional[typing.List[str]]` to prevent `TypeError` on startup."

### Documentation Rules

1.  **Endpoint Documentation Accuracy:**
    *   **Prompt:** "Audit all `README.md` files in `pronto-docs/`. Remove any references to legacy or non-existent API endpoints, such as `/api/notifications/send` and `/api/notifications/mark-read`. The documentation must only reflect the currently active and supported API contract."

2.  **Router Hash Synchronization:**
    *   **Prompt:** "Create a script or CI step that automatically verifies the `Router-Hash` in `AGENTS.md`. The hash must match the SHA256 checksum of the `pronto-ai/router.yml` file. If they do not match, the build should fail, forcing the developer to update the hash."
