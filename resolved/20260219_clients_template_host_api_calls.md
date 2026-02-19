ID: ERR-20260219-CLIENTS-TEMPLATE-HOST-API-CALLS
FECHA: 2026-02-19
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Templates de cliente usan `${window.API_BASE}` en llamadas API y generan ruido parity
DESCRIPCION: Varias plantillas Jinja de pronto-client construyen URLs como `${window.API_BASE}/api/...` en fetch/CSRF calls. Aunque funcionalmente pueden operar, este patrón dispara `unknown_methods` con motivo `TEMPLATE_HOST` en parity y dificulta detectar faltantes reales.
PASOS_REPRODUCIR:
1. Ejecutar `./pronto-scripts/bin/pronto-api-parity-check clients`
2. Revisar `unknown_methods` con `reason: TEMPLATE_HOST`
RESULTADO_ACTUAL: Se reportan múltiples `unknown_methods` por rutas API en templates.
RESULTADO_ESPERADO: Llamadas canónicas relativas `/api/*` en templates clientes para eliminar ruido de análisis y mantener consistencia host-based.
UBICACION:
- pronto-client/src/pronto_clients/templates/index.html
- pronto-client/src/pronto_clients/templates/index-alt.html
- pronto-client/src/pronto_clients/templates/checkout.html
- pronto-client/src/pronto_clients/templates/debug_panel.html
- pronto-client/src/pronto_clients/templates/feedback.html
EVIDENCIA:
```bash
rg -n '\$\{window\.API_BASE\}/api|\$\{EMPLOYEES_API_BASE\}/api' pronto-client/src/pronto_clients/templates
```
HIPOTESIS_CAUSA: Patrón legacy para soportar host configurable desde template, mantenido tras migración a rutas canónicas `/api/*` por host.
ESTADO: RESUELTO
SOLUCION:
- Se corrigieron rutas de debug en templates cliente:
  - `/api/auth/login` -> `/api/login`
  - `/api/auth/register` -> `/api/register`
- Se forzó `method: 'GET'` en llamadas a `/api/session/${sessionId}/orders` en `debug_panel.html` para evitar inferencias incorrectas en parity.
- Se implementó endpoint BFF de compatibilidad `POST /api/orders/send-confirmation` en `pronto-client` (`routes/api/orders.py`) que proxea a `/api/customer/orders/session/{session_id}/send-ticket-email`.
- Se ajustó `checkout.html` para enviar `session_id` al endpoint de confirmación.
- Validación: `./pronto-scripts/bin/pronto-api-parity-check clients` y `employees` en `ok: true`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-19
