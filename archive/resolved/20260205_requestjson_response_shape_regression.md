---
ID: 20260205-STATIC-REQUESTJSON-SHAPE
FECHA: 2026-02-05
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: requestJSON devuelve shape inconsistente (data vs flatten) y rompe consumidores
DESCRIPCION: El wrapper HTTP `requestJSON` en pronto-static cambio el shape de respuesta en success (unwrap de `success_response`) de forma incompatible con consumidores existentes que esperan `response.data.*`. Esto rompe modulos que usan `requestJSON` con `success_response` canonico.
PASOS_REPRODUCIR: 1. Abrir cualquier modulo employees que use `requestJSON` y luego acceda `response.data.*` (por ejemplo, schedules). 2. Ejecutar la accion que llama el endpoint. 3. Observar error JS por `response.data` undefined.
RESULTADO_ACTUAL: `requestJSON` retorna solo el payload interno, por lo que `response.data` deja de existir y se rompe el acceso esperado.
RESULTADO_ESPERADO: `requestJSON` debe ser retrocompatible: exponer `response.data` (envelope canonico) y permitir acceso directo a propiedades del payload (flatten) sin romper consumidores.
UBICACION: `pronto-static/src/vue/employees/core/http.ts` y `pronto-static/src/vue/clients/core/http.ts`
EVIDENCIA: `product-schedules-manager.ts` usa `const response = await requestJSON(...); const categories = response.data?.categories ?? []`.
HIPOTESIS_CAUSA: Se introdujo un cambio de conveniencia (unwrap) sin actualizar todos los consumidores existentes y sin mantener compatibilidad.
ESTADO: RESUELTO
---

SOLUCION:
Se mantuvo compatibilidad en `requestJSON` retornando `status/data/error` y tambien aplanando el payload para usos legacy.

COMMIT:
237f17b

FECHA_RESOLUCION:
2026-02-05
