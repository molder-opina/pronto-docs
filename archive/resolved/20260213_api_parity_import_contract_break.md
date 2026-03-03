ID: 20260213-API-PARITY-IMPORT-CONTRACT
FECHA: 2026-02-13
PROYECTO: pronto-api, pronto-libs
SEVERIDAD: alta
TITULO: Parity check bloqueado por contratos rotos de importación en servicios compartidos
DESCRIPCION: `pronto-api-parity-check` para empleados y clientes fallaba en tiempo de importación por símbolos faltantes en `pronto_shared` (`OrderValidationError`, `accept_transfer_request` y funciones de asignación de mesas), impidiendo construir `url_map` y validar paridad real de rutas/métodos.
PASOS_REPRODUCIR: 1) Ejecutar `./pronto-scripts/bin/pronto-api-parity-check employees`. 2) Ejecutar `./pronto-scripts/bin/pronto-api-parity-check clients`. 3) Ver ImportError antes del reporte de parity.
RESULTADO_ACTUAL: El proceso se detenía por ImportError y no entregaba validación útil de paridad.
RESULTADO_ESPERADO: El checker debe cargar aplicaciones en modo rutas-only y reportar únicamente diferencias reales de API.
UBICACION: `pronto-api/src/api_app/routes/employees/orders.py`, `pronto-libs/src/pronto_shared/services/order_write_service.py`, `pronto-libs/src/pronto_shared/services/waiter_table_assignment_service.py`
EVIDENCIA: ImportError de `OrderValidationError` y `accept_transfer_request` al ejecutar parity-check.
HIPOTESIS_CAUSA: Regresión por refactor parcial en `pronto-libs` que dejó contratos públicos incompletos/inconsistentes con consumidores en `pronto-api`.
ESTADO: RESUELTO

SOLUCION: Se restauraron contratos de compatibilidad en servicios compartidos: clase `OrderValidationError`, wrappers/funciones faltantes de table assignments y retornos consistentes para endpoints consumidores. Se corrigió uso de `create_order_service` en endpoint de órdenes de empleados.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-13
