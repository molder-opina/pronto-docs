ID: LIBS-20260307-001
FECHA: 2026-03-07
PROYECTO: pronto-libs
SEVERIDAD: critica
TITULO: Script en pronto-libs referencia legacy_mysql prohibido por guardrails
DESCRIPCION:
  Existía `fix_schema.py` dentro de `pronto-libs` que apuntaba explícitamente a
  `pronto-scripts/init/legacy_mysql`, patrón prohibido en AGENTS.md (P0).
PASOS_REPRODUCIR:
  1. Abrir `pronto-libs/src/pronto_shared/fix_schema.py`.
  2. Revisar constante `LEGACY_DIR`.
RESULTADO_ACTUAL:
  El script legacy fue retirado del repositorio.
RESULTADO_ESPERADO:
  Eliminar el script o migrarlo a flujo canónico de init/migrations sin referencias legacy.
UBICACION:
  - pronto-libs/src/pronto_shared/fix_schema.py
EVIDENCIA:
  - `fix_schema.py` eliminado del árbol de trabajo
  - `rg -n "fix_schema\.py|legacy_mysql" pronto-libs/src/pronto_shared` => sin matches
HIPOTESIS_CAUSA:
  Artefacto de migración antigua no retirado tras adopción de PostgreSQL canónico.
ESTADO: RESUELTO
SOLUCION:
  Se eliminó `pronto-libs/src/pronto_shared/fix_schema.py` para remover la dependencia prohibida a `legacy_mysql`.
COMMIT: afa7192
FECHA_RESOLUCION: 2026-03-07