---
ID: ERR-20260204-RUNTIME-DDL-INITDB
FECHA: 2026-02-04
PROYECTO: pronto-libs/pronto-api/pronto-client/pronto-employees
SEVERIDAD: bloqueante
TITULO: DDL en runtime via init_db/create_all y parches ALTER TABLE en pronto_shared.db
DESCRIPCION: El arranque de servicios ejecuta DDL en runtime (metadata.create_all e incluso ALTER TABLE para asegurar columnas). Esto viola la politica de estructura pre-boot y puede causar drift/errores (indices duplicados) y corrupcion operativa.
PASOS_REPRODUCIR:
1. Levantar pronto-api/pronto-client/pronto-employees con DB existente.
2. Observar logs donde init_db ejecuta metadata.create_all y/o ALTER TABLE.
RESULTADO_ACTUAL: DDL en runtime durante boot.
RESULTADO_ESPERADO: Ningun servicio ejecuta DDL en runtime; la estructura se prepara antes via pronto-scripts/init + wrappers.
UBICACION: pronto-libs/src/pronto_shared/db.py:init_db + startups que llaman init_db.
EVIDENCIA: init_db llama metadata.create_all y _ensure_employee_preferences_column ejecuta ALTER TABLE.
HIPOTESIS_CAUSA: Se habilito create_all para desarrollo y se agrego parche runtime para columna preferences.
ESTADO: RESUELTO
---

SOLUCION:
- Se elimino DDL en runtime desde pronto_shared.db (sin create_all ni ALTER TABLE en boot).
- Se agrego validacion read-only via `pronto-init --check --json` que aborta startup (exit 1) con pasos accionables.
- Se agrego tooling canonico `pronto-scripts/init/**` + wrappers `pronto-init/pronto-migrate` + gates DDL.
- Se actualizo pronto-api y pronto-client para usar validate_schema() en lugar de init_db().

COMMIT:
- pronto-scripts: 39c86cf
- pronto-libs: 162c1fe
- pronto-api: 95112e3
- pronto-client: 3dd5b83

FECHA_RESOLUCION:
2026-02-05
