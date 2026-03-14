# BUG-008 - Prohibición de silenciamiento de errores

- Fecha: 2026-03-14
- Repo: `pronto-libs` (+ transversal)
- Estado: aplicado

## D0 verificación previa
1. Búsqueda ejecutada:
   - `rg -n --pcre2 "except(\\s+Exception)?\\s*:\\s*pass" pronto-api/src pronto-client/src pronto-employees/src pronto-libs/src -g"*.py"`
2. Evidencia:
   - 0 ocurrencias.
3. Clasificación D0: `EXISTE` (histórico), estado actual saneado.
4. Decisión D0: `modificar` (en commits previos se sustituyó `pass` por logging/errores explícitos).

## Validación
- `silent_except_pass=0` ✅
