ID: ERR-20260219-MISSING-BACKEND-ENDPOINTS
FECHA: 2026-02-19
PROYECTO: pronto-employees, pronto-static
SEVERIDAD: bloqueante
TITULO: Endpoints de API llamados desde frontend no existen en backend
DESCRIPCION: El frontend de employees hace llamadas a endpoints que no estan implementados en el backend, causando errores 404 en runtime.
PASOS_REPRODUCIR:
1. Abrir DevTools en el navegador
2. Acceder a cualquier vista de employees que use sesiones
3. Observar errores 404 en consola
RESULTADO_ACTUAL: Endpoint retorna {"error":"Recurso no encontrado"}
RESULTADO_ESPERADO: Endpoint debe retornar datos validos o no ser llamado
UBICACION: 
- pronto-static/src/vue/employees/components/SessionsManager.vue:308 (sessions/merge)
- pronto-static/src/vue/employees/modules/anonymous-sessions-manager.ts:86 (sessions/anonymous)
- Frontend llama /api/branding/config (no encontrado en codigo)
EVIDENCIA:
```
curl -s http://localhost:6081/api/sessions/merge -X POST
{"data":null,"error":"Recurso no encontrado","status":"error"}

curl -s http://localhost:6081/api/sessions/anonymous
{"data":null,"error":"Recurso no encontrado","status":"error"}

curl -s http://localhost:6081/api/branding/config
{"data":null,"error":"Recurso no encontrado","status":"error"}
```
HIPOTESIS_CAUSA: Endpoints fueron disenados en frontend pero nunca implementados en backend, o fueron removidos sin actualizar frontend.
ESTADO: RESUELTO
SOLUCION: Falso positivo - los endpoints SI existen y funcionan correctamente. El error se debio a que el contenedor employees estaba en ciclo de reinicio por ERR-20260219-UUID-IMPORT-MISSING. Una vez resuelto ese bug, los endpoints responden correctamente.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-19
