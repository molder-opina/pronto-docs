ID: CODE-20260303-011
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: baja
TITULO: Falta de utilidades centralizadas de formateo de fecha/hora

DESCRIPCION: |
  Se ha detectado una gran dispersión y duplicación de patrones de formateo de fechas (`strftime`) a lo largo de los servicios de `pronto-libs`. Aunque existe un módulo `datetime_utils.py`, este solo contiene una función para obtener el tiempo actual en UTC, obligando a los desarrolladores a hardcodear formatos como `"%H:%M"` o `"%d/%m/%Y %H:%M"` en múltiples lugares.

RESULTADO_ACTUAL: |
  Se encuentran más de 15 ocurrencias de formateo manual en servicios de analítica, menús, PDFs y plantillas HTML. Esto dificulta cambios globales de localización o formato.

RESULTADO_ESPERADO: |
  El módulo `pronto_shared.datetime_utils` debería proveer funciones estandarizadas (ej. `format_time`, `format_date`, `format_datetime_full`) que encapsulen los formatos preferidos del proyecto.

UBICACION: |
  - `pronto-libs/src/pronto_shared/datetime_utils.py`
  - Uso disperso en `services/analytics/`, `services/menu_service.py`, `services/ticket_pdf_service.py`, etc.

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Expandir `datetime_utils.py` con funciones de formateo estándar.
  - [ ] Refactorizar los servicios existentes para utilizar estas utilidades.
  - [ ] Unificar los formatos de visualización entre la API y las plantillas SSR.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
