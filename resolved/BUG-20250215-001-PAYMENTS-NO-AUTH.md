# Bug Report: Pagos sin autenticación en pronto-client

ID: BUG-20250215-001
FECHA: 2025-02-15
PROYECTO: pronto-client
SEVERIDAD: bloqueante
TITULO: Endpoints de pagos permiten acceso sin autenticación de cliente

## DESCRIPCION

Los endpoints de pago en `pronto-client/src/pronto_clients/routes/api/payments.py` y `stripe_payments.py` no validan la autenticación del cliente mediante `customer_ref`. Cualquier usuario podría:
- Iniciar pagos con Stripe/Clip
- Modificar propinas
- Solicitar checkout
- Solicitar la cuenta

Esto viola el Canon 12.4 de AGENTS.md que requiere autenticación via `X-PRONTO-CUSTOMER-REF`.

## PASOS_REPRODUCIR

1. Sin estar autenticado, hacer POST a:
   - `/api/sessions/<session_id>/pay/stripe`
   - `/api/sessions/<session_id>/pay/clip`
   - `/api/sessions/<session_id>/request-payment`
   - `/api/confirm-tip`
   - `/api/sessions/<session_id>/checkout`
   - `/api/session/<session_id>/request-check`

2. Observar que la request succeed sin error 401

## RESULTADO_ACTUAL

Los endpoints procesan las requests sin verificar `customer_ref` en sesión Flask.

## RESULTADO_ESPERADO

Todos los endpoints de pagos deben:
1. Obtener `customer_ref` de `session.get("customer_ref")`
2. Validar que existe y no está revocado en Redis
3. Retornar 401 si no está autenticado

## UBICACION

- `pronto-client/src/pronto_clients/routes/api/payments.py`
- `pronto-client/src/pronto_clients/routes/api/stripe_payments.py`

## EVIDENCIA

```python
# payments.py - request_payment() - NO valida customer_ref
@payments_bp.post("/sessions/<session_id>/request-payment")
def request_payment(session_id):
    # FALTA: customer_ref = session.get("customer_ref")
    # FALTA: validación de sesión
```

Comparar con implementación correcta en `waiter_calls.py`:
```python
# waiter_calls.py - SI valida customer_ref
customer_ref = session.get("customer_ref")
if not customer_ref:
    return jsonify({"error": "Autenticación requerida"}), HTTPStatus.UNAUTHORIZED
```

## HIPOTESIS_CAUSA

Los endpoints de pago fueron implementados sin seguir el patrón de autenticación usado en otros endpoints (waiter_calls, split_bills, notifications).

## ESTADO: RESUELTO

## SOLUCION

Se添加 autenticación a todos los endpoints de pago:

1. **payments.py** - 添加 funciones `_get_authenticated_customer()` y `_require_customer_auth()` y se应用于:
   - `POST /sessions/<session_id>/request-payment`
   - `POST /confirm-tip`
   - `POST /sessions/<session_id>/checkout`
   - `POST /session/<session_id>/request-check`

2. **stripe_payments.py** - 添加 mismas funciones y应用于:
   - `POST /sessions/<session_id>/pay/stripe`
   - `POST /sessions/<session_id>/pay/clip`

## COMMIT

(pronto-client) Add customer auth to payment endpoints

## FECHA_RESOLUCION: 2025-02-15
