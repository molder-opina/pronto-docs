ID: LIBS-20260308-MENU-CATEGORY-SCHEMA-LAG
FECHA: 2026-03-08
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: MenuCategory exportado no refleja slug y revision exigidos por el schema actual
DESCRIPCION: `pronto-libs/src/pronto_shared/models/menu_models.py` seguía definiendo `MenuCategory` sin los campos `slug` y `revision`, aunque las migraciones y los tests actuales ya operan con esas columnas como parte del contrato vigente.
PASOS_REPRODUCIR:
1. Revisar `pronto-libs/src/pronto_shared/models/menu_models.py`.
2. Comparar con `pronto-scripts/init/sql/migrations/20260307_01__menu_category_slug_revision.sql` y con fixtures/tests de menú.
3. Observar que el modelo exportado carece de `slug`/`revision`.
RESULTADO_ACTUAL: `MenuCategory` ya expone `slug` y `revision`, manteniendo paridad con migraciones y fixtures actuales.
RESULTADO_ESPERADO: `MenuCategory` debe incluir `slug` not-null/unique y `revision` con default para mantener paridad ORM-schema-tests.
UBICACION: pronto-libs/src/pronto_shared/models/menu_models.py
EVIDENCIA: `tests/functionality/integration/test_menu_home_publish_api.py` y `tests/functionality/unit/test_order_state_machine_v2.py` siguen pasando con el modelo actualizado; smoke local confirmó `slug.nullable=False` y `revision.default=1`.
HIPOTESIS_CAUSA: Drift posterior a la migración de menú donde se ajustaron tests y SQL pero no el modelo exportado.
ESTADO: RESUELTO
SOLUCION: Se añadieron `slug` y `revision` al modelo `MenuCategory`; en el mismo commit se alineó `FeedbackQuestion` con la tabla real y `RecommendationChangeLog` con la tabla/columnas canónicas del schema actual.
COMMIT: 1eba18d
FECHA_RESOLUCION: 2026-03-08

