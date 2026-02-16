---
ID: CSRF_EXEMPTIONS_CLIENT_API
FECHA: 20260211
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Exenciones masivas de CSRF en la API del cliente [RESUELTO]
DESCRIPCION: Se han eliminado las exenciones de CSRF en `pronto-client/src/pronto_clients/app.py` y se ha implementado el manejo automático de tokens CSRF en el wrapper `requestJSON` de `pronto-static/src/vue/clients/core/http.ts`. Ahora todas las peticiones mutantes (POST, PUT, DELETE, PATCH) envían correctamente el encabezado `X-CSRFToken` obtenido de la etiqueta meta del documento.
ESTADO: RESUELTO
---
SOLUCION:
1. Refactorizado `pronto-static/src/vue/clients/core/http.ts` para extraer `csrf-token` de meta tags y enviarlo en peticiones mutantes.
2. Actualizado `pronto-client/src/pronto_clients/app.py` eliminando `csrf_protection.exempt()` para todos los blueprints de la API.
3. Verificado build de clientes exitosamente.
---
