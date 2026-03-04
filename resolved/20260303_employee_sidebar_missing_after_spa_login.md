ID: 20260303_employee_sidebar_missing_after_spa_login
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: El layout lateral no aparece tras login SPA hasta recargar la página
DESCRIPCION: Después de iniciar sesión en las consolas de empleados, el router navega al dashboard pero el shell autenticado no monta sidebar ni header hasta hacer refresh manual.
PASOS_REPRODUCIR:
1. Entrar a `/waiter/login`, `/chef/login`, `/cashier/login` o `/admin/login`
2. Iniciar sesión correctamente
3. Observar el dashboard inmediatamente después del redirect SPA
RESULTADO_ACTUAL: Se renderiza solo el contenido interno del dashboard sin layout lateral ni header; al recargar manualmente el navegador, el shell aparece.
RESULTADO_ESPERADO: El login debe montar inmediatamente el layout autenticado completo sin requerir recarga manual.
UBICACION:
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/App.vue
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/views/StaffLogin.vue
EVIDENCIA: Reproducción visual en `http://localhost:6081/waiter/dashboard/waiter` tras login SPA sin refresh; el contenido aparece sin sidebar ni header.
HIPOTESIS_CAUSA: La detección de rutas guest/login usa `window.location.pathname` dentro de `computed`, lo que no reacciona al cambio de ruta hecho por Vue Router, dejando `showAuthenticatedLayout` bloqueado en estado guest hasta un reload completo.
ESTADO: RESUELTO
SOLUCION: `App.vue` dejó de derivar `isLoginPath` y `isAuthorizationErrorPath` desde `window.location.pathname` y ahora usa `route.path` reactivo. Eso permite que, al hacer `router.push()` después del login, el shell autenticado reevalúe de inmediato y monte sidebar/header sin recargar la página. Se añadió cobertura Playwright para validar que el login en `/waiter` renderiza el layout autenticado completo sin refresh manual.
COMMIT: 69098e8, 6542df8, 88bd82b
FECHA_RESOLUCION: 2026-03-03
