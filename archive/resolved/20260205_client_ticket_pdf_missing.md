---
ID: ERR-20260205-CLIENT-TICKET-PDF
FECHA: 2026-02-05
PROYECTO: pronto-static/pronto-client
SEVERIDAD: alta
TITULO: Cliente intenta descargar /api/sessions/<id>/ticket.pdf pero no existe endpoint
DESCRIPCION: El módulo de órdenes activas en clientes intenta descargar un PDF de ticket usando /api/sessions/<id>/ticket.pdf. No existe ruta equivalente en pronto-client (ni en pronto-api) para servir ese PDF.
PASOS_REPRODUCIR: 1) En cliente, abrir pantalla con órdenes activas. 2) Click en “Descargar PDF”/acción equivalente. 3) Observar request a /api/sessions/<id>/ticket.pdf.
RESULTADO_ACTUAL: 404 en /api/sessions/<id>/ticket.pdf.
RESULTADO_ESPERADO: Endpoint disponible que genere/retorne PDF del ticket de sesión, o deshabilitar UI si no existe esa capacidad.
UBICACION: pronto-static/src/vue/clients/modules/active-orders.ts:1825-1849
EVIDENCIA: fetch(`/api/sessions/${sessionId}/ticket.pdf`) en active-orders.ts; rg -n \"ticket\\.pdf\" pronto-client/src/pronto_clients/routes/api -> sin resultados.
HIPOTESIS_CAUSA: Feature de PDF planeada en UI pero no implementada en backend.
ESTADO: RESUELTO
---

SOLUCION:
Se implemento `GET /api/sessions/<id>/ticket.pdf` en `pronto-client` usando `ticket_pdf_service`.

COMMIT:
ba06b96

FECHA_RESOLUCION:
2026-02-05
