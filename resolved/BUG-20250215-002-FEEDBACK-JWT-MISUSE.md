# Bug Report: Feedback email usa JWT de empleados en lugar de customer session

ID: BUG-20250215-002
FECHA: 2025-02-15
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Feedback endpoints usan JWT de empleados inconsistentemente

## DESCRIPCION

El archivo `feedback_email.py` usa `get_current_user()` que es el middleware JWT de empleados, en lugar del `customer_session_store` usado en el resto de la aplicación cliente. Esto es inconsistente con el patrón de autenticación de clientes y puede causar problemas de autenticación.

## PASOS_REPRODUCIR

1. Estar autenticado como cliente (con customer_ref en sesión)
2. Hacer POST a `/api/orders/<order_id>/feedback/email-trigger`
3. Observar que usa JWT de empleados en lugar de session de cliente

## RESULTADO_ACTUAL

```python
# feedback_email.py
from pronto_shared.jwt_middleware import get_current_user
...
user = get_current_user()  # Esto es para empleados, no clientes
```

## RESULTADO_ESPERADO

Debería usar el mismo patrón de autenticación que otros endpoints de cliente:
```python
from pronto_shared.services.customer_session_store import customer_session_store
customer_ref = session.get("customer_ref")
customer = customer_session_store.get_customer(customer_ref)
```

## UBICACION

`pronto-client/src/pronto_clients/routes/api/feedback_email.py`

## EVIDENCIA

Líneas 44-46:
```python
from pronto_shared.jwt_middleware import get_current_user
...
user = get_current_user()
session_id_from_cookie = user.get("session_id") if user else None
```

Esto contrasta con la implementación correcta en `notifications.py`:
```python
from pronto_shared.services.customer_session_store import (
    customer_session_store,
    RedisUnavailableError,
)
...
def _get_authenticated_customer() -> dict | None:
    customer_ref = session.get("customer_ref")
    ...
```

## HIPOTESIS_CAUSA

El endpoint fue copiado de la implementación de empleados sin adaptar al patrón de cliente.

## ESTADO: ABIERTO
