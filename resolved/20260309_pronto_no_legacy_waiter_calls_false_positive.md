ID: RULES-20260309-002
FECHA: 2026-03-09
PROYECTO: pronto-scripts
SEVERIDAD: alta
TITULO: pronto-no-legacy bloquea rutas canónicas /api/waiter-calls/* como si fueran legacy
DESCRIPCION:
  `pronto-scripts/bin/pronto-no-legacy` bloqueaba el patrón `/api/waiter-calls/`
  aunque esa familia de rutas ya es canónica y aparece en inventarios activos de `pronto-docs`.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-scripts/bin/pronto-no-legacy` desde el root.
  2. Confirmar que ya no falle por referencias a `/api/waiter-calls/*`.
RESULTADO_ACTUAL:
  El gate deja pasar las referencias canónicas de waiter calls y `pronto-rules-check fast` termina en verde.
RESULTADO_ESPERADO:
  El denylist solo debe bloquear patrones legacy reales, no rutas activas del sistema.
UBICACION:
  - pronto-scripts/bin/pronto-no-legacy
  - pronto-docs/routes/pronto-api-endpoints-03.md
  - pronto-docs/SYSTEM_ROUTES_SPEC.md
  - pronto-docs/SYSTEM_ROUTES_CATALOG.md
  - pronto-docs/SYSTEM_ROUTES_MATRIX.md
EVIDENCIA:
  - `bash -n pronto-scripts/bin/pronto-no-legacy` => OK
  - `./pronto-scripts/bin/pronto-no-legacy` => exit 0
  - `./pronto-scripts/bin/pronto-rules-check fast` => OK
  - `rg -n --hidden --glob '!**/.venv/**' --glob '!**/node_modules/**' '/api/waiter-calls/|pronto-no-legacy' pronto-docs pronto-api pronto-scripts pronto-static pronto-client pronto-employees pronto-libs -S`
HIPOTESIS_CAUSA:
  La denylist quedó stale tras la migración canónica de `customers/waiter-calls/*` hacia `/api/waiter-calls/*`.
ESTADO: RESUELTO
SOLUCION:
  Se eliminó `/api/waiter-calls/` del denylist en `pronto-scripts/bin/pronto-no-legacy`. La validación transversal confirmó que el patrón restante es canónico en documentación activa y que el guardrail vuelve a pasar sin bloquear rutas vigentes.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09