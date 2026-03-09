# Employee App Prompts (Chunk 1)

This file contains a set of prompts for generating code or test cases for the employee-facing application, based on the extracted rules and workflows.

## Authentication & Authorization

*   **Employee Login:** "As an employee, I want to be able to log in with my credentials and be redirected to a dashboard specific to my role (Waiter, Chef, Cashier, Admin, or System)."
*   **Role-Based Access:** "As an employee, my access to features and data must be restricted based on my assigned role. For example, a Chef should not be able to access cashier functions."

## Waiter Dashboard

*   **View Active Orders:** "As a waiter, I need to see a real-time list of all active orders, including their status, items, and assigned table."
*   **Table Status:** "As a waiter, I want a view of all tables to see which ones are occupied, which need attention, and which are available."
*   **Update Order Status:** "As a waiter, I must be able to mark an order as 'Delivered' once I have served it to the customer."
*   **Request Payment:** "As a waiter, I need to be able to initiate the payment process for a table's order."
*   **Call Admin:** "As a waiter, I need a button to send a notification to an administrator for assistance."

## Chef Dashboard (Kitchen Display System)

*   **View Incoming Orders:** "As a chef, I need to see all new and active orders on a kitchen display system, prioritized by time."
*   **Update Preparation Status:** "As a chef, I must be able to update an order's status to 'Preparing' when I start working on it, and to 'Ready' when it is complete."

## Cashier Dashboard

*   **View Pending Payments:** "As a cashier, I need a list of all orders that are awaiting payment."
*   **Process Payments:** "As a cashier, I must be able to process payments for orders, whether by cash or card."
*   **Close Session:** "As a cashier, I need to be able to close out a dining session once it has been fully paid."

## Admin Dashboard

*   **Menu Management:** "As an admin, I need a CRUD interface to manage the menu, including adding/editing items, setting prices, and marking items as 'unavailable'."
*   **Employee Management:** "As an admin, I need a CRUD interface to manage employees, including creating accounts, assigning roles, and deactivating users."
*   **System Configuration:** "As an admin, I want to be able to view and modify system settings, such as session timeouts and currency symbols."
*   **View Analytics:** "As an admin, I need access to dashboards and reports on sales, order volume, and other key business metrics."
*   **Kiosk Management:** "As an admin, I need to be able to manage kiosk user accounts."
