ID: TEST-20260307-068
FECHA: 2026-03-07
PROYECTO: pronto-scripts
SEVERIDAD: baja
TITULO: clean-sessions.py ignora REDIS_PASSWORD y emite warning innecesario en --all --dry-run
DESCRIPCION:
  `pronto-scripts/bin/python/clean-sessions.py` usaba únicamente `REDIS_URL` y no tomaba en cuenta `REDIS_PASSWORD`,
  `REDIS_HOST` ni `REDIS_PORT`. En el entorno actual Redis requiere autenticación, por lo que `--all --dry-run`
  terminaba con `Authentication required` aunque las credenciales correctas sí existen en `.env`.
PASOS_REPRODUCIR:
  1. Ejecutar `python3 pronto-scripts/bin/python/clean-sessions.py --all --dry-run`.
  2. Observar `⚠️  Error al limpiar Redis: Authentication required.`.
  3. Verificar con Python que `Redis(host='localhost', port=6379, password=$REDIS_PASSWORD).ping()` devuelve `True`.
RESULTADO_ACTUAL:
  El script no usaba las credenciales disponibles y el preview mostraba un warning engañoso.
RESULTADO_ESPERADO:
  El script debe construir el cliente Redis usando `REDIS_URL` o, si faltan credenciales allí, complementar con `REDIS_HOST`/`REDIS_PORT`/`REDIS_PASSWORD`.
UBICACION:
  - `pronto-scripts/bin/python/clean-sessions.py`
ESTADO: RESUELTO
SOLUCION:
  Se añadió construcción explícita de conexión Redis desde `REDIS_URL` o desde `REDIS_HOST`/`REDIS_PORT`/`REDIS_PASSWORD`,
  junto con una URL mostrada sin exponer secretos. Validación: `python3 -m py_compile pronto-scripts/bin/python/clean-sessions.py` => OK;
  con entorno real cargado desde `.env`, `POSTGRES_HOST=localhost REDIS_URL=redis://localhost:6379/0 python3 pronto-scripts/bin/python/clean-sessions.py --all --dry-run`
  => exit 0 y `Claves de Redis encontradas: 0`, sin warning de autenticación.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
