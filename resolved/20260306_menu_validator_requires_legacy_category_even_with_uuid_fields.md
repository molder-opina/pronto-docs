ID: TEST-20260306-026
FECHA: 2026-03-06
PROYECTO: pronto-libs,pronto-tests
SEVERIDAD: media
TITULO: MenuValidator sigue exigiendo category legacy aunque lleguen UUIDs canónicos
DESCRIPCION:
  `validate_create()` requería `category` incluso cuando el payload ya traía UUIDs válidos.
ESTADO: RESUELTO
SOLUCION:
  Se condicionó la validación de `category` para exigirla solo cuando falta `menu_category_id`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
