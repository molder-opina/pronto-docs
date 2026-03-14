# BUG-007 - SSR inline JS -> Vue (objetivo gradual)

- Fecha: 2026-03-14
- Repo: `pronto-client` / `pronto-static`
- Estado: parcial

## D0 verificación previa
1. Búsqueda ejecutada:
   - `rg -n --pcre2 "<script(?![^>]*src=)" pronto-client/src/pronto_clients/templates`
2. Evidencia:
   - 14 bloques inline activos (index/base/includes/kiosk/feedback).
3. Clasificación D0: `EXISTE`.
4. Decisión D0: `modificar` (sincrónico por lotes funcionales, no por archivo).

## Implementación en esta corrida
- Se estabilizó build Vue clients con entrypoints y módulos faltantes para preparar retiro de inline JS.
- Build de clientes ahora compila.

## Validación
- `npm run build:clients` ✅
- `npx playwright test tests/functionality/ui/playwright-tests/clients/menu-runtime.spec.ts` ✅
