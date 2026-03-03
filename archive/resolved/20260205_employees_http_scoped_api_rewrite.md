---
ID: ERR-20260205-EMPLOYEES-SCOPED-API-REWRITE
FECHA: 2026-02-05
PROYECTO: pronto-static
SEVERIDAD: bloqueante
TITULO: Wrapper HTTP de employees reescribe /api/* a /{scope}/api/* (ruta no canonica)
DESCRIPCION: La politica canonica define que employees atiende /api/* por host (employees.<dominio>) y prohible APIs scoped por path. El wrapper actual reescribe /api/* a /waiter/api/*, /admin/api/*, etc., lo que provoca 404/405 y rompe el contrato.
PASOS_REPRODUCIR: 1) Abrir pronto-static/src/vue/employees/core/http.ts. 2) Llamar requestJSON('/api/roles', ...) desde una URL /waiter/*. 3) Ver que el wrapper genera /waiter/api/roles.
RESULTADO_ACTUAL: Se generan rutas /{scope}/api/* no soportadas por el backend.
RESULTADO_ESPERADO: El wrapper debe llamar siempre a /api/* (sin rewrite de scope).
UBICACION: pronto-static/src/vue/employees/core/http.ts
EVIDENCIA: Comentarios y logica en requestJSON/authenticatedFetch que reescriben /api/* a /<scope>/api/*.
HIPOTESIS_CAUSA: Se intento reutilizar el scope SSR (/waiter, /admin, etc.) para API, violando el contrato canonico por host.
ESTADO: RESUELTO
---

SOLUCION:
Se elimino el rewrite `/<scope>/api/*` en employees y se hizo canonico `/api/*` por host.

COMMIT:
f03ce0b
237f17b

FECHA_RESOLUCION:
2026-02-05
