---
ID: ERR-20260205-EMPLOYEES-CREDENTIALS-SAME-ORIGIN
FECHA: 2026-02-05
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Wrapper HTTP de employees usa credentials same-origin (canon requiere include)
DESCRIPCION: Guardrails requieren que el frontend employees use credentials: 'include' en fetch a /api/* para soportar cookies en escenarios cross-subdomain/reverse-proxy. El wrapper actual usa credentials: 'same-origin'.
PASOS_REPRODUCIR: 1) Abrir pronto-static/src/vue/employees/core/http.ts. 2) Ver fetch(..., { credentials: 'same-origin' }).
RESULTADO_ACTUAL: En configuraciones con hosts separados, las cookies pueden no enviarse correctamente.
RESULTADO_ESPERADO: Usar credentials: 'include' de forma canonica.
UBICACION: pronto-static/src/vue/employees/core/http.ts
EVIDENCIA: fetch() en requestJSON usa credentials: 'same-origin'.
HIPOTESIS_CAUSA: Wrapper fue implementado con default browser local sin considerar despliegue multi-host.
ESTADO: RESUELTO
---

SOLUCION:
Se enforcea `credentials: include` en el wrapper HTTP de employees.

COMMIT:
237f17b

FECHA_RESOLUCION:
2026-02-05
