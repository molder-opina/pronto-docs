# BUG-010 - Cierre transversal y DoD objetivo

- Fecha: 2026-03-14
- Alcance: `pronto-*` canónicos
- Estado: en progreso (big-bang ejecutado con remanentes medibles)

## D0 verificación previa
1. Se ejecutó barrido transversal con `rg` por patrón de deuda técnica en:
   - `pronto-api`, `pronto-client`, `pronto-employees`, `pronto-static`, `pronto-libs`, `pronto-scripts`.

## Métricas actuales
- `state_assignments=7`
- `custom_role_symbols=0`
- `employees_unscoped_api_prefix=0`
- `dom_legacy_patterns=140`
- `inline_script_tags=14`
- `silent_except_pass=0`

## Gates ejecutados
- `./pronto-scripts/bin/pronto-rules-check full` ✅
- `./pronto-scripts/bin/pronto-no-legacy` ✅
- `./pronto-scripts/bin/pronto-migrate --check` ❌ (`pending=8 drift=0`, migraciones pendientes)
- `./pronto-scripts/bin/pronto-init --check` ❌ (hereda `pronto_migrate_check` con `pending=8`)
- Playwright objetivo propuesto en plan (`vue-rendering.spec.ts`, `vue-integrity.spec.ts`) ❌ (no existen en `pronto-tests`)
- Validación equivalente ejecutada:
  - `employees/auth.spec.ts` ✅
  - `clients/menu-runtime.spec.ts` ✅

## Nota SMB
- Se priorizó estabilización funcional incremental en componentes críticos para restaurante pequeño-mediano sin detener operación por refactors cosméticos.
