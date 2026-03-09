ID: AUDIT-20260309-SYNC-TECH-DEBT
FECHA: 2026-03-09
PROYECTO: pronto-monorepo
SEVERIDAD: alta
TITULO: Auditoría transversal detecta drift de migración, deuda técnica activa y alto WIP simultáneo entre proyectos PRONTO
DESCRIPCION: Se ejecutó una auditoría repo-wide para verificar que el monorepo esté en orden, con foco en deuda técnica y sincronización entre proyectos `pronto-*`. La señal general es mixta: los guardrails principales pasan (`rules-check`, parity, no-runtime-ddl, no-legacy, naming), pero persisten hallazgos estructurales relevantes: (1) drift real en migraciones/init para `pronto_dining_sessions.status`, (2) deuda técnica activa en módulos legacy/deprecated y archivos monolíticos, (3) alto volumen de cambios locales simultáneos entre repos que eleva riesgo de desalineación operativa.
PASOS_REPRODUCIR:
1. Ejecutar `./pronto-scripts/bin/pronto-rules-check fast`.
2. Ejecutar `./pronto-scripts/bin/pronto-inconsistency-check`.
3. Ejecutar `./pronto-scripts/bin/pronto-api-parity-check employees` y `clients`.
4. Ejecutar `bash -lc 'set -a; source .env >/dev/null 2>&1 || true; set +a; ./pronto-scripts/bin/pronto-init --check'`.
5. Ejecutar `bash -lc 'set -a; source .env >/dev/null 2>&1 || true; set +a; ./pronto-scripts/bin/pronto-migrate --check'`.
6. Ejecutar `cd pronto-scripts && ./bin/pronto-init-seed-review.sh`.
7. Ejecutar `rg -n --hidden --glob '!**/.git/**' --glob '!**/node_modules/**' --glob '!**/.venv/**' --glob '!pronto-docs/**' 'TODO|FIXME|HACK|XXX|@deprecated|deprecated|legacy|temporary|temporal' pronto-api/src pronto-client/src pronto-employees/src pronto-static/src pronto-libs/src pronto-scripts/bin pronto-tests/tests -S`.
8. Medir cambios locales por repo con `git -C <repo> status --short`.
RESULTADO_ACTUAL:
- `pronto-rules-check fast`, `pronto-inconsistency-check`, `pronto-api-parity-check employees`, `pronto-api-parity-check clients`, `pronto-no-legacy`, `pronto-no-runtime-ddl` y `pronto-file-naming-check` pasan.
- `pronto-migrate --check` falla con `pending=0 drift=1` y reporta `DRIFT: 20260215_03__fix_session_status_column.sql`.
- `pronto-init --check` falla por depender de ese mismo drift, aunque no reporta gaps estructurales adicionales (`gaps_*` vacíos).
- `pronto-init-seed-review.sh` pasa si se ejecuta desde `pronto-scripts`, pero falla desde el root agregador por asumir `git diff --cached` sobre un repo único; esto reduce ergonomía y cobertura del gate en auditorías lanzadas desde workspace root.
- Hay deuda técnica activa en código fuente: `ACTIVE_DEBT_MARKERS=176` en runtime/tests/scripts activos.
- Persisten proxies y bridges temporales/deprecated en superficies productivas: `pronto-client/src/pronto_clients/routes/api/orders.py`, `pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py`, `pronto-employees/src/pronto_employees/routes/api/proxy_console_api.py`, `pronto-static/src/vue/clients/modules/cart-renderer.ts`, `pronto-static/src/vue/clients/modules/tables-manager.ts`, `pronto-static/src/vue/employees/waiter/modules/waiter/legacy/card-renderer.ts`.
- El monorepo mantiene archivos monolíticos grandes (`LARGE_FILES_GE_700=28`), encabezados por `pronto-libs/src/pronto_shared/services/order_service_impl.py` (2610 líneas), `WaiterBoard.vue` (2291), `client-base.ts` (2010) y `tables-manager.ts` (1051).
- Hay alto volumen de trabajo local simultáneo: `pronto-docs` 301 cambios, `pronto-scripts` 146, `pronto-static` 105, `pronto-api` 16, `pronto-employees` 14, `pronto-libs` 14, `pronto-tests` 8, `pronto-client` 5.
RESULTADO_ESPERADO: El monorepo debe pasar parity/guardrails y además estar sincronizado en init+migrations+DB sin drift, con deuda técnica activa bajo control, módulos temporales con retiro claro y un nivel de cambios locales que no comprometa la alineación entre repos.
UBICACION:
- pronto-scripts/init/sql/migrations/20260215_03__fix_session_status_column.sql
- pronto-static/src/vue/clients/modules/tables-manager.ts
- pronto-static/src/vue/clients/modules/cart-renderer.ts
- pronto-client/src/pronto_clients/routes/api/orders.py
- pronto-client/src/pronto_clients/routes/api/stripe_webhooks.py
- pronto-employees/src/pronto_employees/routes/api/proxy_console_api.py
- pronto-libs/src/pronto_shared/services/order_service_impl.py
- pronto-static/src/vue/employees/waiter/components/WaiterBoard.vue
- pronto-static/src/vue/clients/modules/client-base.ts
EVIDENCIA:
- `rules_fast EXIT=0`, `parity_employees EXIT=0`, `parity_clients EXIT=0`, `no_legacy EXIT=0`, `no_runtime_ddl EXIT=0`.
- `init_check EXIT=1` con `gaps_* = []` pero `pronto_migrate_check.returncode = 1`.
- `migrate_check EXIT=1` con `pending=0 drift=1` y `DRIFT: 20260215_03__fix_session_status_column.sql`.
- `./pronto-scripts/bin/pronto-init-seed-review.sh` desde root falla con `error: unknown option cached`; `cd pronto-scripts && ./bin/pronto-init-seed-review.sh` devuelve `EXIT=0`.
- `pronto-scripts/init/sql/migrations/20260215_03__fix_session_status_column.sql` aumenta `pronto_dining_sessions.status` a `VARCHAR(50)` por el valor `awaiting_payment_confirmation`.
- `pronto-libs/src/pronto_shared/models/order_models.py:96` ya define `DiningSession.status` como `String(50)`; por tanto el drift es real entre DB/init y modelo canónico.
- `tables-manager.ts` líneas 2-14: `@deprecated`, `TODO` de split a Vue y lista explícita de problemas (`memory leak`, `innerHTML`, listeners sin cleanup, tamaño excesivo).
- `cart-renderer.ts` líneas 3-5: `@deprecated` y `TODO: Remove once CartPanel.vue is fully integrated`.
- `stripe_webhooks.py` líneas 4-13 y 31-41: módulo `DEPRECATED` y proxy técnico temporal que aún vive en `pronto-client`.
- `proxy_console_api.py` líneas 1-5: proxy `DEPRECATED` temporal para routing scope-aware.
HIPOTESIS_CAUSA: La sincronización funcional entre proyectos mejoró vía parity y guardrails, pero el monorepo sigue en una migración por fases: conviven contratos ya endurecidos con deuda legacy/temporal aún activa y con un drift de migración pendiente de aplicar o reconciliar contra el estado real de la base local.
ESTADO: ABIERTO

