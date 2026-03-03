---
ID: RUNTIME_DDL_VIOLATION
FECHA: 20260228
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Violación de regla de arquitectura (NO DDL at runtime) en pronto_shared
DESCRIPCION: El script de validación arquitectónica `pronto-rules-check` reporta un fallo en la regla `pronto-no-runtime-ddl` con 47 incidencias. El archivo `pronto-libs/src/pronto_shared/create_tables.py` invoca `Base.metadata.create_all(engine)`, lo que es una violación directa del mandato de AGENTS.md de no usar DDL en tiempo de ejecución en las apps Flask.
PASOS_REPRODUCIR:
1. Ejecutar `./pronto-scripts/bin/pronto-rules-check`.
RESULTADO_ACTUAL: Fallo en `pronto-no-runtime-ddl` por la presencia de `CREATE TABLE`, `ALTER TABLE` y llamadas a `create_all()`.
RESULTADO_ESPERADO: La validación de reglas debe pasar limpia. La creación de tablas debe manejarse exclusivamente a través de los scripts de migración oficiales en `pronto-scripts/init`.
UBICACION:
- pronto-libs/src/pronto_shared/create_tables.py
- Varios archivos en pronto-libs/src/pronto_shared/migrations/
HIPOTESIS_CAUSA: Código heredado o scripts de desarrollo locales que no fueron eliminados tras la consolidación del motor de migraciones oficial de PRONTO.
ESTADO: PENDIENTE
---