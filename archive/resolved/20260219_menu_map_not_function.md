ID: ERR-20260219-MENU-MAP-NOT-FUNCTION
FECHA: 2026-02-19
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: use-menu.ts falla con TypeError: e.value.map is not a function
DESCRIPCION: El composable use-menu.ts esperaba que el endpoint /api/menu devolviera un array de categorias directamente, pero la API devuelve un objeto con estructura { data: { categories: [...] } }. Al hacer unwrap de data, el resultado es { categories: [...] }, no un array, causando que categories.value.map falle.
PASOS_REPRODUCIR:
1. Abrir pagina del menu de clientes
2. Ver error en consola: TypeError: e.value.map is not a function
RESULTADO_ACTUAL: Menu no se renderiza, error en consola
RESULTADO_ESPERADO: Menu se renderiza correctamente con las categorias
UBICACION: pronto-static/src/vue/shared/utils/use-menu.ts:20
EVIDENCIA:
```javascript
// Antes del fix
const data = await requestJSON<Category[]>('/api/menu');
categories.value = data || [];  // data = { categories: [...] }

// availableCategories intenta hacer:
categories.value.map(c => ...)  // Error: object has no .map()
```
HIPOTESIS_CAUSA: El tipo generico Category[] era incorrecto; la API devuelve { categories: Category[] }
ESTADO: RESUELTO
SOLUCION: Corregido el tipo generico y el acceso a la propiedad categories:
```typescript
const data = await requestJSON<{ categories?: Category[] }>('/api/menu');
categories.value = data?.categories || [];
```
COMMIT: pending
FECHA_RESOLUCION: 2026-02-19
