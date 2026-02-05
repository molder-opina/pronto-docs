---
ID: 20260205-F1
FECHA: 2026-02-05
PROYECTO: pronto-api, pronto-employees, pronto-static
SEVERIDAD: bloqueante
TITULO: Ausencia masiva de endpoints de API en el backend
DESCRIPCION: Una auditoría sistemática ha revelado que la gran mayoría de los endpoints de API que las aplicaciones frontend (Vue.js en `pronto-static`) consumen, no tienen una implementación correspondiente en los proyectos de backend (`pronto-api`, `pronto-employees`).
PASOS_REPRODUCIR: 1. Listar todas las llamadas `fetch` a `/api/...` en los archivos `.ts` y `.vue` de `pronto-static`. 2. Listar todas las rutas `@route` definidas en los archivos `.py` de `pronto-api` y `pronto-employees`. 3. Comparar las dos listas.
RESULTADO_ACTUAL: El frontend intenta llamar a docenas de endpoints para funcionalidades críticas (gestión de clientes, mesas, áreas, reportes, sesiones, empleados, etc.) que devuelven errores 404 porque no existen en el backend.
RESULTADO_ESPERADO: Debería existir una implementación en Python (Flask) para cada endpoint que el frontend consume.
UBICACION: `pronto-api/src/api_app/routes/` y `pronto-employees/src/pronto_employees/routes/api/`.
EVIDENCIA: Llamadas en frontend a endpoints como `/api/customers/stats`, `/api/tables`, `/api/reports/sales`, `/api/employees`, `/api/sessions/anonymous` no tienen contraparte en los archivos de rutas del backend.
HIPOTESIS_CAUSA: El código del backend para la mayoría de las funcionalidades del proyecto está ausente del repositorio. El desarrollo del frontend parece haber avanzado basándose en un contrato de API que nunca fue implementado o fue eliminado.
ESTADO: RESUELTO
---

SOLUCION:
Se implemento `routes-only-check` + `api-parity-check` determinista con allowlist/denylist y se agregaron endpoints faltantes en employees/clients para eliminar 404/405 en `/api/*`.

COMMIT:
f03ce0b
2f6533a
ba06b96
237f17b
1eff2a9
e5f461b

FECHA_RESOLUCION:
2026-02-05
