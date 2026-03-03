---
ID: 20260202-B1
FECHA: 2026-02-02
PROYECTO: pronto-employees
SEVERIDAD: bloqueante
TITULO: Endpoints de API para 'branding' no existen en el backend.
DESCRIPCION: Múltiples plantillas (`branding.html`, `dashboard.html`) contienen código JavaScript que realiza llamadas a endpoints bajo `/api/branding/` (ej. `/api/branding/config`). Sin embargo, no se ha encontrado ninguna implementación de estas rutas en el código Python del proyecto.
PASOS_REPRODUCIR: 1. Abrir la sección "Gestión de Marca" en la aplicación de empleados. 2. Observar la consola del navegador. Se verán errores 404 para las llamadas a `/api/branding/...`. 3. Buscar el código de estos endpoints en el proyecto.
RESULTADO_ACTUAL: La funcionalidad de gestión de marca está completamente rota y arroja errores 404.
RESULTADO_ESPERADO: Deberían existir los endpoints en el backend de `pronto-employees` que gestionen la configuración, subida y generación de 'branding'.
UBICACION: `pronto-employees/src/pronto_employees/routes/` (Ubicación esperada, actualmente ausente)
EVIDENCIA: Las plantillas `branding.html` y `dashboard.html` contienen `fetch('/api/branding/config')`. La búsqueda de este endpoint en el código `.py` no arroja resultados.
HIPOTESIS_CAUSA: El código del backend para esta funcionalidad nunca fue añadido al repositorio o fue eliminado accidentalmente.
ESTADO: RESUELTO
---
SOLUCION: Se implementó el backend faltante. Se creó el archivo `pronto-employees/src/pronto_employees/routes/api_branding.py` con los endpoints requeridos (`/config`, `/logo`). Se creó la tabla `branding_config` en la base de datos y se registró el nuevo blueprint en `app.py`.
COMMIT: N/A_AGENT
FECHA_RESOLUCION: 2026-02-02