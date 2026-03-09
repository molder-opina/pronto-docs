
# Admin & Employee Feature Prompts (Chunk 6)

This file contains prompts related to features for administrators and employees.

## Kiosk Administration

**Prompt:**
"Develop the backend API and frontend interface for managing Kiosk accounts in the employee-facing application.

**API (`pronto-employees`):**
- Create a new set of API endpoints under `/api/customers/kiosks`.
- Implement `GET /api/customers/kiosks` to list all customer accounts where `kind='kiosk'`.
- Implement `POST /api/customers/kiosks` which accepts a `location` (e.g., "lobby") and creates a new customer account with an email like `kiosk+lobby@pronto.local` and sets `kind='kiosk'`.
- Implement `DELETE /api/customers/kiosks/<id>` to perform a hard delete on a kiosk account.
- Ensure these endpoints are protected and only accessible to users with `admin`, `cashier`, or `system` scopes.

**Frontend (`pronto-static`):**
- Create a new Vue view and component (`KiosksManager.vue`) in the employees section of the admin panel.
- This component should display a table of all existing kiosk accounts, fetched from the `GET` endpoint.
- Include a button to open a modal for creating a new kiosk, which calls the `POST` endpoint.
- Each row in the table should have a delete button that calls the `DELETE` endpoint after a confirmation prompt.
"

**Acceptance Criteria:**
- The API endpoints for kiosk management are functional and protected by the correct scopes.
- An admin user can view a list of all kiosks in the admin panel.
- An admin user can create a new kiosk by providing a location name.
- An admin user can delete a kiosk, which removes it from the system.
- The UI provides clear feedback for all operations (creation, deletion, errors).
- The task for creating the Vue admin panel (`AUTH-014`) is marked as `POSTERGADO` and will be addressed later, but the API must be ready.
