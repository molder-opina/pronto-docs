ID: ERR-20260213-SEED-SCHEMA-MISMATCH-AREAS
FECHA: 2026-02-13
PROYECTO: pronto-libs / pronto-scripts / DB
SEVERIDAD: bloqueante
TITULO: validate_and_seed falla por desalineación entre modelo Area y esquema DB
DESCRIPCION: La validación seed vía ORM falla porque el modelo `Area` espera columnas `color/prefix/background_image` e `id` entero, pero la tabla real `pronto_areas` en DB tiene `id` UUID y `sort_order` sin `color/prefix`.
PASOS_REPRODUCIR:
1. Ejecutar `bash pronto-scripts/bin/validate-seed.sh`.
2. Ver traceback `column pronto_areas.color does not exist`.
RESULTADO_ACTUAL: Seed validator falla al consultar `Area` por incompatibilidad de esquema.
RESULTADO_ESPERADO: Modelo ORM y esquema DB alineados para validar/seed sin error.
UBICACION: pronto-libs/src/pronto_shared/models.py (class Area), esquema real de pronto_areas, pronto-scripts/bin/python/validate_and_seed.py
EVIDENCIA: traceback SQLAlchemy/psycopg2 `UndefinedColumn: pronto_areas.color` y `\d pronto_areas` sin columnas esperadas.
HIPOTESIS_CAUSA: evolución histórica con contratos de tabla `pronto_areas` divergentes y ausencia de migración canónica de convergencia.
ESTADO: RESUELTO
