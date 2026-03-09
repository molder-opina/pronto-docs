ID: TEST-20260307-066
FECHA: 2026-03-07
PROYECTO: pronto-scripts
SEVERIDAD: media
TITULO: cleanup-old-sessions usa endpoint API inexistente, auto-instala dependencias y comunica mal su semántica
DESCRIPCION:
  `pronto-scripts/bin/cleanup-old-sessions.sh` intentaba limpiar vía `DELETE /api/debug/cleanup?confirm=yes`, pero ese
  endpoint devuelve 404 en el runtime actual. Cuando fallaba, el wrapper intentaba `pip3 install` de dependencias para
  el fallback offline, modificando el entorno sin permiso. Además, sin flags el comentario decía que limpiaba sesiones
  cerradas, pero el comportamiento real era no-op.
PASOS_REPRODUCIR:
  1. Verificar `curl 'http://localhost:6081/api/debug/cleanup?confirm=yes'` => 404 y `curl 'http://localhost:6082/api/debug/cleanup?confirm=yes'` => 404.
  2. Revisar `pronto-scripts/bin/cleanup-old-sessions.sh` y observar `pip3 install -q psycopg2-binary redis` en el fallback.
  3. Ejecutar `python3 pronto-scripts/bin/python/clean-sessions.py --dry-run` para confirmar que el camino offline sí existe.
RESULTADO_ACTUAL:
  El wrapper dependía de una API muerta, intentaba instalar dependencias automáticamente y comunicaba una semántica engañosa para el caso sin flags.
RESULTADO_ESPERADO:
  El wrapper debe evitar auto-instalar, dar mensajes claros, soportar `--dry-run` seguro y dejar explícito cuándo no realizará ninguna limpieza.
UBICACION:
  - `pronto-scripts/bin/cleanup-old-sessions.sh`
ESTADO: RESUELTO
SOLUCION:
  Se endureció el wrapper sin cambiar la semántica destructiva real: se eliminó el auto-`pip install`, se añadieron
  `--help` y `--dry-run`, se aclaró explícitamente que sin flags no realiza limpieza, y el fallback offline ahora llama
  directamente a `bin/python/clean-sessions.py` solo cuando corresponde. Validación: `bash -n pronto-scripts/bin/cleanup-old-sessions.sh`
  => OK; `bash pronto-scripts/bin/cleanup-old-sessions.sh --help` => OK; `bash pronto-scripts/bin/cleanup-old-sessions.sh`
  => exit 0 informativo; `bash pronto-scripts/bin/cleanup-old-sessions.sh --dry-run` => preview segura sin instalar dependencias.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
