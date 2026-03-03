ID: 20260213_client_call_waiter_post_404_on_6080
FECHA: 2026-02-13
PROYECTO: pronto-client, pronto-static
SEVERIDAD: bloqueante
TITULO: POST /api/call-waiter retorna 404 en host clientes 6080
DESCRIPCION: Tras corregir el origen de llamadas en frontend clientes, `callWaiter()` ya apunta a `http://localhost:6080/api/call-waiter`, pero el endpoint respondía 404 y la funcionalidad quedaba inoperante.
PASOS_REPRODUCIR: 1) Abrir `http://localhost:6080`. 2) Invocar `window.callWaiter()` desde UI. 3) Observar `POST /api/call-waiter` con status 404.
RESULTADO_ACTUAL: La llamada a mesero no se registra por respuesta 404 del endpoint.
RESULTADO_ESPERADO: `POST /api/call-waiter` debe existir en host clientes y responder 2xx/4xx de negocio, no 404 de ruta inexistente.
UBICACION: pronto-client/src/pronto_clients/app.py, pronto-client/src/pronto_clients/routes/api/waiter_calls.py
EVIDENCIA: Validación posterior al redeploy: `OPTIONS /api/call-waiter` devuelve 200 y `POST /api/call-waiter` devuelve 400 por CSRF faltante (ya no 404).
HIPOTESIS_CAUSA: Blueprint API de clientes no registrado en `create_app()`.
ESTADO: RESUELTO
SOLUCION: Se registró explícitamente `api_bp` con `url_prefix='/api'` en `pronto-client/src/pronto_clients/app.py`. Con ello, `POST /api/call-waiter` vuelve a existir en `localhost:6080`; además el preflight CORS a ese endpoint responde 200.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-13
