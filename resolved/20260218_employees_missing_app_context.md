ID: ERR-20260218-EMPLOYEES-MISSING-APP-CONTEXT
FECHA: 2026-02-19
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Template index.html no incluye window.APP_CONTEXT para Vue app
DESCRIPCION: El template index.html de employees solo definia data-app-context en el body, pero el Vue app espera window.APP_CONTEXT como variable global para determinar el contexto de la aplicacion (waiter, chef, cashier, admin, system).
PASOS_REPRODUCIR:
1. Acceder a http://localhost:6081/waiter/login
2. Inspeccionar el HTML renderizado
3. Verificar que falta window.APP_CONTEXT
RESULTADO_ACTUAL: Vue app no puede determinar el contexto y usa valor por defecto 'waiter'
RESULTADO_ESPERADO: Vue app debe recibir window.APP_CONTEXT con el contexto correcto
UBICACION: pronto-employees/src/pronto_employees/templates/index.html
EVIDENCIA: Tests de login fallaban esperando window.APP_CONTEXT = 'waiter'
HIPOTESIS_CAUSA: Template refactor anterior elimino el script inline
ESTADO: RESUELTO
SOLUCION: Agregado script inline que define window.APP_CONTEXT usando Jinja template variable con tojson filter
COMMIT: pending
FECHA_RESOLUCION: 2026-02-19
