ID: ERR-20260223-CHECKOUT-REQUIRES-AUTH
FECHA: 2026-02-23
PROYECTO: pronto-static / pronto-client
SEVERIDAD: alta
TITULO: Ir a pagar sin sesión no solicita login/registro y no retoma flujo a Detalles
DESCRIPCION: Cuando el usuario intenta ir a pagar sin sesión autenticada, el flujo no obliga login/registro en ese momento y no garantiza retorno automático al tab Detalles para confirmar la orden.
PASOS_REPRODUCIR:
1. Abrir cliente en http://localhost:6080 sin sesión autenticada.
2. Agregar productos al carrito.
3. Hacer clic en "Ir a pagar".
RESULTADO_ACTUAL: El flujo puede regresar al menú o no forzar autenticación previa al paso de confirmación.
RESULTADO_ESPERADO: Si no hay sesión autenticada, abrir formulario de login/registro; al autenticarse, navegar automáticamente a tab Detalles para confirmar la orden.
UBICACION: pronto-static/src/vue/clients/modules/client-base.ts; pronto-static/src/vue/clients/modules/client-profile.ts
EVIDENCIA: Reporte de usuario en sesión actual.
HIPOTESIS_CAUSA: Falta validación explícita de auth en proceedToCheckout y ausencia de mecanismo de intención pendiente post-login.
ESTADO: RESUELTO
SOLUCION: Se añadió bridge de autenticación en checkout: `proceedToCheckout` guarda intención pendiente (`pronto-checkout-after-auth`), valida sesión con `GET /api/auth/me`, abre modal de perfil (`toggleProfile`) cuando no hay sesión y consume la intención al recibir `pronto:auth-success`, redirigiendo automáticamente a `switchView('details')`. Además `client-profile` ahora emite `pronto:auth-success` después de login/registro exitoso y sincroniza `window.APP_SESSION.customer`.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
