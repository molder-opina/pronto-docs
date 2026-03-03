ID: ERR-20260225-001
FECHA: 2026-02-25
PROYECTO: pronto-employees + pronto-static + pronto-api + pronto-libs
SEVERIDAD: alta
TITULO: Layout desaparece al cambiar de consola + sesiones no aisladas

DESCRIPCION:
El sistema no soporta sesiones independientes por consola. Cuando un empleado
inicia sesion en /waiter y luego abre /chef en otra pestana, las cookies JWT
se sobrescriben mutuamente. Ademas, el layout de Vue desaparece momentaneamente
durante la transicion de autenticacion, causando un flash visual no deseado.

PASOS_REPRODUCIR:
1. Abrir navegador y navegar a /waiter/login
2. Iniciar sesion como waiter
3. Abrir nueva pestana y navegar a /chef/login
4. Iniciar sesion como chef (con usuario diferente)
5. Volver a pestana de waiter
6. Recargar pagina

RESULTADO_ACTUAL:
- Sesiones se sobrescriben mutuamente
- Layout desaparece brevemente durante carga
- Usuario waiter ve pantalla blanca o es redirigido

RESULTADO_ESPERADO:
- Ambas sesiones coexisten en pestanas separadas
- Layout permanece visible durante transiciones de auth
- Cada consola mantiene su contexto aislado

UBICACION:
- pronto-employees/src/pronto_employees/routes/*/auth.py
- pronto-static/src/vue/employees/core/http.ts
- pronto-libs/src/pronto_shared/jwt_service.py
- pronto-api/src/api_app/routes/employees/auth.py

EVIDENCIA:
- Cookies access_token/access_token_chef/access_token_waiter en DevTools
- console.log de authStore.user durante transiciones

HIPOTESIS_CAUSA:
1. Cookies JWT usan nombre generico sin namespace por consola
2. App.vue tiene null guard que oculta layout mientras carga auth
3. extract_token_from_request no distingue scope en URL path

ESTADO: RESUELTO
SOLUCION:
- Implementado console_ctx.py para resolver scope desde URL path
- Modificado extract_token_from_request para priorizar cookies namespaced
- Creado proxy tecnico /<scope>/api/* en pronto-employees
- Actualizado http.ts para routing scope-aware
- Eliminado todo fallback a cookies genericas
- Cada consola usa cookies access_token_{scope} y refresh_token_{scope}
- Login GET endpoints solo buscan su cookie namespaced especifica
- Frontend detecta scope mismatch y no bootstrapea usuario incorrecto
COMMIT:
- pronto-libs: feat(employees-auth): add console context resolver + harden JWT extractor
- pronto-libs: fix(jwt): remove legacy cookie fallback from token extractor
- pronto-libs: fix(scope-guard): remove legacy cookie fallback
- pronto-employees: feat(employees-proxy): add deprecated scope transport proxy
- pronto-employees: fix(auth): namespaced cookies in employees API logout
- pronto-employees: fix(auth): remove legacy cookie fallback from console auth
- pronto-employees: fix(auth): exempt login endpoints from CSRF for API access
- pronto-employees: fix(auth): prevent cross-scope session leak in login pages
- pronto-static: feat(static-employees): scope-aware api wrapper
- pronto-static: fix(auth): scope mismatch detection in user bootstrap
- pronto-api: feat(auth): namespaced JWT cookies per console scope
- pronto-api: fix(client-sessions): namespace client session cookie
- pronto-client: fix(client): remove JWT cookie propagation in orders proxy
VERIFICACION:
- Test de navegación cruzada (20 combinaciones) - TODAS PASARON
- waiter → chef/cashier/admin/system → login correcto, sin leak de sesión
- chef → waiter/cashier/admin/system → login correcto, sin leak de sesión
- cashier → waiter/chef/admin/system → login correcto, sin leak de sesión
- admin → waiter/chef/cashier/system → login correcto, sin leak de sesión
- waiter → waiter → permanece autenticado en dashboard
FECHA_RESOLUCION: 2026-02-26
