ID: TEST-20260307-021
FECHA: 2026-03-07
PROYECTO: pronto-tests
SEVERIDAD: alta
TITULO: fixtures/tests de menú crean MenuCategory sin slug y rompen el esquema actual
DESCRIPCION:
  La batería amplia de `pronto-tests/tests/functionality` fallaba porque varios fixtures y tests
  seguían creando `MenuCategory` sin `slug`, aunque el esquema actual exige `slug NOT NULL`.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-libs/.venv/bin/python3 -m pytest pronto-tests/tests/functionality -q`.
  2. Observar `NotNullViolation` en `pronto_menu_categories.slug`.
RESULTADO_ACTUAL:
  Los tests fallaban al insertar categorías de menú incompletas.
RESULTADO_ESPERADO:
  Los fixtures debían crear `MenuCategory` con `slug` válido bajo el contrato actual.
UBICACION:
  - `pronto-tests/conftest.py`
  - `pronto-tests/tests/functionality/unit/test_order_state_machine_v2.py`
EVIDENCIA:
  - `null value in column "slug" ... violates not-null constraint`
HIPOTESIS_CAUSA:
  Drift de tests tras endurecer el esquema canónico.
ESTADO: RESUELTO
SOLUCION:
  Se agregaron `slug` explícitos a los fixtures y factories de categorías usados por las suites afectadas.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

