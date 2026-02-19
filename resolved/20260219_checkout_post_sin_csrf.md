ID: ERR-20260219-CHECKOUT-POST-CSRF
FECHA: 2026-02-19
PROYECTO: pronto-client
SEVERIDAD: bloqueante
TITULO: Checkout cliente falla por mutaciones POST sin token CSRF
DESCRIPCION: El flujo de checkout en template Jinja ejecuta POST a `/api/orders` y `/api/orders/send-confirmation` con `fetch` directo sin enviar `X-CSRFToken`, aunque CSRF esta habilitado y obligatorio en pronto-client.
PASOS_REPRODUCIR:
1) Abrir `/checkout` en pronto-client.
2) Completar el formulario y enviar pedido.
3) Observar respuesta del endpoint de creacion de orden.
RESULTADO_ACTUAL: El backend responde error CSRF (400) por token faltante y bloquea el flujo de checkout.
RESULTADO_ESPERADO: El cliente debe enviar `X-CSRFToken` (tomado de `<meta name="csrf-token">`) en todas las mutaciones POST/PUT/DELETE para que el pedido se cree correctamente.
UBICACION: /Users/molder/projects/github-molder/pronto/pronto-client/src/pronto_clients/templates/checkout.html:712, /Users/molder/projects/github-molder/pronto/pronto-client/src/pronto_clients/templates/checkout.html:738, /Users/molder/projects/github-molder/pronto/pronto-client/src/pronto_clients/app.py:64
EVIDENCIA: Codigo en checkout usa `fetch(..., { method: 'POST', headers: { 'Content-Type': 'application/json' } })` sin `X-CSRFToken`. Validacion manual previa: `POST /api/orders` retorno `400 {"error":"CSRF Error","details":"The CSRF token is missing."}`.
HIPOTESIS_CAUSA: Se bypass del wrapper canonico con CSRF (request helper) durante refactor de templates legacy a flujo JS inline.
ESTADO: RESUELTO
SOLUCION: Se agregó extracción de token desde `<meta name="csrf-token">` en `checkout.html` y se envía `X-CSRFToken` en `POST /api/orders` y `POST /api/orders/send-confirmation`. Si el token falta, el flujo falla con mensaje explícito para evitar requests inválidos.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-19
