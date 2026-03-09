
# System Architecture & Developer Experience Prompts (Chunk 6)

This file contains prompts for addressing systemic architectural issues and improving the developer experience.

## Database Schema and ORM Consistency

**Prompt:**
"There is a major inconsistency between the SQLAlchemy ORM models and the physical database schema. Many models define IDs as integers while the database uses UUIDs. Furthermore, several tables referenced in the models do not exist in the database.

1.  **Fix ID Mismatches:** Audit all models in `pronto_shared/models.py`. Update any model where the primary key or a foreign key is defined as an `int` but the corresponding database column is a `UUID`.
2.  **Fix Route Definitions:** Audit all API routes in `pronto-client` and `pronto-api`. Change all route converters from `<int:id>` to `<uuid:id>` (or simply `<id>`) for all entities that use UUIDs.
3.  **Create Missing Tables:** Identify all models that do not have a corresponding table in the database (e.g., `pronto_notifications`, `pronto_waiter_calls`). Create the necessary database migration scripts to add these tables to the schema.
4.  **Resolve Duplicate Tables:** Investigate and remove duplicate tables like `pronto_business_config` vs. `pronto_system_settings` and the multiple permission systems. Unify them into a single source of truth."

**Acceptance Criteria:**
- All ORM models in `models.py` accurately reflect the data types of the database schema, especially for UUIDs.
- API endpoints like `/api/sessions/{uuid}/checkout` work correctly with UUIDs.
- The application no longer throws `UndefinedTable` errors.
- The database schema is cleaned up, with redundant tables and permission systems removed.

## Code Quality and Refactoring

**Prompt:**
"The codebase has significant technical debt, including large monolithic files and duplicated logic.

1.  **Refactor "God Files":** Identify TypeScript modules in `pronto-static` larger than 40KB (e.g., `active-orders.ts`, `menu-manager.ts`). Break them down into smaller, more focused modules, each with a single responsibility.
2.  **Decompose Monolithic Components:** Refactor large Vue components (e.g., `RolesManager.vue`) into smaller, reusable sub-components. Extract business logic into Vue "composables" or Pinia stores.
3.  **Abstract Shared Logic:** Identify and abstract duplicated logic between the `clients` and `employees` Vue applications into the `shared` directory.
4.  **Remove Inline Styles:** Find and remove all large blocks of inline CSS from HTML templates (e.g., `index_alt.html`, `feedback.html`) and move them to external CSS files.
5.  **Fix Fragile Blueprints:** Refactor Flask blueprints like `auth.py` in `pronto-client` to be self-contained, avoiding direct aliasing to the parent blueprint."

**Acceptance Criteria:**
- The size of large `.ts` and `.vue` files is significantly reduced.
- Business logic is separated from view components.
- Duplicated frontend logic is centralized in the `shared` directory.
- Templates are free of large inline `<style>` blocks.
- All Flask blueprints are modular and properly registered.

## Testing and CI/CD

**Prompt:**
"The project has critical gaps in test coverage and is missing key development dependencies.

1.  **Add Test Framework:** Integrate a testing framework like `vitest` into the `pronto-static` project.
2.  **Add Linter/Formatter:** Add `eslint` and `prettier` as `devDependencies` to `pronto-static/package.json`.
3.  **Write Critical Unit Tests:** Create comprehensive unit tests for business-critical services in `pronto-libs` that currently have no coverage, specifically `price_service.py` and `order_modification_service.py`.
4.  **Create Integration/E2E Tests:** Develop integration and E2E tests for the new customer authentication flow and the kiosk management feature. Use Playwright for E2E tests.
5.  **Create Seed Data Script:** Create an idempotent script (`pronto-seed-dev`) that populates the development database with necessary test data, including regular customers, kiosk accounts, and menu items."

**Acceptance Criteria:**
- `npm test` runs successfully in the `pronto-static` project.
- `npm run lint` and `npm run format` work correctly.
- `price_service.py` and `order_modification_service.py` have high unit test coverage.
- New Playwright tests exist for `client-auth-session.spec.ts` and `admin-kiosks.spec.ts`.
- The `pronto-seed-dev` script can be run repeatedly to reset the database to a known state.
"
