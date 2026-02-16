---
ID: ERR-20260204-DUP-INDEX-HANDOFF
FECHA: 2026-02-04
PROYECTO: pronto-api/pronto-client
SEVERIDAD: alta
TITULO: Servicios fallan por indice duplicado ix_handoff_expires_at
DESCRIPCION: Durante el boot, init_db intenta crear el indice ix_handoff_expires_at en system_handoff_tokens y falla porque ya existe. Esto reinicia pronto-api y pronto-client en loop.
PASOS_REPRODUCIR: 1) Levantar contenedores pronto-api o pronto-client. 2) Ver crash con DuplicateTable en logs.
RESULTADO_ACTUAL: Gunicorn no levanta; contenedores reinician.
RESULTADO_ESPERADO: Boot idempotente sin fallar si el indice existe.
UBICACION: pronto-shared/db.py init_db -> create_all
EVIDENCIA: logs muestran psycopg2.errors.DuplicateTable para ix_handoff_expires_at.
HIPOTESIS_CAUSA: create_all intenta crear indice existente sin check.
ESTADO: RESUELTO
SOLUCION: init_db ahora tolera errores de indice/relacion duplicada (Postgres 42P07) y no aborta el boot.
COMMIT: NO_COMMIT
FECHA_RESOLUCION: 2026-02-04
---
