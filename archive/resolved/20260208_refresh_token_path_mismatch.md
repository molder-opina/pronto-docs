---
ID: ERR-20260208-013
FECHA: 2026-02-08
PROYECTO: pronto-api / pronto-static
SEVERIDAD: alta
TITULO: Inconsistencia en ruta del endpoint de Refresh Token
DESCRIPCION: El interceptor de autenticación en el frontend (`auth-interceptor.ts`) intenta renovar tokens llamando a `/api/employees/auth/refresh`, mientras que el servidor (`auth.py` en pronto-api) expone el endpoint bajo el prefijo `/api/employee-auth/refresh`. Esto causa que la renovación automática de sesiones falle con un error 404, obligando a los usuarios a re-autenticarse frecuentemente.
PASOS_REPRODUCIR:
1) Dejar expirar el token de acceso de un empleado.
2) Realizar cualquier acción en el dashboard que dispare un fetch.
3) Observar en la consola de red una llamada fallida (404) a `/api/employees/auth/refresh`.
RESULTADO_ACTUAL: Error 404 en el flujo de refresco de sesión.
RESULTADO_ESPERADO: El frontend y el backend deben coincidir en la ruta (canónicamente `/api/employees/auth/refresh`).
UBICACION: pronto-api/src/api_app/routes/employees/auth.py y pronto-static/src/vue/employees/core/auth-interceptor.ts
EVIDENCIA: `auth.py` define `url_prefix="/employee-auth"`; `auth-interceptor.ts:36` usa `/api/employees/auth/refresh`.
HIPOTESIS_CAUSA: Cambio de nombre de ruta durante la unificación de la API sin actualizar el interceptor de frontend.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Cambiar el `url_prefix` en `pronto-api/src/api_app/routes/employees/auth.py` de `/employee-auth` a `/employees/auth`.
2. Actualizar las referencias en scripts de prueba (ej. `test-auth-refresh.sh`) para usar la nueva ruta.
3. Verificar que el interceptor de frontend ahora reciba un 200 OK.
