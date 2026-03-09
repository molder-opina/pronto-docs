# Prompts for Admin Configuration Management - Chunk 9

This file contains prompts related to the administration of system and business configuration, based on the findings from the audit.

---

### User Interface and Experience

-   **Prompt**: Enhance the `ConfigItem.vue` component to provide a better user experience for editing configuration parameters. For parameters representing colors (e.g., `brand_color_primary`), render an `<input type="color">` to provide a visual color picker.
-   **Prompt**: The `currency_code` and `currency_symbol` parameters are currently free-text inputs. Modify `ConfigItem.vue` to render a `<select>` dropdown with a predefined list of canonical currencies (e.g., MXN, USD, EUR) and symbols (e.g., $, €, CAD) to ensure data consistency.
-   **Prompt**: The `font_family_body` and `font_family_headings` parameters should not be free-text inputs. Create a static JSON catalog of available fonts and modify `ConfigItem.vue` to render a dropdown (`<select>`) that is populated from this catalog.
-   **Prompt**: The `restaurant_logo_url` parameter is a manual text input. Change this to a file picker in `ConfigItem.vue`. This file picker should upload the selected image to the `/api/branding/logo` endpoint and store the returned URL.
-   **Prompt**: Improve the user workflow for editing configuration items. In `ConfigItem.vue`, each parameter should be in a read-only state by default, with an explicit "Edit" button. Clicking "Edit" should enable the input and show "Save" and "Cancel" buttons.
-   **Prompt**: The `/admin/dashboard/config` view incorrectly displays additional administrative tabs (`Empleados`, `Roles`, `Reportes`). Modify `DashboardView.vue` to ensure that the 'config' view is treated as a unitary tab group, showing only the 'Configuración' tab.

### Input Validation and Data Integrity

-   **Prompt**: Add specific input validation for configuration parameters that represent time in seconds (e.g., `checkout_prompt_duration_seconds`). In `ConfigItem.vue`, ensure these inputs only accept integer values within a reasonable range (e.g., 1 to 3600) and provide clear validation feedback.
-   **Prompt**: The toggles for boolean configuration parameters are not persisting when saved from the `/admin/dashboard/config` view because the backend is mishandling UUIDs. Fix the SSR route in `pronto-employees` to correctly identify UUIDs and update the corresponding record in the `pronto_system_settings` table.

### System Architecture

-   **Prompt**: Address the structural inconsistencies in configuration management. Refactor the system to use a single source of truth for configuration parameters. This includes:
    1.  Eliminating the legacy `pronto_business_config` table.
    2.  Enforcing a consistent lowercase naming convention for all configuration keys.
    3.  Moving hardcoded frontend configuration (like polling intervals) to the central configuration service.
    4.  Ensuring a strict separation of privileges between 'admin' and 'system' roles for modifying parameters.
