---
ID: 20260215_func_uuid_mismatch
DATE: 2026-02-15
PROJECT: pronto-client / pronto-api
SEVERITY: High
TITLE: Route definitions use <int:id> but system uses UUIDs
DESCRIPTION: |
  Multiple API routes in both `pronto-client` (BFF) and `pronto-api` are defined with integer type converters (e.g., `<int:session_id>`, `<int:order_id>`).
  
  However, the system has migrated to using UUIDs for `DiningSession` and `Order` IDs.
  
  When a UUID is passed to these endpoints (e.g., `/api/sessions/a0eeb.../checkout`), Flask routing fails to match the URL because it expects an integer, returning a 404 Not Found.
  
  Affected endpoints include payments, checkout, and order details.
LOCATION:
  - `pronto-client/src/pronto_clients/routes/api/payments.py`
  - `pronto-client/src/pronto_clients/routes/api/stripe_payments.py`
  - `pronto-api/src/api_app/routes/customers/orders.py`
REPRODUCTION:
  1. Open a session (get UUID).
  2. Call `/api/sessions/{uuid}/checkout`.
  3. Observe 404 Not Found.
EXPECTED: Routes should accept UUID strings (e.g., `<session_id>` or `<uuid:session_id>`).
ACTUAL: Routes require integers.
---
