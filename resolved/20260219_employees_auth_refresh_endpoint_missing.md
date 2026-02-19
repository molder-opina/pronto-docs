ID: ERR-20260219-EMPLOYEES-AUTH-REFRESH-MISSING
FECHA: 2026-02-19
PROYECTO: pronto-static, pronto-employees
SEVERIDAD: alta
TITULO: Interceptor de auth llama endpoint /api/employees/auth/refresh inexistente
DESCRIPCION: El interceptor global de employees intenta refrescar token con POST /api/employees/auth/refresh cuando recibe 401, pero el backend no implementa ese endpoint. Esto genera una llamada adicional fallida y ruido de errores en runtime.
PASOS_REPRODUCIR:
1. Abrir employees y provocar cualquier request API con token expirado
2. Observar que la respuesta inicial es 401
3. Verificar en red una segunda llamada POST /api/employees/auth/refresh que falla
RESULTADO_ACTUAL: Se ejecuta request a endpoint inexistente y falla la recuperación de sesión.
RESULTADO_ESPERADO: No llamar endpoints inexistentes; ante 401 debe redirigir/invalidar sesión con flujo canónico.
UBICACION:
- pronto-static/src/vue/employees/core/auth-interceptor.ts:36
- pronto-employees/src/pronto_employees/routes/api/auth.py (sin ruta refresh)
EVIDENCIA:
```bash
rg -n "employees/auth/refresh" pronto-static/src/vue/employees/core/auth-interceptor.ts
rg -n "auth/refresh|/refresh" pronto-employees/src/pronto_employees/routes/api/auth.py
```
HIPOTESIS_CAUSA: Quedó lógica legacy de refresh automático en frontend sin contraparte en backend BFF actual.
ESTADO: RESUELTO
SOLUCION: Se eliminó el intento de refresh hacia `/api/employees/auth/refresh` en el interceptor global de employees y se delegó el manejo de `401` al flujo canónico `checkAuthAndRedirect`. Además se removió el import no utilizado `resolveApiEndpoint`.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-19
