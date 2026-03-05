ID: CODE-20260303-014
FECHA: 2026-03-03
PROYECTO: pronto-libs
SEVERIDAD: media
TITULO: Constantes de límite de propina conflictivas en constants.py

DESCRIPCION: |
  Existían dos constantes conflictivas para límite de propina (`TIP_MAX_PERCENTAGE=100` y `TIP_MAX_PERCENT=50`), generando ambigüedad de validación.

RESULTADO_ACTUAL: |
  Distintos módulos podían aplicar límites distintos (100% vs 50%).

RESULTADO_ESPERADO: |
  Una única fuente de verdad para límite porcentual de propina.

UBICACION: |
  - `pronto-libs/src/pronto_shared/constants.py`
  - `pronto-libs/src/pronto_shared/services/order_service.py`

ESTADO: RESUELTO

SOLUCION: |
  Se eliminó `TIP_MAX_PERCENTAGE` y se estandarizó `calculate_tip_amount` para usar `TIP_MAX_PERCENT` (50%) como único límite canónico.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
