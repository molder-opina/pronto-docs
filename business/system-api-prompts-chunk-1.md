# System & API Prompts (Chunk 1)

This file contains a set of prompts for generating code, test cases, or architectural tasks for the backend system and API, based on the extracted rules and workflows.

## API Design & Architecture

*   **API Contract Adherence:** "Ensure all API endpoints strictly follow the defined contracts, including the use of UUIDs for entity IDs and UTC for all timestamps."
*   **BFF Refactoring:** "Refactor the `pronto-client` and `pronto-employees` applications to remove all business logic, ensuring they act as pure Backend-for-Frontend (BFF) proxies."
*   **Single Source of Truth:** "Verify that `pronto-api` is the single source of truth for all business logic and that no other service contains business rules."
*   **Stateless Services:** "Confirm that the `pronto-employees` service is stateless and relies on JWTs for session management, while `pronto-client` uses Redis-backed sessions."

## Security

*   **Password Hashing:** "Implement and enforce the use of PBKDF2 for hashing all user and employee passwords."
*   **JWT Security:** "Implement JWT validation to check for the correct issuer (`iss`) and audience (`aud`) on every request. Ensure no PII is stored in JWT payloads."
*   **CSRF Protection:** "Implement CSRF protection on all state-changing (mutating) API endpoints, allowing only for documented exceptions required by stateless clients."
*   **Rate Limiting:** "Apply rate limiting to all authentication endpoints (`/login`, `/register`) to mitigate brute-force attacks."
*   **Ownership & Scope:** "Enforce strict ownership checks on all resources. For example, ensure a customer can only access their own orders and an employee can only operate within their assigned scope (`waiter`, `chef`, etc.)."
*   **Secret Management:** "Audit the codebase to ensure no secrets (API keys, passwords, etc.) are hardcoded. All secrets must be loaded from environment variables."

## Database

*   **Schema Migration:** "Create a database migration to add a `slug` (URL-friendly string) column to the `menu_categories` table. This column must be non-null and unique."
*   **Model-Schema Sync:** "Write a script to automatically check for and report any drift between the database schema and the ORM models."
*   **Data Integrity:** "Ensure all database operations that involve financial transactions or order state changes are atomic and handle rollbacks correctly."

## Workflows & Business Logic

*   **Order State Machine:** "Implement the complete order state machine (`new` -> `queued` -> `preparing` -> `ready` -> `delivered` -> `paid` -> `cancelled`) with authority checks to ensure transitions are only performed by authorized actors."
*   **Required Modifiers:** "Implement validation logic in the order creation endpoint to reject any order that is missing a required menu item modifier, returning a `400 Bad Request`."
*   **Dynamic Combos:** "Implement the logic to dynamically construct combo meals, ensuring they are only composed of products that are currently marked as `is_available`."
