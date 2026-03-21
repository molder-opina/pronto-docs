# Customer Authentication Flows

## Overview

PRONTO supports **anonymous browsing** for customers with **optional authentication** for order placement and checkout.

---

## 🔵 Flow 1: Anonymous Browsing (Default)

### Characteristics
- **No login required** - Browse menu, view products
- **Session-based** - Uses `pronto_client_session` cookie
- **Table context** - Optional table association via QR code
- **Limited actions** - Cannot place orders or checkout

### When Used
- ✅ Viewing menu
- ✅ Browsing products
- ✅ Scanning QR code
- ✅ Viewing table info

### Session Management
```typescript
// Session cookie (auto-created)
pronto_client_session: <uuid>

// Stored in Redis with TTL
Key: pronto:client:customer_ref:<uuid>
TTL: 60 minutes
```

---

## 🟢 Flow 2: Customer Registration/Login

### Endpoint
```
POST http://localhost:6082/api/auth/login
```

### Characteristics
- **Required for checkout** - Must authenticate before placing order
- **JWT-based** - Returns access token in response
- **Customer-specific** - Different from employee auth
- **PII outside session** - Customer data stored in Redis, not session

### Request
```json
POST /api/auth/login
Content-Type: application/json

{
  "email": "customer@example.com",
  "password": "customer-password"
}
```

### Response
```json
{
  "data": {
    "access_token": "eyJhbGciOiJIUzI1NiIs...",
    "customer": {
      "id": "uuid",
      "email": "customer@example.com",
      "name": "Customer Name"
    }
  },
  "status": "success"
}
```

### Headers for Authenticated Requests
```typescript
Authorization: Bearer <access_token>
X-PRONTO-CUSTOMER-REF: <customer_ref>
```

---

## 🔴 Common Mistakes (DO NOT DO)

### ❌ Wrong: Using employee auth for customers
```typescript
// WRONG - This is for EMPLOYEES, not customers
POST http://localhost:6082/api/employees/auth/login
```

### ❌ Wrong: Storing PII in session
```typescript
// WRONG - PII must be in Redis, not session
session.customer_email = email  // DON'T DO THIS
```

### ❌ Wrong: Allowing checkout without auth
```typescript
// WRONG - Must check authentication before checkout
if (!customer.isAuthenticated) {
  // Should redirect to login/register
}
```

---

## Decision Matrix

| Action | Auth Required | Flow |
|--------|--------------|------|
| Browse menu | ❌ No | Anonymous |
| View products | ❌ No | Anonymous |
| Scan QR code | ❌ No | Anonymous |
| Add to cart | ❌ No | Anonymous |
| Place order | ✅ Yes | Registered |
| Checkout | ✅ Yes | Registered |
| Payment | ✅ Yes | Registered |
| View order history | ✅ Yes | Registered |

---

## Architecture

```
┌─────────────┐
│   Browser   │
└──────┬──────┘
       │
       ├───▶ pronto-client:6080 ───▶ pronto-api:6082
       │    (SSR Client)            (Auth Service)
       │    GET /                   POST /api/auth/login
       │    (Anonymous)             (Customer Login)
       │
       └───▶ pronto-api:6082
            (Direct API)
            POST /api/auth/login
```

---

## Session vs JWT

| Aspect | Session | JWT |
|--------|---------|-----|
| Storage | Redis | Client (cookie/header) |
| TTL | 60 minutes | Configurable (default 24h) |
| PII | ✅ Stored in Redis | ❌ Never store PII |
| Anonymous | ✅ Supported | ❌ Requires auth |
| Use case | Browsing, cart | Checkout, orders |

---

## Canonical Test Accounts

For testing customer flows:

| Email | Password | Use Case |
|-------|----------|----------|
| `customer@test.com` | `customer123` | Standard customer |
| `guest@test.com` | `guest123` | Guest checkout |

> **Note:** Customer accounts are auto-created during test setup. Use `pronto-scripts/bin/pronto-setup-test-auth` for employee accounts.

---

## Security Considerations

### CSRF Protection
- All mutations require CSRF token
- Token from `/api/public/config` → `data.csrf_token`
- Header: `X-CSRFToken: <token>`

### PII Protection
- Customer email, name, phone → **Redis only**
- Session cookie → **UUID reference only**
- JWT → **No PII claims**

### Rate Limiting
- Login: 5 attempts per minute per IP
- Registration: 3 per hour per IP
- Password reset: 2 per hour per email

---

## Related Documentation

- `pronto-docs/contracts/auth/employee-auth-flows.md` - Employee authentication
- `pronto-docs/contracts/api/customer-auth.md` - API specification
- `pronto-docs/contracts/redis-keys.md` - Session storage keys

---

## Version History

| Version | Date | Change |
|---------|------|--------|
| 1.0779 | 2026-03-21 | Initial documentation |

