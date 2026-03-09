## CSRF cliente

- Rutas mutantes de cliente (`/api/auth/*`, `/api/sessions/*`, checkout mutaciones) envían `X-CSRFToken`.
- Token fuente: `<meta name="csrf-token">` (inyectado SSR).
- Wrapper canónico:
  - `pronto-static/src/vue/clients/core/http.ts`
- Home publicada (`assets/pronto/menu/home-published.json`) es artefacto estático de solo lectura y no participa en CSRF.

### Regla operativa
- Si una mutación falla por CSRF, el arreglo correcto es propagar el token desde la capa SSR/UI; no desactivar CSRF.
