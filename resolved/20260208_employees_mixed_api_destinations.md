---
ID: ERR-20260208-008
FECHA: 2026-02-08
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: Mezcla inconsistente de destinos de API en dashboard SSR
DESCRIPCION: El dashboard SSR (Jinja2) utiliza window.API_BASE (puerto 6082 - pronto-api) para cargar datos de sesiones, pero utiliza rutas relativas /api/sessions/... (puerto 6081 - pronto-employees) para mutaciones como "Cerrar Sesión". Esto fragmenta la lógica y dificulta la depuración.
PASOS_REPRODUCIR:
1) Revisar scripts embebidos en dashboard.html.
2) Comparar la URL de loadSessions() con la de closeSession().
RESULTADO_ACTUAL: Las lecturas van a una API y las escrituras a otra.
RESULTADO_ESPERADO: Todas las llamadas AJAX deben ser consistentes y apuntar a la misma base de URL (preferiblemente el núcleo pronto-api vía window.API_BASE).
UBICACION: pronto-employees/src/pronto_employees/templates/dashboard.html
EVIDENCIA: Línea 515 usa ${window.API_BASE}/api/sessions/all; línea 562 usa fetch(/api/sessions/${sessionId}/close).
HIPOTESIS_CAUSA: Migración parcial de scripts de frontend sin estandarizar el objeto de configuración.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Normalizar todas las llamadas fetch en dashboard.html para usar window.API_BASE.
2. Asegurar que las variables de contexto de Jinja2 pasen siempre la URL base correcta.
