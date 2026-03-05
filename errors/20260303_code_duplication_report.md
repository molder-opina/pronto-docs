ID: CODE-20260303-028
FECHA: 2026-03-03
PROYECTO: pronto-root
SEVERIDAD: media
TITULO: Duplicación masiva de código utilitario y rutas en backend y frontend

DESCRIPCION: |
  Se ha detectado una duplicación significativa de funciones y lógica en varios componentes del monorepo. Esto aumenta el costo de mantenimiento y el riesgo de inconsistencias.

  Hallazgos en Backend:
  1. `_ensure_session`: Duplicado en 6 archivos de analítica en `pronto_shared/services`. Debería estar en `pronto_shared.db`.
  2. `get_public_config`: La ruta de API está implementada independientemente en `pronto-api`, `pronto-client` y `pronto-employees`.
  3. `process_login`: Lógica de autenticación duplicada en los 5 blueprints de rol de `pronto-employees`.

  Hallazgos en Frontend:
  1. `useMenu`: Composable duplicado en `src/vue/clients/composables/` y `src/vue/shared/utils/`.
  2. `showNotification` / `playNotificationSound`: Duplicados entre `shared` y módulos específicos.
  3. `getTimeAgo`: Lógica de formateo de tiempo duplicada en `formatting.ts` y `ui-utils.ts`.

RESULTADO_ACTUAL: |
  Múltiples implementaciones de la misma lógica dispersas por el codebase.

RESULTADO_ESPERADO: |
  Centralizar todas las utilidades comunes en `pronto_shared` (backend) y `src/vue/shared` (frontend). Las rutas de API comunes deben ser gestionadas únicamente por `pronto-api` o mediante un helper compartido en `pronto_shared`.

UBICACION: |
  - `pronto-libs/src/pronto_shared/services/analytics/`
  - `pronto-api/src/api_app/routes/`
  - `pronto-employees/src/pronto_employees/routes/`
  - `pronto-static/src/vue/`

ESTADO: ABIERTO

ACCIONES_PENDIENTES:
  - [ ] Mover `_ensure_session` a `pronto_shared.db`.
  - [ ] Unificar `get_public_config` en un servicio compartido.
  - [ ] Consolidar los composables de frontend en la carpeta `shared/composables`.
  - [ ] Refactorizar el formateo de fechas en el frontend para usar una única utilidad.
