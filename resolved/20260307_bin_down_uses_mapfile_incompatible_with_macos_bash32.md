ID: TEST-20260307-059
FECHA: 2026-03-07
PROYECTO: pronto-scripts
SEVERIDAD: media
TITULO: pronto-scripts/bin/down.sh usa mapfile y falla en macOS con Bash 3.2
DESCRIPCION:
  `pronto-scripts/bin/down.sh` usaba `mapfile` dentro de `clean_pronto_containers()`. En macOS con Bash 3.2,
  `mapfile` no existe, por lo que el script fallaba al intentar limpiar contenedores después del `down`.
PASOS_REPRODUCIR:
  1. Ejecutar `bash pronto-scripts/bin/down.sh` en macOS.
  2. Observar `pronto-scripts/bin/down.sh: line 28: mapfile: command not found`.
RESULTADO_ACTUAL:
  El script abortaba por incompatibilidad con Bash 3.2.
RESULTADO_ESPERADO:
  El script debe usar una alternativa portable y funcionar en macOS.
UBICACION:
  - `pronto-scripts/bin/down.sh`
ESTADO: RESUELTO
SOLUCION:
  Se reemplazó `mapfile` por un `while IFS= read -r name; do ... done < <(...)`, compatible con Bash 3.2 y
  equivalente para iterar sobre los contenedores a limpiar. Validación: `bash -n pronto-scripts/bin/down.sh` => OK;
  `bash pronto-scripts/bin/down.sh` => exit 0 sin `mapfile: command not found`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
