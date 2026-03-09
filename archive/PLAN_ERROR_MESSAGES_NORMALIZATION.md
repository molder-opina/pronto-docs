# Plan: Normalización de Mensajes de Error

## Problema

Existe un sistema canónico de mensajes de usuario en `pronto-libs/src/pronto_shared/trazabilidad.py`:
- `USER_MESSAGES` con códigos como `AUTH_REQUIRED`, `ORDER_NOT_FOUND`, etc.
- Soporte para español e inglés
- Función `get_user_message(code, lang)`

**Pero NO se usa en los endpoints de pronto-api** - los errores están hardcodeados en español e inglés mezclados.

## Estado Actual

### Códigos definidos en USER_MESSAGES (trazabilidad.py:152-204)
```
es: AUTH_REQUIRED, AUTH_INVALID, AUTH_EXPIRED, AUTH_BLOCKED,
    PERMISSION_DENIED, SCOPE_MISMATCH,
    ORDER_NOT_FOUND, ORDER_CANCELLED, ORDER_ALREADY_PAID, ORDER_CANT_CANCEL,
    PAYMENT_FAILED, PAYMENT_INVALID_AMOUNT, CASH_LESS_THAN_TOTAL,
    MENU_ITEM_NOT_FOUND, MODIFIER_NOT_FOUND,
    SESSION_EXPIRED, SESSION_NOT_FOUND,
    INTERNAL_ERROR, INVALID_REQUEST, RATE_LIMIT_EXCEEDED

en: (mismas llaves, traducción)
```

### Errores hardcodeados encontrados en API (51 instancias)
- `client_sessions.py`: "SESSION_EXPIRED", "SESSION_NOT_FOUND", "table_id required"
- `client_auth.py`: "Not authenticated", "Invalid customer ID", "Customer not found", mixto español/inglés
- `payments.py`: "No autenticado", "Monto inválido", "Método de pago inválido" (TODO ES)
- `invoices.py`: "Not authenticated", "Invoice not found", "customer_id required" (TODO EN)
- `support.py`: `str(exc)` (error raw)

## Plan de Normalización

### Fase 1: Agregar códigos faltantes
- [ ] Extender `USER_MESSAGES` con códigos necesarios:
  - `CUSTOMER_NOT_FOUND`
  - `INVALID_CUSTOMER_ID`
  - `INVALID_INVOICE_ID`
  - `ORDER_ID_REQUIRED`
  - `PAYMENT_REFERENCE_REQUIRED`
  - `INVALID_MOTIVE`
  - `SUBSTITUTION_UUID_REQUIRED`
  - `TABLE_ID_REQUIRED`
  - `SESSION_ALREADY_CLOSED`

### Fase 2: Reemplazar errores en endpoints
- [ ] Importar `get_user_message` en cada route file
- [ ] Reemplazar strings hardcodeados por códigos
- [ ] Agregar `error_code` en response JSON

### Fase 3: Verificación
- [ ] Buscar cualquier `jsonify.*"error"` remaining
- [ ] Validar que todos los errores usen códigos

## Ejemplo de cambio

### Antes (payments.py:247)
```python
return jsonify({"error": "No autenticado"}), HTTPStatus.UNAUTHORIZED
```

### Después
```python
from pronto_shared.trazabilidad import get_user_message

return jsonify({
    "error_code": "AUTH_REQUIRED",
    "error": get_user_message("AUTH_REQUIRED", "es")
}), HTTPStatus.UNAUTHORIZED
```

## Responsable
TBD

## Criterios de Éxito
- [ ] 0 errores hardcodeados en endpoints
- [ ] Todos los errores tienen `error_code` y mensaje traducible
- [ ] Frontend consume `error_code` para UI consistente
