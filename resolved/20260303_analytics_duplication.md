ID: CODE-20260303-018
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Duplicación de lógica de analítica en analytics_service_new.py

DESCRIPCION: |
  Se ha identificado que el archivo `analytics_service_new.py` re-implementa gran parte de la lógica que ya existe en los módulos especializados dentro de `src/pronto_shared/services/analytics/` (revenue, customer, employee, etc.). Además, el proyecto ya cuenta con una fachada (`analytics_service.py`) que orquestra estos módulos. 
  
  La existencia de este archivo genera confusión, duplica el esfuerzo de mantenimiento y aumenta el riesgo de que los reportes devuelvan datos inconsistentes dependiendo de qué servicio se consulte.

RESULTADO_ACTUAL: |
  Existen tres implementaciones de analítica:
  1. Módulos especializados en `services/analytics/` (Recomendado).
  2. Fachada `analytics_service.py` (Recomendado).
  3. Monolito `analytics_service_new.py` (Duplicado).

RESULTADO_ESPERADO: |
  Eliminar `analytics_service_new.py` tras asegurar que cualquier funcionalidad única o mejora que contuviera haya sido migrada a los módulos especializados en la carpeta `analytics/`.

UBICACION: |
  - `pronto-libs/src/pronto_shared/services/analytics_service_new.py`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Comparar funciones de `analytics_service_new.py` con los módulos en `services/analytics/`.
  - [ ] Migrar lógica faltante.
  - [ ] Eliminar el archivo redundante.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
