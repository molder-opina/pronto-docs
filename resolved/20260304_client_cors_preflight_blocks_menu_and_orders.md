ID: 20260304_client_cors_preflight_blocks_menu_and_orders
FECHA: 2026-03-04
PROYECTO: pronto-static, pronto-client, pronto-api
SEVERIDAD: alta
TITULO: Cliente en 6080 falla por CORS preflight al llamar directo a 6082 con X-PRONTO-CUSTOMER-REF
DESCRIPCION:
La vista de cliente (`http://localhost:6080/?view=profile&tab=login`) queda visualmente rota porque el frontend intenta consumir `http://localhost:6082/api/menu` y `http://localhost:6082/api/session/<id>/orders` desde el navegador. El preflight CORS rechaza `X-PRONTO-CUSTOMER-REF` y varias llamadas fallan con `ERR_FAILED`.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6080/?view=profile&tab=login`.
2. Revisar consola y pestaña Network.
3. Observar requests cross-origin a `http://localhost:6082/api/*`.
RESULTADO_ACTUAL:
El preflight CORS bloquea la carga de menú/órdenes y la UI se muestra incompleta.
RESULTADO_ESPERADO:
La consola cliente debe funcionar sin depender de CORS cross-origin en navegador para operaciones normales. El frontend debe usar rutas same-origin (`/api/*`) con proxy técnico SSR en 6080, y el backend canónico en 6082 debe mantenerse como autoridad de negocio.
UBICACION:
- pronto-static/src/vue/clients/config/api.ts
- pronto-static/src/vue/clients/core/http.ts
- pronto-client/src/pronto_clients/routes/api/*
- pronto-api/src/api_app/app.py
EVIDENCIA:
- Error: `Request header field x-pronto-customer-ref is not allowed by Access-Control-Allow-Headers in preflight response`.
- `GET http://localhost:6082/api/menu` bloqueado por CORS.
- `GET http://localhost:6082/api/session/<id>/orders` bloqueado en preflight.
HIPOTESIS_CAUSA:
El frontend cliente quedó apuntando directo a `:6082` en browser (`config/api.ts`) en lugar de resolver `/api/*` same-origin hacia el proxy técnico de `pronto-client` (`:6080`).
ESTADO: RESUELTO
SOLUCION:
Se eliminó el acceso browser directo a `http://localhost:6082` para la app cliente en desarrollo. `pronto-static` ahora resuelve `service=api` como same-origin (`/api/*`), delegando transporte al BFF técnico SSR de `pronto-client` en `:6080`. Además se reforzó cobertura Playwright para asegurar que el menú no dispare requests cross-origin a `:6082` ni warnings de CORS en consola.
COMMIT:
- pronto-static: 14194b3
- pronto-tests: 037f3c5
- pronto-scripts: 1cd5d66
- pronto-docs: 5957df0
FECHA_RESOLUCION: 2026-03-04
