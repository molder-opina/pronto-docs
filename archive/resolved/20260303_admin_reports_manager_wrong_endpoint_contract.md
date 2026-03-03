ID: ERR-20260303-ADMIN-REPORTS-MANAGER-WRONG-ENDPOINT-CONTRACT
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Vista de Reportes en admin consulta `/api/reports` inexistente y no usa el contrato real de analytics
DESCRIPCION: La vista `/admin/dashboard/reports` llama a `/api/reports?start_date=...&end_date=...&grouping=...`, pero el backend expone reportes por endpoints separados (`/api/reports/sales`, `/top-products`, `/peak-hours`, `/waiter-tips`). Esto provoca `404 NOT FOUND` y deja la pantalla sin datos.
PASOS_REPRODUCIR:
1. Ingresar a `/admin/dashboard/reports`.
2. Elegir fechas y pulsar `Buscar`.
3. Observar `404` en `GET /admin/api/reports?...`.
RESULTADO_ACTUAL: La vista muestra error `Recurso no encontrado`.
RESULTADO_ESPERADO: La vista debe cargar reportes consumiendo los endpoints reales del backend y tolerar fallas parciales por bloque.
UBICACION: pronto-static/src/vue/employees/shared/components/ReportsManager.vue
EVIDENCIA: Consola del navegador con `GET http://localhost:6081/admin/api/reports?... [HTTP/1.1 404 NOT FOUND]`.
HIPOTESIS_CAUSA: El componente Vue quedó acoplado a un agregador `/api/reports` que no existe en el contrato actual.
ESTADO: RESUELTO
SOLUCION: `ReportsManager.vue` dejó de consultar `/api/reports` y ahora consume los endpoints reales `/api/reports/sales`, `/top-products`, `/peak-hours` y `/waiter-tips`, usando los nombres de parámetros válidos (`start_date`, `end_date`, `group_by`) y normalizando los envelopes actuales. La vista también tolera fallas parciales por bloque para no caer completa por un solo reporte.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
