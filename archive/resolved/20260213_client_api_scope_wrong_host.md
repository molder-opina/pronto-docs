ID: 20260213_client_api_scope_wrong_host
FECHA: 2026-02-13
PROYECTO: pronto-client, pronto-static
SEVERIDAD: bloqueante
TITULO: Host clientes 6080 expone /api y no enruta exclusivamente a pronto-api 6082
DESCRIPCION: El host de clientes (6080) todavía responde rutas /api locales, pero el comportamiento esperado es que toda llamada /api del frontend de clientes se resuelva exclusivamente en pronto-api (6082).
PASOS_REPRODUCIR: 1) Levantar stack 2) Ejecutar curl http://localhost:6080/api/menu 3) Observar que responde desde pronto-client en lugar de delegar solo a pronto-api.
RESULTADO_ACTUAL: 6080 expone /api/* y frontend puede resolver rutas relativas contra el propio host cliente.
RESULTADO_ESPERADO: 6080 no debe exponer /api/* (404) y frontend clientes debe consumir pronto-api en 6082.
UBICACION: pronto-client/src/pronto_clients/app.py, pronto-static/src/vue/clients/config/api.ts
EVIDENCIA: Requerimiento explícito del usuario: "en 6080 no deberia haber ningun /api todo deberia estar en 6082 sobre pronto-api".
HIPOTESIS_CAUSA: Registro heredado de blueprint API en pronto-client y configuración default relativa en wrapper HTTP de frontend clientes.
ESTADO: RESUELTO
SOLUCION: Se removió el registro del blueprint `/api` en pronto-client (host 6080) y se ajustó el frontend clientes para resolver `/api/*` contra `window.API_BASE` con fallback a `http://localhost:6082`. Además se corrigió pronto-api para responder correctamente en `GET /api/menu` y `GET /api/business-info`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-13
