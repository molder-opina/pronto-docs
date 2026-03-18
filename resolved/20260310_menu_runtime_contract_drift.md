ID: BUG-20260310-MENU-RUNTIME-CONTRACT-DRIFT
FECHA: 2026-03-10
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: Tests/diagnósticos de menú siguen leyendo `data.categories` en vez del contrato runtime actual
DESCRIPCION: Consumidores de `/api/menu` dentro de tests/diagnóstico seguían asumiendo un contrato viejo con `data.categories` y `category.items`, cuando el runtime actual usa `data.taxonomy.categories` y `data.catalog_items`.
PASOS_REPRODUCIR:
1. Ejecutar `employees/menu.spec.ts`.
2. Observar fallos al leer categorías/ítems con el shape viejo.
RESULTADO_ACTUAL: Resuelto.
RESULTADO_ESPERADO: Tests/diagnósticos deben leer el contrato runtime actual con fallback compatible.
UBICACION:
- pronto-tests/tests/functionality/ui/playwright-tests/employees/menu.spec.ts
- pronto-tests/verify_client_proxy.py
EVIDENCIA:
- Probe del payload real mostró `data.taxonomy.categories` + `data.catalog_items`.
- `menu.spec.ts` pasó 2/2 tras el fix.
HIPOTESIS_CAUSA: Drift entre tests heredados y el contrato moderno del endpoint `/api/menu`.
ESTADO: RESUELTO
SOLUCION:
- `menu.spec.ts` ahora valida `taxonomy.categories` y `catalog_items`.
- `verify_client_proxy.py` extrae ítems desde `catalog_items` con fallback a estructuras viejas.
- Se revalidó con Playwright y `py_compile`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-10

