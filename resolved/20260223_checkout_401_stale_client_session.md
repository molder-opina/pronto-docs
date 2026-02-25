ID: BUG-20260223-CHK-AUTH-003
FECHA: 2026-02-23
PROYECTO: pronto-client / pronto-static
SEVERIDAD: bloqueante
TITULO: Checkout devuelve 401 "No autenticado" con UI mostrando sesión iniciada
DESCRIPCION: El cliente puede mostrar usuario autenticado en avatar/perfil por datos locales, pero al confirmar pedido el backend responde 401 por sesión real inválida/ausente.
PASOS_REPRODUCIR:
1. Abrir cliente con datos locales de usuario persistidos.
2. Navegar a Detalles con carrito.
3. Confirmar pedido.
RESULTADO_ACTUAL: POST /api/customer/orders responde 401 "No autenticado" y UI sigue aparentando sesión activa.
RESULTADO_ESPERADO: El estado de sesión en UI debe reflejar sesión real de servidor y checkout debe pedir reautenticación al detectar 401.
UBICACION: pronto-static/src/vue/clients/modules/client-profile.ts, pronto-client/src/pronto_clients/templates/index.html
EVIDENCIA: Consola del usuario: POST /api/customer/orders -> 401 con mensaje visual "No autenticado" mientras avatar/perfil muestran usuario logueado.
HIPOTESIS_CAUSA: Fuente de verdad de auth en frontend depende de localStorage sin reconciliación obligatoria contra /api/auth/me; sesión servidor pudo expirar/reiniciarse.
ESTADO: RESUELTO
SOLUCION: Se agregó reconciliación de sesión real al inicializar perfil (`GET /api/auth/me`) para limpiar estado local inválido y sincronizar avatar/sesión. En checkout se añadió manejo explícito de 401 para limpiar sesión local fantasma, mostrar mensaje de sesión expirada y abrir modal de autenticación.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
