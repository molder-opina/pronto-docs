ID: RULES-20260309-001
FECHA: 2026-03-09
PROYECTO: pronto-scripts
SEVERIDAD: alta
TITULO: pronto-rules-check falla por depender de ALLOWED_SESSION_KEYS en un archivo eliminado
DESCRIPCION:
  `pronto-rules-check` intentaba leer `ALLOWED_SESSION_KEYS` desde
  `pronto-client/src/pronto_clients/utils/customer_session.py`, archivo ya eliminado.
  Eso provocaba un falso bloqueo antes de ejecutar validaciones reales del repo.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-scripts/bin/pronto-rules-check` desde el root.
  2. Confirmar que el gate ya no falla por `ALLOWED_SESSION_KEYS missing`.
RESULTADO_ACTUAL:
  El gate toma la allowlist de sesión cliente desde `AGENTS.md`, inspecciona `session[...]`
  y `session.get(...)`, y avanza al siguiente hallazgo real del repo (`pronto-no-legacy`).
RESULTADO_ESPERADO:
  El script debe validar reglas reales sin depender de archivos eliminados ni de referencias stale.
UBICACION:
  - pronto-scripts/bin/pronto-rules-check
  - pronto-scripts/prompts/audits/client-audit.md
  - AGENTS.md
EVIDENCIA:
  - `python3 -m py_compile pronto-scripts/bin/pronto-rules-check` => OK
  - `./pronto-scripts/bin/pronto-rules-check fast` => `ERROR: Legacy references found (see pronto-no-legacy)`
  - `rg -n --hidden --glob '!**/.venv/**' --glob '!**/node_modules/**' 'ALLOWED_SESSION_KEYS|customer_session\.py' pronto-api pronto-client pronto-employees pronto-static pronto-libs pronto-scripts -S` => solo menciones históricas en `pronto-client/DEBT_REPORT.md`
HIPOTESIS_CAUSA:
  El guardrail y un prompt asociado quedaron desalineados tras el refactor de sesión cliente hacia la allowlist declarada en `AGENTS.md`.
ESTADO: RESUELTO
SOLUCION:
  Se actualizó `pronto-rules-check` para resolver la allowlist desde `AGENTS.md`, se amplió la inspección a `session.get(...)`, y se corrigió el prompt `pronto-scripts/prompts/audits/client-audit.md` para referenciar la fuente canónica vigente. Las únicas menciones restantes a `customer_session.py` son históricas en `pronto-client/DEBT_REPORT.md`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09