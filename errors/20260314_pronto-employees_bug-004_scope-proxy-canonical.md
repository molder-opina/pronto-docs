# BUG-004 - Employees proxy scope-aware canónico

- Fecha: 2026-03-14
- Repo: `pronto-employees`
- Estado: aplicado

## D0 verificación previa
1. Búsqueda ejecutada:
   - `rg -n "url_prefix=\"/api\"|url_prefix=f\"/{_scope}/api\"" pronto-employees/src/pronto_employees -g"*.py"`
2. Evidencia:
   - Solo queda registro scoped: `url_prefix=f"/{_scope}/api"`.
3. Clasificación D0: `EXISTE`.
4. Decisión D0: `modificar` (retiro de alias no scoped).

## Implementación
- Aplicado previamente en commit `a1dc9b1` (`pronto-employees`).

## Validación
- `employees_unscoped_api_prefix=0` ✅
