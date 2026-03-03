ID: 20260303_scoped_authorization_error_routes_missing_for_chef_cashier
FECHA: 2026-03-03
PROYECTO: pronto-static, pronto-employees, pronto-libs, pronto-tests
SEVERIDAD: alta
TITULO: authorization-error scopeado no está soportado de forma consistente en chef y cashier
DESCRIPCION: Las consolas `chef` y `cashier` podían terminar en un flujo incorrecto de autorización porque el frontend trataba `authorization-error` como ruta scopeada, pero el SSR y el bootstrap no soportaban de forma consistente `/<scope>/authorization-error`, lo que podía terminar en loops hacia `/waiter/authorization-error` o redirección indebida a login.
PASOS_REPRODUCIR:
1. Entrar a una consola de empleados distinta a waiter
2. Provocar un 403 o reutilizar una pantalla de authorization-error previa
3. Intentar volver al login desde esa pantalla o navegar directo al login
4. Observar redirección errática o mezcla de contexto waiter en la URL de error
RESULTADO_ACTUAL: El usuario podía ver `/waiter/authorization-error?...from=/waiter/dashboard/waiter` aun intentando trabajar con `chef` o `cashier`, y al navegar a `/<scope>/authorization-error` el shell arrancaba `auth/me` y acababa en `/<scope>/login`.
RESULTADO_ESPERADO: Cada scope debe tener ruta SSR válida `/<scope>/authorization-error`, el redirect de 403 debe apuntar al scope actual y el botón de login debe regresar a la consola correcta.
UBICACION:
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/shared/core/http.ts
- /Users/molder/projects/github-molder/pronto/pronto-static/src/vue/employees/App.vue
- /Users/molder/projects/github-molder/pronto/pronto-employees/src/pronto_employees/routes/waiter/auth.py
- /Users/molder/projects/github-molder/pronto/pronto-employees/src/pronto_employees/routes/chef/auth.py
- /Users/molder/projects/github-molder/pronto/pronto-employees/src/pronto_employees/routes/cashier/auth.py
- /Users/molder/projects/github-molder/pronto/pronto-employees/src/pronto_employees/routes/admin/auth.py
- /Users/molder/projects/github-molder/pronto/pronto-employees/src/pronto_employees/routes/system/auth.py
- /Users/molder/projects/github-molder/pronto/pronto-libs/src/pronto_shared/scope_guard.py
- /Users/molder/projects/github-molder/pronto/pronto-tests/tests/functionality/ui/playwright-tests/employees/scoped-authorization-error.spec.ts
EVIDENCIA: Reporte de usuario indicando que al intentar usar `/chef` y `/cashier` termina en `http://localhost:6081/waiter/authorization-error?...from=%2Fwaiter%2Fdashboard%2Fwaiter`. Validación Playwright previa mostraba que `http://localhost:6081/chef/authorization-error?...` acababa en `http://localhost:6081/chef/login` y la vista guest de error nunca se renderizaba.
HIPOTESIS_CAUSA: Había varias piezas incompletas al mismo tiempo: el redirect frontend de 403 no era plenamente scopeado, el SSR no exponía `authorization-error` en todos los blueprints, `App.vue` no trataba esa ruta como guest al cargar por URL directa, y los guards scoped seguían interceptando esa vista.
ESTADO: RESUELTO
SOLUCION:
- Se scopeó el redirect 403 del cliente en `http.ts` hacia `/${scope}/authorization-error`.
- Se agregaron rutas SSR `/<scope>/authorization-error` en waiter, chef, cashier, admin y system.
- `App.vue` ahora trata `authorization-error` como guest por pathname, evitando bootstrap de `auth/me` en esa vista.
- Los guards scoped permiten explícitamente la ruta `authorization-error`.
- Se añadió cobertura Playwright para `chef` y `cashier`, validando que `Ir a Login` aterriza en `/<scope>/login`.
COMMIT:
- pronto-static: cb65c97
- pronto-employees: bd5134a
- pronto-libs: db3ebe9
- pronto-tests: 980e920
- pronto-scripts: 2d3d8a2
- pronto-docs: PENDIENTE
FECHA_RESOLUCION: 2026-03-03
