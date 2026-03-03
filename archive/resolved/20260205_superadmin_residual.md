---
ID: ERR-20260205-SUPERADMIN-RESIDUAL
FECHA: 2026-02-05
PROYECTO: monorepo
SEVERIDAD: media
TITULO: Residuos de nomenclatura legacy tras estandarizar rol system
DESCRIPCION: Existen strings/keys legacy en tooling/docs/tests/scripts aunque el rol canonico es system.
PASOS_REPRODUCIR: Ejecutar rg sobre "super admin|superadmin|super_admin" fuera de docs/resolved.
RESULTADO_ACTUAL: Matches en review-agents.json, docs, tests y script de pruebas.
RESULTADO_ESPERADO: 0 matches fuera de docs/resolved; todo debe referir al rol system.
UBICACION: pronto-ai/skills/review-agents.json; pronto-docs/*; pronto-tests/*; pronto-scripts/bin/tests/test-api.sh
EVIDENCIA: rg -n "\\bsuper_admin\\b|\\bsuperadmin\\b|super[-_ ]admin|super admin" . --glob '!pronto-pronto-docs/resolved/**'
HIPOTESIS_CAUSA: Migracion incompleta de nomenclatura al cambiar super_admin -> system.
ESTADO: RESUELTO
---

SOLUCION: Reemplazo de referencias "super admin/superadmin" por "system" en tooling, docs, tests y scripts.
COMMIT: 3b7c910
FECHA_RESOLUCION: 2026-02-05
