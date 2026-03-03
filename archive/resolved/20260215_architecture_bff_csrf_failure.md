---
ID: 20260215_architecture_bff_csrf_failure
DATE: 2026-02-15
PROJECT: pronto-client
SEVERITY: High
TITLE: BFF (Pronto Client) fails to authenticate with Core API due to CSRF
DESCRIPTION: |
  `pronto-api` has CSRF protection enabled (`WTF_CSRF_ENABLED = True`).
  `pronto-client` acts as a BFF (Backend for Frontend) and makes server-side calls to `pronto-api` using `requests`.
  
  The proxy logic in `pronto_clients/routes/api/orders.py` sends `X-PRONTO-CUSTOMER-REF` but does NOT send a valid `X-CSRFToken` that `pronto-api` accepts. Since `pronto-api` treats these requests as regular web requests (not exempt), they are rejected with 400 Bad Request ("The CSRF token is missing").
  
  This breaks the core order flow when routed through the client application.
LOCATION: `pronto-client/src/pronto_clients/routes/api/orders.py`
REPRODUCTION:
  1. Ensure `WTF_CSRF_ENABLED = True` in `pronto-api`.
  2. Attempt to place an order via `pronto-client`.
  3. Observe 400 error from `pronto-api`.
EXPECTED: Server-to-server communication between trusted containers should bypass CSRF (via authentication mechanism) OR the BFF should correctly handle CSRF tokens. Given the architecture, exemption for trusted backend calls (BFF) is the standard solution.
ACTUAL: Requests fail due to missing CSRF token.
---
