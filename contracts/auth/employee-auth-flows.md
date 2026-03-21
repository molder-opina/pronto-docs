# Employee Authentication Flows

## Overview

PRONTO supports **two distinct authentication flows** for employees. Each serves a specific purpose and **must not be confused**.

---

## 🔵 Flow 1: SSR Proxy (Port 6081)

### Endpoint
```
POST http://localhost:6081/{scope}/login
```

### Characteristics
- **SSR/UI flows** - Browser-based authentication
- **Cookie-based** - Sets `access_token_{scope}` cookie
- **Session-aware** - Maintains CSRF session automatically
- **Production flow** - This is what employees use in production

### When to Use
- ✅ E2E tests that navigate SSR pages
- ✅ Tests requiring browser cookies/sessions
- ✅ UI integration tests
- ✅ Validating SSR rendering with auth state

### Example (Playwright)
```typescript
const EMPLOYEES_URL = 'http://localhost:6081';

// Get login page (creates session + CSRF)
const response = await apiContext.get(`${EMPLOYEES_URL}/${scope}/login`);

// Submit form with CSRF token
const loginResponse = await apiContext.post(`${EMPLOYEES_URL}/${scope}/login`, {
  data: { email, password },
  headers: { 'X-CSRFToken': csrfToken }
});
```

### Tests Using This Pattern
- `smoke-critical.spec.ts` (line 222) - SSR page validation

---

## 🟢 Flow 2: Direct API (Port 6082)

### Endpoint
```
POST http://localhost:6082/api/employees/auth/login
```

### Characteristics
- **API-only** - Direct backend authentication
- **Token-based** - Returns JWT in response body
- **Stateless** - No session cookies required (only CSRF)
- **Faster** - No SSR overhead

### When to Use
- ✅ API/business logic tests
- ✅ Tests not requiring SSR pages
- ✅ Performance-critical test suites
- ✅ Backend integration tests

### Example (Playwright)
```typescript
const API_URL = 'http://localhost:6082';

// Get CSRF token from public config
const configResponse = await apiContext.get(`${API_URL}/api/public/config`);
const csrfToken = configResponse.json().data.csrf_token;

// Direct API login
const loginResponse = await apiContext.post(`${API_URL}/api/employees/auth/login`, {
  data: { email, password, scope },
  headers: { 'X-CSRFToken': csrfToken, 'X-App-Context': scope }
});

const token = loginResponse.json().data.access_token;
```

### Tests Using This Pattern
- `smoke-chaos-roles.spec.ts` (line 40) - Business logic validation

---

## 🔴 Common Mistakes (DO NOT DO)

### ❌ Wrong: Using customer auth for employees
```typescript
// WRONG - This is for CUSTOMERS, not employees
POST http://localhost:6082/api/auth/login
```

### ❌ Wrong: Mixing flows inconsistently
```typescript
// WRONG - Don't mix SSR and API flows in same test
const EMPLOYEES_URL = 'http://localhost:6081';
const loginResponse = await apiContext.post(`${API_URL}/api/employees/auth/login`);
```

### ❌ Wrong: Using 6081 without session
```typescript
// WRONG - 6081 requires session cookies from GET request first
const loginResponse = await apiContext.post(`${EMPLOYEES_URL}/${scope}/login`, {
  data: { email, password }
  // Missing: cookies from prior GET request
});
```

---

## Decision Matrix

| Test Type | Use | Reason |
|-----------|-----|--------|
| E2E with SSR pages | 6081 (`/{scope}/login`) | Matches production SSR flow |
| API/Business logic | 6082 (`/api/employees/auth/login`) | Faster, no SSR overhead |
| Customer auth | 6082 (`/api/auth/login`) | Only customer endpoint |
| Cookie/session tests | 6081 (`/{scope}/login`) | Cookie-based auth |
| Token-only tests | 6082 (`/api/employees/auth/login`) | Returns JWT directly |

---

## Architecture

```
┌─────────────┐
│   Browser   │
└──────┬──────┘
       │
       ├───▶ pronto-employees:6081 ───▶ pronto-api:6082
       │    (SSR Proxy)                (Auth Service)
       │    POST /{scope}/login        POST /api/employees/auth/login
       │
       └───▶ pronto-api:6082
            (Direct API)
            POST /api/employees/auth/login
```

---

## Canonical Email Accounts

For testing, use these canonical accounts:

| Role | Email | Password | Scopes |
|------|-------|----------|--------|
| Admin | `admin.roles@cafeteria.test` | `ChangeMe!123` | admin, waiter, chef, cashier |
| System | `admin@cafeteria.test` | `ChangeMe!123` | system, admin, waiter, chef, cashier |
| Waiter | `juan.mesero@cafeteria.test` | `ChangeMe!123` | waiter |
| Chef | `carlos.chef@cafeteria.test` | `ChangeMe!123` | chef |
| Cashier | `laura.cajera@cafeteria.test` | `ChangeMe!123` | cashier |

---

## Related Documentation

- `pronto-docs/contracts/auth/customer-auth-flows.md` - Customer authentication
- `pronto-docs/contracts/api/employees-auth.md` - API specification
- `pronto-tests/tests/functionality/ui/playwright-tests/smoke/` - Test examples

---

## Version History

| Version | Date | Change |
|---------|------|--------|
| 1.0779 | 2026-03-21 | Initial documentation of dual auth flows |
