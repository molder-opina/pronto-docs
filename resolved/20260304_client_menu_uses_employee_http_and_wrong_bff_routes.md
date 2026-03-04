ID: 20260304_client_menu_uses_employee_http_and_wrong_bff_routes
FECHA: 2026-03-04
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Menú de cliente usa wrapper HTTP de empleados y endpoints SSR del cliente resuelven a 6082
DESCRIPCION: La vista de cliente en `http://localhost:6080/?view=profile&tab=login` se degradaba visualmente porque el menú usaba un composable compartido que importaba el wrapper HTTP de empleados, disparando el error `No valid console scope found` en `/`. Además, endpoints SSR del cliente como `/api/shortcuts` y `/api/sessions/me` se resolvían contra `:6082` en lugar de `:6080`, generando 404/401 inconsistentes.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6080/?view=profile&tab=login`
2. Observar consola del navegador
3. Ver error `No valid console scope found`
4. Ver request `GET /api/shortcuts` hacia `http://localhost:6082/api/shortcuts`
RESULTADO_ACTUAL: La página de cliente se veía incompleta y la consola registraba errores de scope y rutas equivocadas.
RESULTADO_ESPERADO: El cliente debe usar su propio wrapper HTTP y sus endpoints SSR deben resolverse al mismo origen `:6080` cuando corresponda.
UBICACION: pronto-static/src/vue/clients/**, pronto-static/src/vue/shared/utils/use-menu.ts, pronto-static/src/vue/clients/core/http.ts
EVIDENCIA: Error de consola `No valid console scope found. URL must start with one of: waiter, chef, cashier, admin, system. Current path: /` y `GET http://localhost:6082/api/shortcuts 404`.
HIPOTESIS_CAUSA: Reutilización indebida de utilidades compartidas acopladas al contexto employees y resolución incompleta de endpoints SSR client-only dentro del wrapper HTTP de clientes.
ESTADO: RESUELTO
SOLUCION: Se creó un composable específico de cliente para el menú (`src/vue/clients/composables/use-menu.ts`) y se movieron `MenuPage` y `CheckoutOffers` a ese contexto. Además, el wrapper `src/vue/clients/core/http.ts` ahora trata como endpoints client-only a `/api/shortcuts`, `/api/feedback/questions`, `/api/sessions/me`, `/api/sessions/open` y `/api/sessions/table-context`, resolviéndolos al mismo origen `:6080`.
COMMIT: 6942544,339a224,e90598f
FECHA_RESOLUCION: 2026-03-04
