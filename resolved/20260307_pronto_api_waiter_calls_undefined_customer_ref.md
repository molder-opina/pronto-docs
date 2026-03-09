ID: API-20260307-001
FECHA: 2026-03-07
PROYECTO: pronto-api
SEVERIDAD: critica
TITULO: waiter_calls usa variable customer_ref no definida y rompe endpoints
DESCRIPCION:
  El expediente reportaba uso de `customer_ref` sin declarar en los endpoints de `waiter_calls`, provocando `NameError`.
PASOS_REPRODUCIR:
  1. Abrir `pronto-api/src/api_app/routes/customers/waiter_calls.py`.
  2. Revisar `call_waiter`, `get_waiter_call_status` y `cancel_waiter_call`.
RESULTADO_ACTUAL:
  En el árbol actual `customer_ref` se obtiene correctamente desde `request.headers.get("X-PRONTO-CUSTOMER-REF")` antes de usarse.
RESULTADO_ESPERADO:
  Resolver `customer_ref` desde header o decorador y usarlo consistentemente.
UBICACION:
  - `pronto-api/src/api_app/routes/customers/waiter_calls.py`
ESTADO: RESUELTO
SOLUCION:
  Se verificó que el bug ya estaba corregido en el árbol actual. Validación: inspección directa del módulo y
  `python3 -m py_compile pronto-api/src/api_app/routes/customers/waiter_calls.py` => OK.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
