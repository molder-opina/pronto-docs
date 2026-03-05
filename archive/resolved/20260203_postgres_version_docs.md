---
ID: ERR-20260203-POSTGRES-VERSION
FECHA: 2026-02-03
PROYECTO: pronto-docs/pronto-postgresql
SEVERIDAD: media
TITULO: Docs mencionan versión legacy de PostgreSQL pero el compose canónico usa 16
DESCRIPCION: Documentación indicaba una versión legacy de PostgreSQL mientras docker-compose.yml usa postgres:16-alpine.
PASOS_REPRODUCIR:
1) Revisar pronto-postgresql/README.md y pronto-docs/**
2) Revisar docker-compose.yml
RESULTADO_ACTUAL: Docs referían una versión legacy.
RESULTADO_ESPERADO: Docs refieren PostgreSQL 16.
UBICACION: pronto-postgresql/README.md, pronto-docs/**, docker-compose.yml
EVIDENCIA: docker-compose.yml usa postgres:16-alpine; docs mencionaban una versión legacy.
HIPOTESIS_CAUSA: Documentación no actualizada tras cambio de versión.
ESTADO: RESUELTO
---

SOLUCION: Se elimino la referencia a version PostgreSQL no canonica en la documentacion; canonico permanece 16-alpine.
COMMIT: d7f6726 / 94e2a1f
FECHA_RESOLUCION: 2026-02-05
