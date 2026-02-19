ID: ERR-20260219-HARDCODED-HOSTS
FECHA: 2026-02-19
PROYECTO: pronto-client, pronto-employees, pronto-static
SEVERIDAD: alta
TITULO: Hosts y puertos hardcodeados impiden despliegue en produccion
DESCRIPCION: Multiples archivos contienen referencias hardcodeadas a localhost:6080, 6081, 6082, 9088 que rompen el funcionamiento en entornos de produccion.
PASOS_REPRODUCIR:
1. Revisar codigo fuente
2. Buscar patrones localhost, 6080, 6081, 6082, 9088
3. Identificar archivos con valores hardcodeados
RESULTADO_ACTUAL: Valores hardcodeados en produccion causan errores de conexion
RESULTADO_ESPERADO: Todos los hosts/puertos deben venir de variables de entorno
UBICACION:
- pronto-client/src/pronto_clients/app.py:95-96 (CORS localhost:6080)
- pronto-client/src/pronto_clients/routes/web.py:66,82,97,136,151 (API_BASE_URL default)
- pronto-static/src/vue/employees/core/http.ts:23 (getApiBaseUrl devuelve localhost:6082)
- pronto-employees/src/pronto_employees/app.py:103-104 (CORS localhost:6081)
- pronto-employees/src/pronto_employees/app.py:181,202 (pronto_api_public_host default)
- pronto-employees/src/pronto_employees/app.py:256,283 (static_host_url default)
EVIDENCIA:
```bash
rg -n "localhost|:6080|:6081|:6082|:9088" pronto-static/src pronto-client/src pronto-employees/src --type py --type ts --type js --type vue
```
HIPOTESIS_CAUSA: Defaults para desarrollo local que quedaron como valores fijos
ESTADO: RESUELTO
SOLUCION: Se eliminaron hardcodes de host/puerto en frontend y backends principales, migrando a rutas relativas `/api/*` o configuración por entorno sin defaults fijos de localhost en runtime. Validación final con `rg -n "localhost|:6080|:6081|:6082|:9088" pronto-static/src pronto-client/src pronto-employees/src --type py --type ts --type js --type vue` arrojó solo una coincidencia en comentario no operativo.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-19
