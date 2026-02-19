---
ID: CLIENT_TEMPLATE_DIRECT_API_CALL
FECHA: 20260206
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Template de cliente (`index-alt.html`) realiza llamadas directas a la API con `fetch` y `credentials: 'same-origin'`
DESCRIPCION: El template `pronto-client/src/pronto_clients/templates/index-alt.html` contiene JavaScript inline que realiza una llamada directa a la API (`/api/tables`) utilizando `fetch`. Esta llamada no solo bypassa cualquier posible wrapper de API (aunque no hay uno explícitamente mandado para el cliente como en el frontend de empleados), sino que también utiliza `credentials: 'same-origin'`. Aunque la directriz `Prohibido: credentials: 'same-origin'` de `AGENTS.md` (sección 15.2) es específica para el frontend de empleados, la inconsistencia en el manejo de credenciales y la realización de llamadas API directamente desde el template es una desviación de las buenas prácticas de centralización y uniformidad de la comunicación API.
PASOS_REPRODUCIR:
1. Inspeccionar `pronto-client/src/pronto_clients/templates/index-alt.html`.
2. Buscar ocurrencias de `fetch(` en el JavaScript inline.
RESULTADO_ACTUAL: Llamada a `/api/tables` usando `fetch` con `credentials: 'same-origin'`.
RESULTADO_ESPERADO: Las llamadas a la API desde el frontend deberían centralizarse en un módulo dedicado (como un wrapper `http.ts` para el Vue frontend, si existiera y fuera utilizado) para asegurar consistencia en el manejo de errores, autenticación y credenciales. La directriz de `credentials: 'include'` debería considerarse para consistencia general en la autenticación.
UBICACION:
- pronto-client/src/pronto_clients/templates/index-alt.html:L557
EVIDENCIA:
```html
// Extract from index-alt.html
      tableOptionsPromise = fetch('/api/tables', {
        method: 'GET',
        credentials: 'same-origin',
        headers: { Accept: 'application/json' },
      })
```
HIPOTESIS_CAUSA: Implementación rápida de funcionalidad sin considerar la centralización de llamadas API o la unificación de la política de credenciales.
ESTADO: RESUELTO
---