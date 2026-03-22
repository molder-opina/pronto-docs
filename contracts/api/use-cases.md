# API Contracts - Use Cases

## Overview

This document describes the canonical use cases exposed through the `/api/*` endpoints in `pronto-api`.

## Use Cases

### 1. Resolve Table from QR Code

**Endpoint:** `GET /api/tables/resolve-table-from-qr-use-case/{qr_code}`

**Purpose:** Resolve table information from a QR code scan.

**Authentication:** Public (no authentication required)

**Request Parameters:**
- `qr_code` (path): QR code string to look up

**Response:**
```json
{
  "status": "success",
  "data": {
    "table_id": "uuid",
    "table_number": 12,
    "area": {
      "prefix": "M",
      "name": "Main Dining"
    }
  }
}
```

**Error Responses:**
- `400 Bad Request`: Invalid or empty QR code
- `404 Not Found`: Table not found or inactive

**Use Case:** `ResolveTableFromQRUseCase`

---

### 2. Start Kiosk Session

**Endpoint:** `POST /api/kiosk/start-kiosk-session-use-case/{location}`

**Purpose:** Start a kiosk session for a specific location.

**Authentication:** Required via `X-PRONTO-KIOSK-SECRET` header

**Request Parameters:**
- `location` (path): Kiosk location identifier
- `email` (body): Kiosk email in format `kiosk+{location}@pronto.local`

**Request Body:**
```json
{
  "email": "kiosk+main-lobby@pronto.local"
}
```

**Response:**
```json
{
  "status": "success",
  "data": {
    "customer_ref": "uuid",
    "customer": {
      "id": "uuid",
      "name": "Kiosko main-lobby",
      "email": "kiosk+main-lobby@pronto.local",
      "kind": "kiosk",
      "location": "main-lobby"
    }
  }
}
```

**Error Responses:**
- `400 Bad Request`: Invalid location or email format
- `401 Unauthorized`: Missing or invalid authentication header

**Use Case:** `StartKioskSessionUseCase`

---

### 3. Submit Feedback

**Endpoint:** `POST /api/feedback/submit-use-case`

**Purpose:** Submit feedback for a dining session.

**Authentication:** Customer session required

**Request Body:**
```json
{
  "session_id": "uuid",
  "employee_id": "uuid (optional)",
  "rating": 5,
  "comments": "Excellent service!"
}
```

**Response:**
```json
{
  "status": "success",
  "data": {
    "feedback_id": "uuid"
  }
}
```

**Error Responses:**
- `400 Bad Request`: Missing required fields or invalid rating
- `404 Not Found`: Session not found
- `403 Forbidden`: Session doesn't belong to customer

**Use Case:** `SubmitFeedbackUseCase`

---

## Validation Rules

### All Use Cases

1. **Input Validation:** All inputs must be validated before processing
2. **Error Messages:** Use `error_response()` for errors, `success_response()` for success
3. **HTTP Status Codes:** Return appropriate status codes (200, 400, 401, 403, 404, 500)

### QR Code Resolution

1. QR code must be non-empty string
2. Table must be active
3. Table must match QR code exactly

### Kiosk Session

1. Location must be non-empty string
2. Email must match format `kiosk+{location}@pronto.local`
3. Authentication header must be valid
4. Creates new kiosk account if not exists

### Feedback Submission

1. Session ID must be valid UUID
2. Rating must be integer between 1-5
3. Session must exist
4. Employee ID (if provided) must be valid UUID

## Testing

See test files:
- `test_resolve_table_from_qr.py`
- `test_start_kiosk_session.py`
- `test_submit_feedback.py`

Each test file covers:
- Happy path
- Error cases (400, 401, 403, 404)
- Edge cases
