ID: 20260213_reopen_call_waiter_preflight_404
FECHA: 2026-02-13
PROYECTO: pronto-static, pronto-client
SEVERIDAD: bloqueante
TITULO: Reapertura - call waiter falla por preflight 404 al resolver /api en host incorrecto
DESCRIPCION: Reaparece el fallo al llamar mesero desde clientes. El frontend Vue de clientes resuelve `/api/call-waiter` contra `http://localhost:6082`, pero ese endpoint de clientes está en `pronto-client` (host 6080). Referencia de incidencia previa: 20260213_client_api_scope_wrong_host.
PASOS_REPRODUCIR: 1) Abrir cliente en http://localhost:6080. 2) Hacer click en "llamar mesero". 3) Revisar network: OPTIONS/POST a `http://localhost:6082/api/call-waiter`.
RESULTADO_ACTUAL: Preflight OPTIONS retorna 404 y el navegador bloquea la solicitud CORS; la llamada al mesero no se registra.
RESULTADO_ESPERADO: El frontend debe resolver `/api/call-waiter` en el host cliente (`http://localhost:6080/api/call-waiter`) para evitar CORS cross-origin y usar la ruta correcta.
UBICACION: pronto-static/src/vue/clients/config/api.ts, pronto-static/src/vue/clients/core/http.ts
EVIDENCIA: Traza de consola/red compartida por usuario con `CORS Preflight Did Not Succeed`, `OPTIONS http://localhost:6082/api/call-waiter 404` y bloqueo de `POST /api/call-waiter`.
HIPOTESIS_CAUSA: Configuración por defecto del wrapper de API en clientes (`api`) apunta a `window.API_BASE`/`localhost:6082`, forzando host central en rutas que deben resolverse por host cliente.
ESTADO: RESUELTO
SOLUCION: Se ajustó `pronto-static/src/vue/clients/config/api.ts` para que el servicio `api` sea relativo por defecto (`''`) y no fuerce `window.API_BASE`/`localhost:6082`. Con esto, las llamadas `/api/*` del frontend clientes vuelven a resolverse contra el host cliente (6080), eliminando el preflight cross-origin 404 en `call-waiter`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-13
