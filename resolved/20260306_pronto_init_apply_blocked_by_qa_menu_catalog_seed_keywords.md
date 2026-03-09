ID: TEST-20260306-052
FECHA: 2026-03-06
PROYECTO: pronto-scripts
SEVERIDAD: media
TITULO: pronto-init --apply bloquea 0398__qa_menu_catalog por keywords prohibidas en 40_seeds
DESCRIPCION:
  `pronto-init --apply` rechazaba `0398__qa_menu_catalog.sql` porque el seed usaba `DO UPDATE` y un
  bloque `DO $$`, ambos incompatibles con el gate canónico de `40_seeds`.
ESTADO: RESUELTO
SOLUCION:
  El seed quedó alineado con el runner de init: el insert inicial de categorías usa `ON CONFLICT DO NOTHING`
  y el bloque condicional para `min_selection/min_select` se reescribió con `\gset` + `\if` en lugar de
  `DO $$`. Validación: `DATABASE_URL=postgresql://pronto:pronto123@localhost:5432/pronto ./pronto-scripts/bin/pronto-init --apply`
  => `OK: init applied`; `pronto-init --check` => OK.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
