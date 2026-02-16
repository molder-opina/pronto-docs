---
ID: ERR-20260204-DUP-IX-HANDOFF-TOKEN-HASH
FECHA: 2026-02-04
PROYECTO: pronto-api/pronto-client/pronto-employees
SEVERIDAD: bloqueante
TITULO: init_db falla por indice duplicado ix_handoff_token_hash
DESCRIPCION: Al iniciar servicios que ejecutan init_db(Base.metadata) se intenta crear el indice ix_handoff_token_hash sobre system_handoff_tokens aunque ya existe, causando error y reinicio de contenedores.
PASOS_REPRODUCIR:
1. Levantar pronto-api, pronto-client o pronto-employees con DB existente.
2. Observar logs de gunicorn durante el boot.
RESULTADO_ACTUAL: sqlalchemy.exc.ProgrammingError (DuplicateTable) por indice ix_handoff_token_hash ya existente.
RESULTADO_ESPERADO: El boot no intenta crear indices existentes y los servicios inician correctamente.
UBICACION: logs de contenedor /usr/local/lib/python3.11/site-packages/pronto_shared/db.py -> init_db -> metadata.create_all.
EVIDENCIA: "psycopg2.errors.DuplicateTable) relation \"ix_handoff_token_hash\" already exists".
HIPOTESIS_CAUSA: create_all intenta crear indices sin verificacion cuando la DB ya tiene el indice creado.
ESTADO: RESUELTO
SOLUCION: init_db ahora tolera errores de indice/relacion duplicada (Postgres 42P07) y no aborta el boot.
COMMIT: NO_COMMIT
FECHA_RESOLUCION: 2026-02-04
---
