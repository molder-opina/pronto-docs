ID: 20260213_checkout_cors_preflight_xcsrftoken
FECHA: 2026-02-13
PROYECTO: pronto-api, pronto-static
SEVERIDAD: bloqueante
TITULO: Checkout cliente bloqueado por preflight CORS al enviar X-CSRFToken
DESCRIPCION: Las solicitudes `POST /api/orders` desde `http://localhost:6080` hacia `http://localhost:6082` fallaban en preflight porque la respuesta CORS no permitía el header `X-CSRFToken`.
PASOS_REPRODUCIR: 1) Abrir menú cliente en 6080. 2) Agregar productos y enviar checkout. 3) Ver en consola `CORS Missing Allow Header` para `x-csrftoken` en `OPTIONS /api/orders`.
RESULTADO_ACTUAL: Preflight CORS corregido y checkout operativo.
RESULTADO_ESPERADO: El preflight CORS acepta `X-CSRFToken` y permite `POST /api/orders`.
UBICACION: pronto-api/src/api_app/app.py
EVIDENCIA: `OPTIONS /api/orders` responde `Access-Control-Allow-Headers: content-type, x-csrftoken`; `npm run test:functionality` finaliza con 35/35.
HIPOTESIS_CAUSA: Desalineación entre header canónico frontend (`X-CSRFToken`) y allowlist CORS backend (`X-CSRF-Token`).
ESTADO: RESUELTO
SOLUCION: Se actualizó configuración CORS en API para permitir ambos headers (`X-CSRFToken` y `X-CSRF-Token`) manteniendo compatibilidad. Luego se reconstruyeron servicios y se validó preflight + suite funcional completa.
COMMIT: N/A (cambios locales en workspace)
FECHA_RESOLUCION: 2026-02-13
