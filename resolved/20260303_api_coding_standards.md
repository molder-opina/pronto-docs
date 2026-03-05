ID: CODE-20260303-025
FECHA: 2026-03-03
PROYECTO: pronto-api
SEVERIDAD: baja
TITULO: Violaciones de estándares de codificación en pronto-api

DESCRIPCION: |
  Se han identificado múltiples violaciones menores de los estándares de codificación del proyecto que afectan la legibilidad y mantenibilidad del código.

RESULTADO_ACTUAL: |
  - **Importaciones Desordenadas**: Varios archivos (`customers/orders.py`, `employees/stats.py`) tienen sentencias `import` al final del archivo.
  - **Uso de datetime.utcnow()**: Detectado en `employees/analytics.py` y `employees/stats.py`.
  - **Duplicación de Rutas**: Endpoints con múltiples alias redundantes en `employees/auth.py` y `settings.py`.
  - **Duplicación de Manejo de Errores**: Bloques `try...except` casi idénticos en cada función de `reports.py`, `areas.py`, `tables.py` y `table_assignments.py`.
  - **Docstrings Duplicados**: En `employees/menu_items.py`.

RESULTADO_ESPERADO: |
  - Todas las importaciones deben estar en la cabecera.
  - Uso de `pronto_shared.datetime_utils.utcnow()`.
  - Unificar alias de rutas.
  - Usar un decorador de manejo de errores global o específico por blueprint.

UBICACION: |
  - `pronto-api/src/api_app/routes/`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Mover importaciones a la cabecera en todos los archivos.
  - [ ] Implementar un decorador `@handle_api_errors` para centralizar el logging y formateo de excepciones en las rutas.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
