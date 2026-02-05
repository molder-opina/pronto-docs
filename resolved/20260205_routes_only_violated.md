---
ID: ERR-20260205-ROUTES-ONLY-VIOLATED
FECHA: 2026-02-05
PROYECTO: pronto-employees, pronto-client, pronto-api
SEVERIDAD: bloqueante
TITULO: create_app() no soporta PRONTO_ROUTES_ONLY=1 (side-effects en import/introspeccion)
DESCRIPCION: El gate de parity-check requiere introspeccion determinista via app.url_map. Actualmente create_app() ejecuta side-effects (DB init/validate, syncs, secrets, CORS runtime, etc.) incluso cuando solo se quiere registrar rutas. Esto impide correr parity-check sin dependencias externas y genera ejecuciones no deterministas.
PASOS_REPRODUCIR: 1) Exportar PRONTO_ROUTES_ONLY=1. 2) Importar el modulo app del servicio (employees/clients/api). 3) Observar que se intentan ejecutar init_engine/validate_schema/sync_env_* o validaciones de env, provocando fallas o side-effects.
RESULTADO_ACTUAL: No existe modo routes-only real; la introspeccion de rutas depende de DB/env y puede fallar.
RESULTADO_ESPERADO: En PRONTO_ROUTES_ONLY=1, create_app() solo registra rutas/blueprints y no ejecuta side-effects. Los side-effects viven en init_runtime(app) y se ejecutan solo cuando PRONTO_ROUTES_ONLY!=1.
UBICACION: pronto-employees/src/pronto_employees/app.py; pronto-client/src/pronto_clients/app.py; pronto-api/src/api_app/app.py
EVIDENCIA: create_app() llama validate_required_env_vars/init_engine/validate_schema/sync_env_* antes o durante el wiring de blueprints.
HIPOTESIS_CAUSA: Refactors previos no aislaron side-effects del wiring de rutas, y los modulos mantienen app = create_app() en import-time.
ESTADO: RESUELTO
---

SOLUCION:
Se enforcea `PRONTO_ROUTES_ONLY=1` para introspeccion aislada registrando solo blueprints y evitando side-effects de runtime.

COMMIT:
f03ce0b
2f6533a
ba06b96
e5f461b

FECHA_RESOLUCION:
2026-02-05
