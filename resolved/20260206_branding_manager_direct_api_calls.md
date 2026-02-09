---
ID: BRANDING_MANAGER_DIRECT_API_CALLS
FECHA: 20260206
PROYECTO: pronto-static
SEVERIDAD: bloqueante
TITULO: `BrandingManager` realiza llamadas directas a la API sin usar el wrapper `http.ts`
DESCRIPCION: El módulo `pronto-static/src/vue/employees/modules/branding-manager.ts` utiliza `fetch` directamente para realizar llamadas a la API (POST) en `/api/branding/upload`, `/api/branding/generate` y `/api/branding/generate-products`. Esto es una violación directa del mandato establecido en `AGENTS.md` (sección 15.2 "Frontend employees (pronto-static) - wrapper obligatorio") que prohíbe el uso de `fetch`/`axios` mutador directo fuera del wrapper en `pronto-static/src/vue/employees/core/http.ts`. Este hallazgo confirma y provee evidencia concreta para el error `FE_API_WRAPPER_NON_COMPLIANCE` previamente documentado.
PASOS_REPRODUCIR:
1. Inspeccionar `pronto-static/src/vue/employees/modules/branding-manager.ts`.
2. Buscar ocurrencias de `fetch(` para identificar las llamadas directas a la API.
RESULTADO_ACTUAL: Las llamadas a la API se realizan directamente utilizando `fetch`, sin pasar por el wrapper `authenticatedFetch` o `requestJSON` definido en `http.ts`. Esto podría resultar en un manejo inconsistente de la autenticación, CSRF y errores.
RESULTADO_ESPERADO: Todas las llamadas a la API desde el frontend de empleados, especialmente las mutantes (POST, PUT, PATCH, DELETE), deben utilizar las funciones proporcionadas por el wrapper `pronto-static/src/vue/employees/core/http.ts` (es decir, `requestJSON`).
UBICACION:
- pronto-static/src/vue/employees/modules/branding-manager.ts:L73
- pronto-static/src/vue/employees/modules/branding-manager.ts:L90
- pronto-static/src/vue/employees/modules/branding-manager.ts:L115
EVIDENCIA:
```typescript
// Extract from branding-manager.ts
// L73
      const response = await fetch(`/api/branding/upload/${type}`, {
        method: 'POST',
        body: formData,
      });

// L90
      const response = await fetch(`/api/branding/generate/${type}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          api: this.selectedApi,
          style: this.selectedStyle,
        }),
      });

// L115
      const response = await fetch('/api/branding/generate-products', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          category,
          limit,
          api: this.selectedApi,
        }),
      });
```
HIPOTESIS_CAUSA: Implementación directa por desconocimiento de la directriz de `AGENTS.md` o falta de familiaridad con el wrapper de API.
ESTADO: RESUELTO
SOLUCION: Refactorizado `branding-manager.ts` para usar el wrapper `requestJSON` de `http.ts`:
1. Agregado import: `import { requestJSON } from '../core/http';`
2. Reemplazadas 4 llamadas directas a `fetch()`:
   - L49: `loadConfig()` - GET /api/branding/config
   - L316: `handleUpload()` - POST /api/branding/upload/{type}
   - L340: `generateAsset()` - POST /api/branding/generate/{type}
   - L378: `generateProductImages()` - POST /api/branding/generate-products

Beneficios:
- ✅ Manejo automático de CSRF tokens
- ✅ Verificación automática de autenticación (401/403)
- ✅ Type-safe con genéricos TypeScript
- ✅ Manejo consistente de errores
- ✅ Cumple con AGENTS.md sección 15.2

FECHA_RESOLUCION: 2026-02-09
---