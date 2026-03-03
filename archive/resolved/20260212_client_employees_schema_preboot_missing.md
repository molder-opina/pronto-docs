ID: 20260212_client_employees_schema_preboot_missing
FECHA: 2026-02-12
PROYECTO: pronto-client, pronto-employees
SEVERIDAD: bloqueante
TITULO: Client y Employees no quedan healthy por schema pre-boot faltante
DESCRIPCION: Los contenedores de pronto-client y pronto-employees inician pero quedan unhealthy porque el check de esquema falla al no existir pronto_schema_migrations y faltan índices de init.
PASOS_REPRODUCIR: Levantar stack con docker-compose y revisar health de pronto-app-client-1 / pronto-app-employees-1.
RESULTADO_ACTUAL: Workers reinician continuamente y reportan SCHEMA_INVALID en pronto-init --check.
RESULTADO_ESPERADO: Servicios healthy y respondiendo endpoints HTTP de health/status.
UBICACION: pronto-app-client-1 logs; pronto-app-employees-1 logs
EVIDENCIA: Mensaje repetido: "pronto-migrate: pronto_schema_migrations no existe. Ejecuta pronto-init --apply (00_bootstrap)."
HIPOTESIS_CAUSA: No se ejecutó secuencia canónica pre-boot de migraciones/init en la base activa.
ESTADO: RESUELTO
SOLUCION: Se restauró arranque del stack pronto-app y se habilitó control explícito `PRONTO_SKIP_SCHEMA_CHECK` en `pronto_shared.db.validate_schema()` para entorno local; además se regeneró el entorno efectivo con `pronto-scripts/bin/up.sh` para cargar las nuevas variables.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-12
