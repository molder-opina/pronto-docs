# Libs Shared Functions Audit - Bugs
Date: 2026-03-08
Scope: pronto-libs vs duplicated helpers in pronto-client and pronto-employees
Status: Open

## BUG-LIBS-001 - Duplicated BFF proxy transport helpers outside pronto-libs
Severity: High
Type: Code duplication / maintainability risk

### Evidence
- `pronto-client/src/pronto_clients/routes/api/auth.py`
- `pronto-client/src/pronto_clients/routes/api/orders.py`
- `pronto-client/src/pronto_clients/routes/api/payments.py`
- `pronto-client/src/pronto_clients/routes/api/sessions.py`
- `pronto-client/src/pronto_clients/routes/api/notifications.py`
- `pronto-client/src/pronto_clients/routes/api/split_bills.py`
- `pronto-client/src/pronto_clients/routes/api/feedback_email.py`
- `pronto-client/src/pronto_clients/routes/api/stripe_payments.py`
- `pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py`
- `pronto-client/src/pronto_clients/routes/api/support.py`
- `pronto-client/src/pronto_clients/routes/api/waiter_calls.py`
- `pronto-employees/src/pronto_employees/routes/api/promotions.py`
- `pronto-employees/src/pronto_employees/routes/api/sessions.py`

All above modules re-implement variants of `_forward_to_api(...)` with repeated logic:
- URL building to `pronto-api`
- forwarding `X-Correlation-ID`, `X-CSRFToken`
- forwarding customer/scope context headers
- timeout and request exception mapping
- passthrough response header filtering

### Risk
- Fixes are inconsistent across modules.
- Regression risk when one proxy is patched and others are not.
- Harder compliance with AGENTS.md API transport constraints.

### Proposed extraction to pronto-libs
Create shared transport helper in `pronto-libs`, for example:
- `pronto-libs/src/pronto_shared/http_proxy.py`

Candidate reusable APIs:
- `build_forward_headers(...)`
- `forward_json_request(...)`
- `to_flask_response(...)`
- `proxy_error_response(...)`

---

## BUG-LIBS-002 - Employee auth proxy duplicated in 5 scope auth modules
Severity: High
Type: Cross-scope duplication / drift risk

### Evidence
- `pronto-employees/src/pronto_employees/routes/waiter/auth.py`
- `pronto-employees/src/pronto_employees/routes/chef/auth.py`
- `pronto-employees/src/pronto_employees/routes/cashier/auth.py`
- `pronto-employees/src/pronto_employees/routes/admin/auth.py`
- `pronto-employees/src/pronto_employees/routes/system/auth.py`

Each module duplicates:
- `_collect_set_cookie_headers(...)`
- `_forward_to_api(...)`
- same login/logout API path forwarding
- near-identical timeout and request exception behavior

Only `SCOPE` and endpoint names differ.

### Risk
- Scope-level auth behavior can diverge silently.
- Bug fixes in one console may not propagate to others.

### Proposed extraction to pronto-libs
Create shared employee auth proxy helper:
- `pronto-libs/src/pronto_shared/employee_auth_proxy.py`

Candidate reusable APIs:
- `forward_employee_auth(scope, method, path, payload)`
- `extract_set_cookie_headers(response)`

---

## BUG-LIBS-003 - Header normalization logic is duplicated and not centralized
Severity: Medium
Type: Consistency bug / observability risk

### Evidence
Repeated manual handling of:
- `X-Correlation-ID`
- `X-CSRFToken`
- `X-PRONTO-CUSTOMER-REF`
- `X-App-Context`

across many route files in:
- `pronto-client/src/pronto_clients/routes/api/*.py`
- `pronto-employees/src/pronto_employees/routes/*/auth.py`
- `pronto-employees/src/pronto_employees/routes/api/*.py`

### Risk
- Missing/incorrect propagation breaks traceability and security expectations.
- Header behavior differs per route with no single source of truth.

### Proposed extraction to pronto-libs
Extend a shared header utility module:
- `pronto-libs/src/pronto_shared/http_proxy.py` (new) or
- `pronto-libs/src/pronto_shared/internal_auth.py` (extension)

with a canonical function:
- `build_proxy_headers(request, scope=None, include_customer_ref=False, include_csrf=True)`

---

## Suggested migration order
1. Extract shared proxy helper in `pronto-libs`.
2. Migrate 2 client modules first (`orders.py`, `payments.py`) as pilot.
3. Migrate 5 employee auth modules.
4. Migrate remaining BFF proxy modules.
5. Add focused unit tests in `pronto-libs` for header forwarding and error mapping.
