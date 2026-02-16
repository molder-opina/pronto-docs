---
ID: ERR-20260205-CLIENT-PROMOTIONS-MISMATCH
FECHA: 2026-02-05
PROYECTO: pronto-client
SEVERIDAD: baja
TITULO: Debug panel cliente llama /api/promotions pero pronto-client expone /api/promotions/active
DESCRIPCION: El debug_panel del cliente hace fetch a /api/promotions, pero en pronto-client el blueprint de promociones expone /api/promotions/active (y validación de códigos). Esto provoca 404 en el panel de debug y confunde QA/manual checks.
PASOS_REPRODUCIR: 1) Abrir debug panel en cliente. 2) Ejecutar “Ver promociones”. 3) Observar request a /api/promotions.
RESULTADO_ACTUAL: 404 en /api/promotions.
RESULTADO_ESPERADO: Debug panel usa /api/promotions/active o se crea alias /api/promotions coherente con el contrato.
UBICACION: pronto-client/src/pronto_clients/templates/debug_panel.html:809-819; pronto-client/src/pronto_clients/routes/api/promotions.py:13-14
EVIDENCIA: fetch('/api/promotions') en debug_panel.html; ruta existente @promotions_bp.get(\"/promotions/active\") en promotions.py.
HIPOTESIS_CAUSA: Cambio de contrato (active vs list) no propagado a debug panel.
ESTADO: RESUELTO
---

SOLUCION:
Se agrego alias `GET /api/promotions` en `pronto-client` apuntando a `/api/promotions/active`.

COMMIT:
ba06b96

FECHA_RESOLUCION:
2026-02-05
