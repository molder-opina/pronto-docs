ID: ERR-20260218-PARITY-ROUTE-ALIGNMENT-P1
FECHA: 2026-02-18
PROYECTO: pronto-client, pronto-static, pronto-employees
SEVERIDAD: alta
TITULO: API parity falla por desalineación de rutas frontend/backend y endpoint de login cliente faltante
DESCRIPCION: Los checks `pronto-api-parity-check employees|clients` reportan rutas no encontradas o método no inferible por desalineación de paths (`/api/sessions/*` vs `/api/session/*`, `/api/menu/items/*` vs `/api/menu-items/*`) y ausencia de endpoint `POST /api/login` en `pronto-client`.
PASOS_REPRODUCIR: 1) Ejecutar `./pronto-scripts/bin/pronto-api-parity-check employees`. 2) Ejecutar `./pronto-scripts/bin/pronto-api-parity-check clients`. 3) Revisar bloques `missing_known_method`.
RESULTADO_ACTUAL: Parity retorna `ok:false` para employees y clients con rutas faltantes.
RESULTADO_ESPERADO: Parity sin faltantes para rutas corregibles en esta fase.
UBICACION: pronto-client/src/pronto_clients/routes/api/auth.py, pronto-client/src/pronto_clients/routes/api/payments.py, pronto-static/src/vue/clients/store/orders.ts, pronto-static/src/vue/clients/modules/session-timeout.ts, pronto-static/src/vue/employees/components/areas/AreaEditorModal.vue, pronto-static/src/vue/employees/components/menu/ProductEditorDrawer.vue, pronto-static/src/vue/employees/views/menu/MenuEditor.vue, pronto-static/src/vue/employees/components/menu/ModifierEditorDrawer.vue
EVIDENCIA: Salida de parity-check (clients/employees) con `missing_known_method` para `/api/login`, `/api/session/{var}/timeout`, `/api/sessions/{var}/orders`, `/api/sessions/{var}/request-check`, `/api/menu/items*`, `/api/areas/{var}`, `/api/modifiers/{var}`.
HIPOTESIS_CAUSA: Migraciones de arquitectura a rutas canónicas sin actualización completa de módulos frontend y endpoints de compatibilidad.
ESTADO: RESUELTO
SOLUCION: Se agregó `POST /api/login` en `pronto-client`, se añadió endpoint de compatibilidad `GET /api/session/<uuid:session_id>/timeout`, se alinearon rutas de frontend cliente a `/api/session/*` y se normalizaron rutas de frontend empleados a `/api/menu-items/*`. Además, se eliminaron referencias legacy que rompían inferencia de parity (`/api/orders/{id}/print` y endpoint dinámico ambiguo en KDS) y se sustituyeron por mapeo explícito de acciones.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
