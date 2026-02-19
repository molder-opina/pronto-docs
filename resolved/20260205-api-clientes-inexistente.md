---
ID: 20260205-F2
FECHA: 2026-02-05
PROYECTO: pronto-employees, pronto-static
SEVERIDAD: alta
TITULO: Endpoints de API para Gestión de Clientes (`/api/customers`) no existen
DESCRIPCION: La re-auditoría del código revela que, aunque se han añadido muchos endpoints, la funcionalidad de gestión de clientes (módulo `customers-manager.ts` en el frontend) sigue sin tener una implementación en el backend.
PASOS_REPRODUCIR: 1. Revisar `pronto-static/src/vue/employees/modules/customers-manager.ts` para ver las llamadas a `/api/customers/...`. 2. Buscar las implementaciones de estas rutas en `pronto-employees` y `pronto-api`.
RESULTADO_ACTUAL: El frontend intenta llamar a `/api/customers/stats`, `/api/customers/search`, etc., que devuelven errores 404.
RESULTADO_ESPERADO: Debería existir un archivo de rutas en el backend (ej. `pronto-employees/routes/api/customers.py`) que implemente la lógica para estos endpoints.
UBICACION: `pronto-employees/src/pronto_employees/routes/api/` (Ubicación esperada del archivo faltante)
EVIDENCIA: No existe un `Blueprint` o archivo de rutas para manejar las rutas bajo `/api/customers/`.
HIPOTESIS_CAUSA: La funcionalidad de clientes aún no ha sido implementada en el backend.
ESTADO: RESUELTO
---
