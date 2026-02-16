---
ID: ERR-20260205-CLIENT-TABLES-AREAS
FECHA: 2026-02-05
PROYECTO: pronto-static/pronto-client
SEVERIDAD: alta
TITULO: Cliente (tables-manager) llama /api/areas y /api/tables sin endpoints en pronto-client
DESCRIPCION: El módulo Vue de mesas/áreas en pronto-static (cliente) usa /api/areas y /api/tables, pero en pronto-client no existen rutas para esas URLs (pronto-client expone /api/config/tables y /api/debug/tables, no /api/tables). Esto causa 404 salvo que exista un proxy externo no documentado.
PASOS_REPRODUCIR: 1) Abrir la vista/módulo de mesas del cliente. 2) Ver requests a /api/areas y /api/tables. 3) Confirmar respuesta.
RESULTADO_ACTUAL: 404 en /api/areas y /api/tables.
RESULTADO_ESPERADO: Endpoints /api/areas y /api/tables implementados en pronto-client o ajuste del módulo para consumir el endpoint real (/api/config/tables u otro contrato).
UBICACION: pronto-static/src/vue/clients/modules/tables-manager.ts:392-407; 544-559
EVIDENCIA: fetch(\"/api/areas\") y fetch(\"/api/tables\") en tables-manager.ts; rg -n \"@.*(get|post|put|patch|delete)\\(\\\"/tables\\\"\" pronto-client/src/pronto_clients/routes/api -> existe /api/config/tables pero no /api/tables.
HIPOTESIS_CAUSA: UI migrada desde backend de empleados/API sin alinear el contrato de pronto-client.
ESTADO: RESUELTO
---

SOLUCION:
Se implemento `GET /api/areas` y endpoints faltantes de `tables` (GET `/api/tables/<id>` y `/api/tables/<id>/qr`) en `pronto-client`.

COMMIT:
ba06b96

FECHA_RESOLUCION:
2026-02-05
