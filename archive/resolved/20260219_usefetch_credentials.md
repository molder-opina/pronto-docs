ID: ERR-20260219-USEFETCH-CREDENTIALS
FECHA: 2026-02-19
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: useFetch.ts no incluye credentials para cookies
DESCRIPCION: El wrapper fetchJSON en useFetch.ts no incluia credentials: 'include', lo que impedia que las cookies de sesion se enviaran con las peticiones.
PASOS_REPRODUCIR:
1. Usar fetchJSON desde componentes Vue
2. Verificar que las cookies no se envian
RESULTADO_ACTUAL: Peticiones sin cookies de sesion
RESULTADO_ESPERADO: Peticiones con cookies incluidas
UBICACION: pronto-static/src/vue/shared/utils/useFetch.ts:14
EVIDENCIA:
```typescript
// Antes
const response = await fetch(url, {
  ...options,
  headers: {...}
})

// Despues
const response = await fetch(url, {
  ...options,
  credentials: 'include',
  headers: {...}
})
```
HIPOTESIS_CAUSA: Omision en implementacion inicial
ESTADO: RESUELTO
SOLUCION: Agregado credentials: 'include' al fetch options
COMMIT: pending
FECHA_RESOLUCION: 2026-02-19
