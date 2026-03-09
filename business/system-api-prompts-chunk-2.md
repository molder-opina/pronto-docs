# Prompts for System and API (Chunk 2)

This file contains prompts for generating code and documentation for the Pronto System and APIs, based on the findings from the chunk 2 audit.

## API & Backend

*   **Prompt:** "The `_NON_TERMINAL` constant for order statuses is duplicated in `pronto-api` and `pronto-employees`. Move this constant to `pronto-libs/src/pronto_shared/constants/order_status.py` and import it in the other projects to enforce a single source of truth."
*   **Prompt:** "The JWT service is including PII (`employee_name`, `employee_email`) in the access token. Modify `pronto-libs/src/pronto_shared/jwt_service.py` to remove this PII from the token."
*   **Prompt:** "The logic for order status transitions is hardcoded in a debug file. Refactor the code in `pronto-client/src/pronto_clients/routes/api/debug.py` to use the `OrderStatusWorkflow` from `pronto_shared` for all state transitions."
*   **Prompt:** "There is a potential duplication of the branding endpoint in `pronto-api` and `pronto-employees`. Investigate and unify the implementation, using `pronto-ai/router.yml` to determine the canonical contract."
*   **Prompt:** "The kiosk password is hardcoded in `pronto-client` and `pronto-employees`. Replace the hardcoded password with an environment variable `PRONTO_KIOSK_PASSWORD`."
*   **Prompt:** "The `useFetch.ts` wrapper in `pronto-static` is missing `credentials: 'include'`. Add this to the wrapper to ensure cookies are sent with API requests."

## Documentation & Standards

*   **Prompt:** "The project documentation has inconsistent Python version requirements. Standardize on Python 3.11+ across all `README.md` files and the main `INDEX.md`."
*   **Prompt:** "The `pronto-ai/router.yml` file is referencing incorrect documentation paths. Update the paths to point to the `README.md` files within the respective project directories (e.g., `pronto-api/README.md`)."
*   **Prompt:** "The documentation for the `pronto-employees` templates is incorrect. Update the `README.md` to reflect the actual template structure."
*   **Prompt:** "The project is using `postgres:16-alpine`. Ensure all documentation and configurations reflect this version."
*   **Prompt:** "The error messages in the codebase are a mix of English and Spanish. Centralize all user-facing error messages in `pronto-libs/src/pronto_shared/i18n/messages.py` and use them throughout the applications."
*   **Prompt:** "The console logs in the frontend are inconsistent. Establish a convention for console logging, such as prefixing each log message with the module name (e.g., `[KitchenBoard] ...`)."
