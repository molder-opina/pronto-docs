ID: ERR-20260225-001
FECHA: 2026-02-25
PROYECTO: pronto-employees + pronto-static
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
- pronto-static/src/vue/employees/App.vue
- pronto-libs/src/pronto_shared/jwt_service.py

EVIDENCIA:
- Cookies access_token/access_token_chef/access_token_waiter en DevTools
- console.log de authStore.user durante transiciones

HIPOTESIS_CAUSA:
1. Cookies JWT usan nombre generico sin namespace por consola
2. App.vue tiene null guard que oculta layout mientras carga auth
3. extract_token_from_request no distingue scope en URL path

ESTADO: ABIERTO
