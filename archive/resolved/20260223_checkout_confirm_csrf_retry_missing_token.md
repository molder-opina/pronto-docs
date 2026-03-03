ID: BUG-20260223-CHK-CSRF-002
FECHA: 2026-02-23
PROYECTO: pronto-client / pronto-static
SEVERIDAD: bloqueante
TITULO: Confirmar pedido falla con CSRF Error en sesión activa sin refresco de token
DESCRIPCION: En algunos escenarios con sesión activa, el checkout envía un token CSRF inválido/expirado y el backend responde 400 CSRF Error al confirmar pedido.
PASOS_REPRODUCIR:
1. Iniciar sesión y navegar en cliente por un periodo o recargar con estado previo.
2. Ir a Detalles con productos en carrito.
3. Presionar Confirmar Pedido.
RESULTADO_ACTUAL: Respuesta 400 en /api/customer/orders con error CSRF y la orden no se crea.
RESULTADO_ESPERADO: El cliente debe recuperar token CSRF válido y confirmar la orden sin bloquear al usuario.
UBICACION: pronto-client/src/pronto_clients/templates/index.html, pronto-client/src/pronto_clients/routes/api/auth.py
EVIDENCIA: Validación local: `POST /api/customer/orders` con token inválido retorna 400 (`The CSRF token is invalid.`) y con token refrescado via `/api/auth/csrf` retorna 201 con `order_id`.
HIPOTESIS_CAUSA: Rotación/expiración de token en sesión activa y flujo de checkout con fetch directo sin mecanismo de refresh/retry de CSRF.
ESTADO: RESUELTO
SOLUCION: Se agregó endpoint autenticado `GET /api/auth/csrf` para renovar token y en checkout se implementó retry automático una sola vez: ante 400 con error CSRF, solicita token nuevo, actualiza meta csrf-token y reintenta creación de orden.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
