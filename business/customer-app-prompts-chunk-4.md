
# Customer App Prompts (Chunk 4)

## Ordering and Session Management

- **Prompt:** "As a customer, I need to be able to place orders through the application. This requires the backend to have fully implemented API endpoints for order creation, modification, and payment processing."
- **Prompt:** "As a customer, I need to be able to call a waiter from my table. This functionality must be robust and reliable, ensuring the waiter receives the notification promptly."
- **Prompt:** "As a customer, I expect to be able to easily split the bill with other diners at my table, and the system should accurately calculate individual shares."

## User Interface and Branding

- **Prompt:** "As a customer, I expect the application's user interface to be visually appealing, consistent, and free of broken images or elements. This includes correctly displaying restaurant assets and custom branding without inconsistencies or missing files."
- **Prompt:** "As a customer, I expect all branding elements (logos, colors, fonts) to be applied consistently and correctly throughout the application, without direct API calls bypassing central management."
- **Prompt:** "As a customer, I expect the application to load external fonts and static assets securely and reliably. All assets should be served from consistent and canonical paths."

## Technical and Security (Customer Specific)

- **Prompt:** "To ensure all communication between my device and the application's servers is secure and reliable, all API requests from the customer application must be channeled through a standardized `http.ts` wrapper, providing consistent handling of sessions, security tokens, and errors for every action I take."
- **Prompt:** "As a customer, I must never be able to modify or delete table configurations through the application. This functionality is strictly for employees, and any code that suggests otherwise must be removed for security."
- **Prompt:** "The application's global configuration (`APP_CONFIG`) must be initialized correctly and robustly. I expect the application to not rely on inline JavaScript patches in `base.html` to correct configuration values at runtime."
- **Prompt:** "The customer application must not contain inline JavaScript making direct API calls from HTML templates. All data fetching logic must be centralized within the `http.ts` wrapper, using `credentials: 'include'` for consistent authentication."
- **Prompt:** "To ensure the security and privacy of my personal information, the application must never store my Personally Identifiable Information (PII) in plaintext or expose it through serializers."
- **Prompt:** "I expect the application to use robust authentication and authorization mechanisms to protect my data and ensure that only authorized actions are performed."
