---
ID: ERR-20260204-DOCS-NOTIF-ROUTES
FECHA: 2026-02-04
PROYECTO: pronto-docs
SEVERIDAD: baja
TITULO: Docs incluyen endpoints legacy de notificaciones
DESCRIPCION: La documentacion de pronto-employees y pronto-clients lista endpoints /api/notifications/send y /api/notifications/mark-read que no forman parte del contrato "cero legacy" ni existen en el backend. Esto genera confusion y contratos inconsistentes.
PASOS_REPRODUCIR: 1) Abrir pronto-docs/pronto-employees/README.md y pronto-docs/pronto-clients/README.md. 2) Buscar referencias a /api/notifications/send o /api/notifications/mark-read.
RESULTADO_ACTUAL: Se listan endpoints legacy que no existen.
RESULTADO_ESPERADO: La documentacion solo debe listar las rutas vigentes del contrato de notificaciones.
UBICACION: pronto-docs/pronto-employees/README.md:267-268; pronto-docs/pronto-clients/README.md:99
EVIDENCIA: `POST /api/notifications/send`, `POST /api/notifications/mark-read`.
HIPOTESIS_CAUSA: Documentacion no actualizada tras el cambio de contrato.
ESTADO: RESUELTO
SOLUCION: Se actualizaron los README de pronto-employees y pronto-clients para listar solo rutas vigentes de notificaciones/waiter calls.
COMMIT: uncommitted
FECHA_RESOLUCION: 2026-02-04
---
