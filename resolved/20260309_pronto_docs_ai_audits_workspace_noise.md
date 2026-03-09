ID: DOCS-20260309-001
FECHA: 2026-03-09
PROYECTO: pronto-docs
SEVERIDAD: media
TITULO: Outputs generados en pronto-docs/audits/ai contaminan git status y no son documentación canónica
DESCRIPCION:
  `pronto-docs/audits/ai/` acumulaba salidas generadas por runs de auditoría AI que no forman
  parte de la documentación canónica activa y estaban ensuciando `git status`.
PASOS_REPRODUCIR:
  1. Ejecutar `cd pronto-docs && git check-ignore -v audits/ai/20260306_202435/summary.md`.
  2. Ejecutar `cd pronto-docs && git ls-files --others --exclude-standard | rg '^audits/ai/'`.
RESULTADO_ACTUAL:
  La carpeta `audits/ai/` queda ignorada y ya no contamina `git status`; los docs top-level legítimos siguen visibles.
RESULTADO_ESPERADO:
  Los artefactos generados no canónicos no deben contaminar `git status` ni mezclarse con documentación activa.
UBICACION:
  - pronto-docs/.gitignore
  - pronto-docs/audits/ai/
EVIDENCIA:
  - `cd pronto-docs && git check-ignore -v audits/ai/20260306_202435/summary.md` => `.gitignore:31:audits/ai/`
  - `cd pronto-docs && git ls-files --others --exclude-standard | rg '^audits/ai/'` => sin output
  - siguen visibles como untracked legítimos: `API_CONSUMPTION_MASTER.md`, `API_DOMAINS_INDEX.md`, `SYSTEM_ROUTES_CATALOG.md`, `SYSTEM_ROUTES_ENDPOINTS.md`, `SYSTEM_ROUTES_MATRIX.md`, `SYSTEM_ROUTES_SPEC.md`
HIPOTESIS_CAUSA:
  El runner de auditoría AI generaba outputs temporales dentro de `pronto-docs` sin una regla de ignore asociada.
ESTADO: RESUELTO
SOLUCION:
  Se agregó `audits/ai/` a `pronto-docs/.gitignore` para sacar del flujo de trabajo diario los outputs generados. La documentación top-level activa no fue tocada.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-09