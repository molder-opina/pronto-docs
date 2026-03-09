ID: TEST-20260307-058
FECHA: 2026-03-07
PROYECTO: root,pronto-scripts
SEVERIDAD: media
TITULO: start-api.sh falta en root y la copia versionada falla tarde por conflictos de puertos
DESCRIPCION:
  `start-api.sh` aparecía como script root esperado en guardrails/documentación, pero en el workspace root no existía
  y solo sobrevivía la copia versionada `pronto-scripts/pronto-root/start-api.sh`. Además, el script intentaba
  ejecutar `docker compose --profile apps up -d postgres redis api` sin preflight de puertos, por lo que fallaba tarde
  con errores de bind ocupado y podía dejar contenedores del proyecto actual en estado `Created`.
PASOS_REPRODUCIR:
  1. Verificar que `./start-api.sh` no existía en root.
  2. Ejecutar `bash pronto-scripts/pronto-root/start-api.sh` con otro stack ocupando `5432/6379/6082`.
  3. Observar fallo tardío `Bind for 0.0.0.0:5432 failed: port is already allocated`.
RESULTADO_ACTUAL:
  El script operativo faltaba en root y la copia versionada fallaba tarde por conflictos de puertos.
RESULTADO_ESPERADO:
  Debe existir `start-api.sh` en root y debe fallar temprano con mensajes claros cuando los puertos requeridos ya estén ocupados.
UBICACION:
  - `start-api.sh`
  - `pronto-scripts/pronto-root/start-api.sh`
ESTADO: RESUELTO
SOLUCION:
  Se restauró `start-api.sh` en root y se alineó junto con `pronto-scripts/pronto-root/start-api.sh` al mismo hardening
  de `pronto-dev.sh`: preflight de puertos `5432/6379/6082`, detección temprana de contenedores/procesos que ya los
  ocupan, sugerencias de recuperación (`docker ps`, `lsof`, `docker stop ...`) y guard clause de timeout para Postgres.
  Validación: `bash -n start-api.sh && bash -n pronto-scripts/pronto-root/start-api.sh` => OK; `./start-api.sh` con
  stack paralelo `pronto-app-*` => exit 1 temprano con sugerencias claras; confirmación final: `docker compose ps -a`
  => vacío, sin residuos `pronto-(postgres|redis|api)-1`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
