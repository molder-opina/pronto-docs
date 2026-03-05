---
ID: PENDING_SCHEMA_MIGRATION
FECHA: 20260228
PROYECTO: pronto-scripts
SEVERIDAD: baja
TITULO: Migración de V6 marcada como pendiente en la auditoría de esquema
DESCRIPCION: La ejecución de `pronto-init --check` reporta un fallo de validación de esquema, indicando que la migración `20260226_01__normalize_system_settings.sql` se encuentra "PENDING".
PASOS_REPRODUCIR:
1. Ejecutar `docker exec pronto-api-1 /opt/pronto/pronto-scripts/bin/pronto-init --check`
RESULTADO_ACTUAL: La herramienta reporta que el esquema no está sincronizado porque falta una migración.
RESULTADO_ESPERADO: El estado del esquema debe ser "100% sincronizado" (0 pending, 0 drift).
UBICACION:
- Base de datos (tabla `pronto_schema_migrations`).
HIPOTESIS_CAUSA: Durante el despliegue del blindaje V6, los cambios SQL se aplicaron manualmente mediante `psql` para acelerar el desarrollo, en lugar de usar la herramienta `pronto-migrate`, lo que causó que la tabla de control de migraciones no se actualizara.
ESTADO: RESUELTO
SOLUCION: Se validó el estado real de esquema con `docker exec pronto-api-1 /opt/pronto/pronto-scripts/bin/pronto-init --check`, obteniendo `pending=0 drift=0` y `OK: pronto-init --check`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-04
---
