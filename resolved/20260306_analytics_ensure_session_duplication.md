ID: CODE-20260306-001
FECHA: 2026-03-06
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Duplicación de helper _ensure_session en servicios de analytics
DESCRIPCION:
  Los servicios de analytics en `pronto_shared.services.analytics` mantenían cinco copias de un
  mismo helper `_ensure_session(db_session=None)` para reutilizar una sesión existente o abrir una
  nueva con `get_session()`. Esta duplicación aumentaba el riesgo de desalineación futura y se
  solapaba parcialmente con hallazgos amplios previos de duplicación en `pronto-libs`.
PASOS_REPRODUCIR:
  1. Ejecutar `rg -n "def _ensure_session\(" pronto-libs/src/pronto_shared/services/analytics -g '*.py'`.
  2. Observar definiciones repetidas en `customer_analytics.py`, `employee_analytics.py`,
     `operational_analytics.py`, `product_analytics.py` y `revenue_analytics.py`.
RESULTADO_ACTUAL:
  Cinco helpers locales implementaban la misma lógica de sesión opcional.
RESULTADO_ESPERADO:
  Debe existir un helper compartido en `pronto_shared.db` y los módulos analytics deben reutilizarlo.
UBICACION:
  - `pronto-libs/src/pronto_shared/db.py`
  - `pronto-libs/src/pronto_shared/services/analytics/*.py`
EVIDENCIA:
  - `rg` devolvía 5 definiciones de `_ensure_session(...)` en analytics.
HIPOTESIS_CAUSA:
  Los servicios de analytics se implementaron incrementalmente copiando el mismo patrón de manejo de
  sesión en vez de consolidarlo en una utilidad común de `pronto_shared`.
ESTADO: RESUELTO
SOLUCION:
  Se agregó `ensure_session(db_session=None)` en `pronto_shared.db` y se refactorizaron los cinco
  módulos analytics para reutilizar ese helper, eliminando las funciones locales duplicadas.
  Se añadió `pronto-libs/tests/unit/test_db.py` para cubrir tanto el reuso de una sesión provista
  como la apertura/cierre de una sesión gestionada vía `get_session()`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06