ID: TEST-20260307-062
FECHA: 2026-03-07
PROYECTO: pronto-scripts
SEVERIDAD: media
TITULO: summarize_services en stack_helpers usa local -n y es incompatible con Bash 3.2
DESCRIPCION:
  `pronto-scripts/bin/lib/stack_helpers.sh` usaba `local -n` en `summarize_services()` para escribir en arrays por
  referencia. En Bash 3.2 de macOS esa opción no existe y emite `local: -n: invalid option`, contaminando la ejecución
  de scripts que sourcean la librería bajo `set -euo pipefail`.
PASOS_REPRODUCIR:
  1. Ejecutar en macOS: `bash -c 'f(){ local -n ref=$1; echo ok; }; arr=(); f arr'`.
  2. Observar `local: -n: invalid option`.
RESULTADO_ACTUAL:
  La librería contenía un bashism incompatible con Bash 3.2 y `up.sh` depende de esa función para resumir servicios.
RESULTADO_ESPERADO:
  `summarize_services()` debe funcionar con Bash 3.2 sin usar `local -n`.
UBICACION:
  - `pronto-scripts/bin/lib/stack_helpers.sh`
ESTADO: RESUELTO
SOLUCION:
  Se reemplazó `local -n` por helpers portables `reset_named_array()` y `append_named_array()` basados en `eval` con
  quoting seguro (`printf -v ... %q`), manteniendo la misma interfaz pública de `summarize_services(container_cli, summary_array_name, failed_array_name, ...)`.
  Validación: `bash -n pronto-scripts/bin/lib/stack_helpers.sh` => OK; `rg` confirma ausencia de `local -n`; smoke test
  bajo `set -euo pipefail` poblando `SERVICE_SUMMARY` y `FAILED_SERVICES` => OK, incluyendo `summary_ok` para el caso
  simple que consume `up.sh`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
