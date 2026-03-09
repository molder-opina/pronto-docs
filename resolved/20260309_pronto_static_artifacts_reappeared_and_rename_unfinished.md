ID: STA-20260309-001
FECHA: 2026-03-09
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: reaparecen artefactos versionados y queda incompleto el rename canónico create-avatar.sh
DESCRIPCION:
  Reaparecieron residuos ya cerrados anteriormente en `pronto-static`: artefactos versionados de
  prueba/diagnóstico y un rename canónico a medias del script `create-avatar.sh`.
  Referencias previas: `STA-20260307-003` y `STA-20260307-005`.
PASOS_REPRODUCIR:
  1. Ejecutar `cd pronto-static && git status --short -- cart_test.png print_stack.cjs print_stack2.cjs print_stack3.cjs create_avatar.sh create-avatar.sh src/vue/employees/node_modules/.vite/vitest/da39a3ee5e6b4b0d3255bfef95601890afd80709/results.json`.
  2. Confirmar que el lote queda como deletions + rename coherente.
RESULTADO_ACTUAL:
  Los artefactos temporales quedan fuera del repo y el script queda bajo nombre canónico `create-avatar.sh`.
RESULTADO_ESPERADO:
  No conservar temporales versionados ni nombres fuera del canon en `pronto-static`.
UBICACION:
  - pronto-static/cart_test.png
  - pronto-static/print_stack.cjs
  - pronto-static/print_stack2.cjs
  - pronto-static/print_stack3.cjs
  - pronto-static/create_avatar.sh
  - pronto-static/create-avatar.sh
  - pronto-static/src/vue/employees/node_modules/.vite/vitest/da39a3ee5e6b4b0d3255bfef95601890afd80709/results.json
EVIDENCIA:
  - `bash -n pronto-static/create-avatar.sh` => OK
  - `git status --short -- ...` => `D cart_test.png`, `R create_avatar.sh -> create-avatar.sh`, `D print_stack*.cjs`, `D .../results.json`
  - `git ls-files -ci --exclude-standard | rg '^(cart_test\.png|print_stack\.cjs|print_stack2\.cjs|print_stack3\.cjs|src/vue/employees/node_modules/.*/results\.json)$'` => sin output
HIPOTESIS_CAUSA:
  Parte del cleanup previo quedó sin consolidar en git y un output de Vitest volvió a quedar trackeado dentro de `src/vue/employees/node_modules/`.
ESTADO: RESUELTO
SOLUCION:
  Se eliminó el `results.json` remanente, se dejó el lote objetivo consistente en git con deletions explícitas de artefactos y se consolidó el rename `create_avatar.sh` → `create-avatar.sh` sin tocar el resto de cambios activos en `pronto-static`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09