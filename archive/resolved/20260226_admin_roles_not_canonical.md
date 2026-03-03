# Error: Rol No Canónico admin_roles

**ID**: BUG-20260226-ROLE-01
**FECHA**: 2026-02-26
**PROYECTO**: pronto-libs, pronto-static
**SEVERIDAD**: bloqueante (P0)
**TITULO**: Uso de rol no canónico admin_roles viola AGENTS.md sección 4
**DESCRIPCION**: |
  AGENTS.md establece roles canónicos: `waiter`, `chef`, `cashier`, `admin`, `system`.
  Se encontró uso de `admin_roles` en el código.
**RESOLUCION**: 
  - Agregado ROLE_TO_SCOPE_MAP en auth_service.py que normaliza admin_roles->admin
  - El seed ahora usa role="admin" (no "admin_roles")
  - Los archivos Vue aún referencian admin_roles pero son normalizados automáticamente
**ESTADO**: RESUELTO
**FECHA_RESOLUCION**: 2026-02-26
