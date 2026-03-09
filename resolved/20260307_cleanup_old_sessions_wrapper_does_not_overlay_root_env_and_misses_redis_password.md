ID: TEST-20260307-069
FECHA: 2026-03-07
PROYECTO: root,pronto-scripts
SEVERIDAD: baja
TITULO: cleanup-old-sessions solo carga pronto-scripts/.env y pierde REDIS_PASSWORD del root
DESCRIPCION:
  `pronto-scripts/bin/cleanup-old-sessions.sh` cargaba `pronto-scripts/.env`, pero en este workspace el `REDIS_PASSWORD`
  canónico vive en el `.env` root. Como `pronto-scripts/.env` no lo define, el wrapper invocaba el script offline sin esa
  credencial y el preview total seguía mostrando `Authentication required` en Redis.
PASOS_REPRODUCIR:
  1. Verificar que `pronto-scripts/.env` contiene `REDIS_HOST`/`REDIS_PORT` pero no `REDIS_PASSWORD`.
  2. Verificar que `.env` root sí contiene `REDIS_PASSWORD`.
  3. Ejecutar `bash pronto-scripts/bin/cleanup-old-sessions.sh --all --dry-run` y observar warning de auth en Redis.
RESULTADO_ACTUAL:
  El wrapper no superponía variables faltantes desde el `.env` root y perdía la password de Redis.
RESULTADO_ESPERADO:
  Si existe un `.env` root del workspace, el wrapper debe cargarlo después de `pronto-scripts/.env` para completar/override de credenciales canónicas de ejecución local.
UBICACION:
  - `pronto-scripts/bin/cleanup-old-sessions.sh`
ESTADO: RESUELTO
SOLUCION:
  El wrapper ahora carga primero `pronto-scripts/.env` y luego, si existe, el `.env` root del workspace para completar credenciales faltantes.
  Validación: `bash -n pronto-scripts/bin/cleanup-old-sessions.sh` => OK; `bash pronto-scripts/bin/cleanup-old-sessions.sh --all --dry-run`
  => exit 0, con `Claves de Redis encontradas: 0` y sin warning de autenticación.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
