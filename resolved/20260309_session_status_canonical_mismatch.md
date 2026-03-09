ID: SESS-20260309-001
FECHA: 2026-03-09
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: SessionStatus canónico no refleja estados activos usados por DiningSession
DESCRIPCION:
  El enum canónico de estados de sesión no incluía `active` ni `merged`, mientras el sistema sí
  usaba esos valores en flujos productivos y documentación de schema, dejando autoridad partida
  entre `SessionStatus`, strings mágicos y comentarios SQL.
PASOS_REPRODUCIR:
  1. Revisar `pronto-libs/src/pronto_shared/constants.py` y los consumidores de `DiningSession.status`.
  2. Buscar `"active"`, `"merged"` y comparaciones directas contra `DiningSession.status` en `pronto-libs` y `pronto-api`.
RESULTADO_ACTUAL:
  `SessionStatus` incluye los estados operativos reales (`active`, `merged`) y los consumidores clave usan constantes canónicas o sets centralizados.
RESULTADO_ESPERADO:
  Toda la autoridad de estados de sesión debe vivir en `pronto_shared.constants`, sin strings mágicos críticos en lógica productiva.
UBICACION:
  - pronto-libs/src/pronto_shared/constants.py
  - pronto-libs/src/pronto_shared/models/order_models.py
  - pronto-libs/src/pronto_shared/services/dining_session_service_impl.py
  - pronto-libs/src/pronto_shared/services/order_service_impl.py
  - pronto-libs/src/pronto_shared/services/orders/session_manager.py
  - pronto-libs/src/pronto_shared/services/table_service_core.py
  - pronto-api/src/api_app/routes/client_sessions.py
  - pronto-api/src/api_app/routes/customers/orders.py
  - pronto-api/src/api_app/routes/employees/maintenance.py
  - pronto-api/src/api_app/routes/employees/stats.py
  - pronto-api/src/api_app/routes/employees/sessions.py
  - pronto-scripts/init/sql/migrations/20260215_03__fix_session_status_column.sql
  - pronto-docs/contracts/pronto-*/db_schema.sql
EVIDENCIA:
  - `python3 -m py_compile ...` sobre los archivos tocados => OK
  - `cd pronto-libs && .venv/bin/python -m pytest tests/unit/test_session_status_constants.py tests/unit/services/test_rbac_service.py tests/unit/services/test_table_service_core.py -q` => `10 passed`
  - `./pronto-scripts/bin/pronto-init --dry-run` => `OK dry-run (deny checks passed).`
  - búsqueda transversal posterior sin resultados críticos de strings mágicos para `DiningSession.status`
HIPOTESIS_CAUSA:
  El workflow de dining sessions evolucionó sin que la autoridad canónica y los consumidores quedaran sincronizados al mismo tiempo.
ESTADO: RESUELTO
SOLUCION:
  Se agregaron `SessionStatus.ACTIVE` y `SessionStatus.MERGED`, junto con sets canónicos reutilizables (`ACTIVE_SESSION_STATUSES`, `OPEN_OR_ACTIVE_SESSION_STATUSES`, `TERMINAL_SESSION_STATUSES`). Se reemplazaron comparaciones y asignaciones directas críticas en servicios y rutas por constantes canónicas, se alineó el default ORM de `DiningSession`, y se actualizó la documentación SQL/contractual para incluir `merged` dentro del inventario de estados documentados.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09