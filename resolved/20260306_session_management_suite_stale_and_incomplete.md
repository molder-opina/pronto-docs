ID: TEST-20260306-008
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: test_session_management.py usa modelos/rutas legacy y no cubre el contrato real de sesiones
DESCRIPCION:
  El suite `pronto-tests/tests/functionality/integration/test_session_management.py` fue escrito
  contra contratos y modelos previos: usa `Table.zone_id`, `MenuItem.active`, `BusinessConfig`,
  rutas `/api/employees/auth/login` y flujos antiguos de checkout. Además su cobertura no refleja
  por completo las features actuales implementadas en código para manejo de sesiones.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-libs/.venv/bin/python3 -m pytest pronto-tests/tests/functionality/integration/test_session_management.py -q`.
  2. Observar fallos por imports/modelos legacy y rutas desalineadas.
RESULTADO_ACTUAL:
  El suite no valida correctamente las capacidades actuales de manejo de sesiones y contiene fixtures/expectativas obsoletas.
RESULTADO_ESPERADO:
  El archivo debe cubrir el contrato actual de `move-to-table`, `merge`, enforcement de `waiter_can_collect`
  y notificaciones al crear orden, usando modelos y endpoints vigentes.
UBICACION:
  - `pronto-tests/tests/functionality/integration/test_session_management.py`
EVIDENCIA:
  - `Table(... zone_id=1)` cuando el modelo actual usa `area_id`
  - `BusinessConfig` cuando el modelo vigente es `SystemSetting`
  - login por `/api/employees/auth/login` en vez de `/api/auth/login`
  - `MenuItem(active=True, ...)` cuando el modelo actual usa `is_active`
HIPOTESIS_CAUSA:
  El suite no se actualizó tras la migración del modelo de configuración y la consolidación de rutas/auth actuales.
ESTADO: RESUELTO
SOLUCION:
  El suite quedó reanclado al contrato vigente: usa `/api/auth/login`, `X-App-Context`,
  `Area`/`Table.area_id`, `SystemSetting` y enums canónicos de sesión/orden/pago.
  La validación runtime local ahora sólo queda bloqueada por la ausencia de la base `pronto_test`,
  no por drift del archivo de pruebas.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07