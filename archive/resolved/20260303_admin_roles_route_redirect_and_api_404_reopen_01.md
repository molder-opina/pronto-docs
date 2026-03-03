ID: ERR-20260303-ADMIN-ROLES-ROUTE-REDIRECT-AND-API-404-REOPEN-01
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin)
SEVERIDAD: alta
TITULO: Reapertura: vista de Roles redirige al dashboard base y consume endpoint legacy inexistente
DESCRIPCION: Al abrir `/admin/dashboard/roles`, la app preserva el contenido de la vista pero el shell cae a `dashboard-index`, mostrando tabs operativos en lugar de tabs administrativos. Además el módulo de RBAC intenta consultar `/api/employees/roles`, ruta que hoy responde 404 porque el blueprint real vive en `/api/roles/roles`.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/roles`.
2. Observar la URL/shell superior y la consola del navegador.
3. Ver que la app termina en el shell del dashboard base y que el fetch de roles falla con 404.
RESULTADO_ACTUAL: La vista de roles mezcla tabs incorrectos y no carga los datos RBAC por usar una ruta legacy inexistente.
RESULTADO_ESPERADO: La ruta `/admin/dashboard/roles` debe conservarse, mostrar tabs administrativos y cargar roles desde el endpoint real.
UBICACION: pronto-static/src/vue/employees/App.vue; pronto-static/src/vue/employees/shared/composables/use-rbac.ts; pronto-static/src/vue/employees/admin/components/EmployeesManager.vue
EVIDENCIA: Inspección Playwright en sesión mostró URL final `http://localhost:6081/admin/dashboard`, tabs operativos y error de red a `/admin/api/employees/roles?include_inactive=true`.
HIPOTESIS_CAUSA: `ensureAuthenticatedDashboardRoute()` fuerza `router.replace({ name: 'dashboard-index' })` aun cuando ya existe una ruta hija válida, y el frontend de roles sigue usando el path anterior al blueprint unificado de RBAC.
ESTADO: RESUELTO
SOLUCION: Se corrigió `ensureAuthenticatedDashboardRoute()` en `App.vue` para que solo redirija al `dashboard-index` cuando la ruta actual es el root `/dashboard`, preservando rutas hijas válidas como `/dashboard/roles`. Además, el frontend RBAC dejó de consumir la ruta legacy `/api/employees/roles` y ahora usa el endpoint real `/api/roles/roles`, restaurando la carga del módulo.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
