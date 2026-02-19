ID: ERR-20260219-EMPLOYEE-API-ENV-KEY-MISMATCH
FECHA: 2026-02-19
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Inconsistencia entre variable de entorno documentada y variable leída en app cliente
DESCRIPCION: La aplicación cliente carga `EMPLOYEE_API_BASE_URL` desde `os.getenv("PRONTO_EMPLOYEES_BASE_URL", "")`, pero `.env`/`.env.example` documentan `EMPLOYEE_API_BASE_URL`. Esto deja el valor en blanco y fuerza fallbacks implícitos no canónicos.
PASOS_REPRODUCIR:
1) Revisar `.env` y `.env.example` para clave de employees base URL.
2) Revisar `create_app()` de pronto-client.
3) Verificar que `PRONTO_EMPLOYEES_BASE_URL` no está definida.
RESULTADO_ACTUAL: `app.config["EMPLOYEE_API_BASE_URL"]` queda vacío en runtime salvo configuración externa no documentada.
RESULTADO_ESPERADO: La clave leída por código y la clave declarada en `.env.example` deben ser la misma para evitar drift de configuración y rutas ambiguas.
UBICACION: /Users/molder/projects/github-molder/pronto/pronto-client/src/pronto_clients/app.py:272, /Users/molder/projects/github-molder/pronto/.env:64, /Users/molder/projects/github-molder/pronto/.env.example:66
EVIDENCIA: `app.config["EMPLOYEE_API_BASE_URL"] = os.getenv("PRONTO_EMPLOYEES_BASE_URL", "").strip()` y ausencia de `PRONTO_EMPLOYEES_BASE_URL` en archivos de entorno del root.
HIPOTESIS_CAUSA: Renombre parcial de variable de entorno sin actualización integral de código/documentación.
ESTADO: RESUELTO
SOLUCION: `create_app()` en `pronto-client` fue ajustado para leer primero `EMPLOYEE_API_BASE_URL` (canónica en `.env/.env.example`) con fallback a `PRONTO_EMPLOYEES_BASE_URL` por compatibilidad.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-19
