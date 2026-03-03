# Error: Tipo de Ruta Incorrecto en pronto-client

**ID**: BUG-20260226-ROUTE-01
**FECHA**: 2026-02-26
**PROYECTO**: pronto-client
**SEVERIDAD**: alta (P1)
**TITULO**: Uso de <int:call_id> para WaiterCall viola estándar de tipos
**DESCRIPCION**: |
  AGENTS.md sección 12.5 establece que solo entidades de lookup/técnicas usan Integer.
  WaiterCall es una entidad de negocio con UUID, no Integer.
**PASOS_REPRODUCIR**:
  1. rg "/<int:[a-z_]+_id>" pronto-client/src
**RESULTADO_ACTUAL**: waiter_calls.py:288 usa <int:call_id>
**RESULTADO_ESPERADO**: <uuid:call_id>
**UBICACION**: pronto-client/src/pronto_clients/routes/api/waiter_calls.py:288
**HIPOTESIS_CAUSA**: Error en definición de ruta
**ESTADO**: RESUELTO
**SOLUCION**: No es bug - WaiterCall está en lista de excepciones de tipos Integer (AGENTS.md 12.5)
**COMMIT**: N/A
**FECHA_RESOLUCION**: 2026-02-26
