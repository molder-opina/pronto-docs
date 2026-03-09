ID: TEST-20260306-010
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: test_split_bill usa contratos obsoletos de Table, MenuItem y auth
DESCRIPCION:
  La suite `pronto-tests/tests/functionality/integration/test_split_bill.py` estaba escrita contra
  contratos viejos del código (`zone_id`, `active=True`, auth legacy) y fallaba antes de verificar
  el contrato actual de split bill.
PASOS_REPRODUCIR:
  1. Ejecutar `pytest pronto-tests/tests/functionality/integration/test_split_bill.py -q`.
  2. Observar errores de setup por argumentos inválidos del modelo.
RESULTADO_ACTUAL:
  La prueba fallaba en el fixture y no verificaba el contrato actual de `/api/split-bills/*`.
RESULTADO_ESPERADO:
  La suite debe validar el contrato vigente usando autenticación canónica `/api/auth/login`, headers/scope correctos y fixtures compatibles con los modelos actuales.
UBICACION:
  - `pronto-tests/tests/functionality/integration/test_split_bill.py`
EVIDENCIA:
  - Uso de `zone_id` en `Table`
  - Uso de patrones legacy de auth/fixtures
HIPOTESIS_CAUSA:
  La prueba quedó congelada en una versión anterior del dominio y no se actualizó junto con la migración de contratos canónicos.
ESTADO: RESUELTO
SOLUCION:
  Se reescribió la suite para usar login canónico, headers de scope y fixtures compatibles con `Area/area_id`. Además se agregó cobertura para `calculate` y se modeló el flujo de `create/pay` a nivel de contrato de rutas con mocks estables donde hoy existen bugs reales del backend.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06