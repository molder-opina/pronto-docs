# BUG-009 - Naming canónico y rutas de tooling

- Fecha: 2026-03-14
- Repo: `pronto-static`
- Estado: aplicado

## D0 verificación previa
1. Búsqueda ejecutada:
   - `rg -n "generate-canonical-types-final.py|generate_canonical_types_final.py" pronto-static/package.json`
2. Evidencia:
   - El script apuntaba a nombre inexistente (`generate-canonical-types-final.py`).
3. Clasificación D0: `EXISTE`.
4. Decisión D0: `modificar`.

## Implementación
- `package.json` actualizado a `scripts/generate_canonical_types_final.py`.

## Validación
- `naming_mismatch_script_path=0` ✅
- `npm run build:employees` ✅
- `npm run build:clients` ✅
