# Pronto Business Flow Checklist

This document outlines the major business flows for the Pronto restaurant management system. It serves as a checklist for auditing and validating the system's functionality.

---

## Customer-Facing Flows (`pronto-client`)

- [ ] **1. Guest/Anonymous Browsing:** A customer can scan a QR code or visit the site and start building an order without logging in.
- [ ] **2. Customer Authentication:** A customer can create an account or log in.
- [ ] **3. Menu & Ordering:** View the menu, add items to a cart, customize items, and place an order.
- [ ] **4. Order Payment (Client-side):**
    - [ ] 4a. Pay directly using Stripe.
    - [ ] 4b. Request to pay with a physical Clip terminal (calls a waiter).
- [ ] **5. Order Tracking:** View the status of their current order in real-time.
- [ ] **6. Calling a Waiter:** Request assistance from a waiter.
- [ ] **7. Feedback Submission:** Leave a rating and review for their dining experience.
- [ ] **8. Kiosk Mode:** A self-service flow for placing orders from a dedicated kiosk.

---

## Employee-Facing Flows (`pronto-employees`)

- [ ] **9. Employee Authentication:** Employees log in with their credentials to access their specific dashboard based on their role (Waiter, Chef, Cashier, Admin).
- [ ] **10. Waiter: Table & Order Management:**
    - [ ] 10a. View table statuses (e.g., open, occupied, needs cleaning).
    - [ ] 10b. Create a new dining session for a table.
    - [ ] 10c. Take orders for a table and add items to the session.
    - [ ] 10d. Respond to waiter calls from customers.
- [ ] **11. Chef: Kitchen Display System (KDS):**
    - [ ] 11a. View incoming orders and items on a kitchen display.
    - [ ] 11b. Update the status of items (e.g., "Preparing", "Ready for Pickup").
- [ ] **12. Cashier: Payment Processing:**
    - [ ] 12a. View all open dining sessions and their totals.
    - [ ] 12b. Process payments via Cash.
    - [ ] 12c. Process payments via Clip (using a physical terminal and marking the transaction in the system).
    - [ ] 12d. Close out paid dining sessions.
- [ ] **13. Admin: System Management:**
    - [ ] 13a. Manage employees (add, remove, change roles).
    - [ ] 13b. Manage menu categories and items.
    - [ ] 13c. Manage product details, including pricing and availability.
    - [ ] 13d. Configure general restaurant settings (e.g., taxes, currency, business hours).
    - [ ] 13e. View sales reports and basic analytics.
- [ ] **14. System: Super-Admin Functions:**
    - [ ] 14a. Perform technical maintenance tasks (e.g., merging duplicate sessions).
