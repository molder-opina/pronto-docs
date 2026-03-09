ID: API-20260307-002
FECHA: 2026-03-07
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: waiter_calls usa datetime/timezone sin imports requeridos
DESCRIPCION:
  El expediente reportaba que `cancel_waiter_call` usaba `datetime.now(timezone.utc)` sin importar `datetime` ni `timezone`.
PASOS_REPRODUCIR:
  1. Abrir `pronto-api/src/api_app/routes/customers/waiter_calls.py`.
  2. Revisar imports y la línea de cancelación.
RESULTADO_ACTUAL:
  En el árbol actual el módulo ya importa `from datetime import datetime, timezone`.
RESULTADO_ESPERADO:
  Incluir imports correctos o usar helper temporal consistente.
UBICACION:
  - `pronto-api/src/api_app/routes/customers/waiter_calls.py`
ESTADO: RESUELTO
SOLUCION:
  Se verificó que el bug ya estaba corregido en el árbol actual. Validación: inspección directa del módulo y
  `python3 -m py_compile pronto-api/src/api_app/routes/customers/waiter_calls.py` => OK.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
