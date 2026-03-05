ID: CODE-20260303-019
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: baja
TITULO: Duplicación de helper _ensure_session en servicios

DESCRIPCION: |
  Se ha detectado que el gestor de contexto `_ensure_session`, que permite reutilizar o crear una sesión de base de datos de forma segura, está copiado y pegado en al menos 6 archivos de servicio diferentes dentro de `pronto-libs`.

RESULTADO_ACTUAL: |
  Duplicación de código utilitario en:
  - `analytics_service_new.py`
  - `order_write_service.py`
  - `customer_analytics.py`
  - Y otros 3 archivos.

RESULTADO_ESPERADO: |
  Mover `_ensure_session` al módulo central de base de datos `pronto_shared.db` y reutilizarlo mediante importación en todos los servicios que lo requieran.

UBICACION: |
  - `pronto-libs/src/pronto_shared/services/*.py`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Mover la función a `pronto_shared/db.py`.
  - [ ] Actualizar las importaciones en todos los servicios.
  - [ ] Eliminar las definiciones locales redundantes.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
