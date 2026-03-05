ID: ERR-20260303-DEFAULT-PAGINATION-SETTING-NOT-APPLIED-IN-UI
FECHA: 2026-03-03
PROYECTO: pronto-static, pronto-employees, pronto-api
SEVERIDAD: media
TITULO: El parámetro system.api.items_per_page no gobierna la paginación por defecto en UI
DESCRIPCION: En `/admin/dashboard/config` existe el parámetro `system.api.items_per_page`, pero la UI de paginación seguía inicializando con valores hardcodeados o quedaba pisada por la llave legacy `items_per_page`, sin tomar el valor canónico del backend como default efectivo.
PASOS_REPRODUCIR:
1. Verificar en configuración que `system.api.items_per_page` tenga un valor distinto al default hardcodeado.
2. Abrir una vista con paginación en el panel de empleados.
3. Observar el valor inicial mostrado o el bootstrap global de `window.APP_CONFIG.items_per_page`.
RESULTADO_ACTUAL: La paginación inicial usaba `20` o quedaba fijada por la llave legacy `items_per_page=10`, aun cuando el parámetro canónico `system.api.items_per_page` tenía otro valor en base de datos.
RESULTADO_ESPERADO: Si no existe una preferencia local explícita, la paginación debe usar `system.api.items_per_page` como valor inicial por defecto del sistema.
UBICACION: pronto-static/src/vue/shared/components/PaginationControls.vue; pronto-static/src/vue/shared/composables/usePagination.ts; pronto-static/src/vue/employees/shared/modules/promotions-manager.ts; pronto-static/src/vue/employees/shared/modules/recommendations-manager.ts; pronto-static/src/vue/employees/shared/store/config.ts; pronto-employees/src/pronto_employees/routes/api/config.py; pronto-api/src/api_app/routes/employees/config.py
EVIDENCIA: Revisión de código y validación en navegador: `window.APP_CONFIG.items_per_page` permanecía en `10` mientras la base tenía `system.api.items_per_page=25`. También se detectó coexistencia de la llave legacy `items_per_page=10`.
HIPOTESIS_CAUSA: La configuración pública no exponía `items_per_page` desde la llave canónica `system.api.items_per_page`, varios módulos de paginación seguían con defaults hardcodeados, y el store priorizaba la llave legacy `items_per_page` sobre la canónica.
ESTADO: RESUELTO
SOLUCION: Se expuso `items_per_page` en las rutas públicas de configuración de `pronto-employees` y `pronto-api` usando `system.api.items_per_page`; la capa compartida de paginación (`PaginationControls`, `usePagination`, `PromotionsManager`, `RecommendationsManager`) ahora usa `window.APP_CONFIG.items_per_page` como default del sistema; y `ConfigStore.syncToWindow()` pasó a priorizar `system.api.items_per_page` sobre la llave legacy `items_per_page`.
COMMIT:
FECHA_RESOLUCION: 2026-03-03
