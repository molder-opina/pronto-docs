ID: ERR-20260304-AUTH-ERROR-SCOPE-REDIRECT
FECHA: 2026-03-04
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Las rutas /chef|/cashier/authorization-error redirigen a login antes de renderizar la pantalla de acceso denegado
DESCRIPCION: La vista de error de autorización en consolas chef y cashier no llega a mostrarse en carga inicial sin sesión; la SPA dispara fetch de autenticación y termina navegando a login.
PASOS_REPRODUCIR: 1) Navegar a /chef/authorization-error?code=403&message=...&from=/chef/dashboard/kitchen 2) Repetir en /cashier/authorization-error 3) Observar navegación automática.
RESULTADO_ACTUAL: En ambos scopes se realiza GET /<scope>/api/auth/me (401) y la app redirige a /<scope>/login; no aparece el encabezado "Acceso Denegado".
RESULTADO_ESPERADO: Debe renderizarse AuthorizationError.vue en /<scope>/authorization-error sin intentar auth bootstrap, y el botón "Ir a Login" debe controlar la salida.
UBICACION:
- pronto-static/src/vue/employees/shared/core/http.ts
- pronto-static/src/vue/employees/App.vue
EVIDENCIA: Fallos en Playwright: employees/authorization-error-scope.spec.ts y employees/scoped-authorization-error.spec.ts (4 casos fallando).
HIPOTESIS_CAUSA: El interceptor HTTP redirigía a login para cualquier 401 salvo ruta de login; no contemplaba explícitamente que /authorization-error también debe ser ruta pública durante el flujo de error.
ESTADO: RESUELTO
SOLUCION:
- `checkAuthAndRedirect()` ahora omite redirección a login para respuestas 401 cuando la ruta actual es `/<scope>/authorization-error`.
- Se mantiene la protección de redirección para el resto de rutas protegidas.
- `App.vue` ahora detecta rutas `login` y `authorization-error` usando tanto `route.path` como `window.location.pathname` para evitar carreras en el bootstrap inicial.
- Con esto, la vista `AuthorizationError.vue` alcanza a renderizarse y la navegación a login ocurre solo por acción del usuario (`Ir a Login`).
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-04
