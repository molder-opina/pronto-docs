---
ID: ERR-20260208-006
FECHA: 2026-02-08
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Lógica de API operativa no registrada en app.py
DESCRIPCION: La carpeta routes/api contiene endpoints críticos para la operación del dashboard (cierre de sesiones, gestión de órdenes, etc.), pero el archivo principal app.py no registra el blueprint api_bp. Esto provoca que cualquier llamada a /api/* en el puerto 6081 resulte en un error 404.
PASOS_REPRODUCIR:
1) Iniciar pronto-employees.
2) Intentar acceder a un endpoint operativo, ej: GET /api/sessions/all.
3) Observar error 404 Not Found.
RESULTADO_ACTUAL: Rutas de la API operativa huérfanas y no accesibles.
RESULTADO_ESPERADO: El blueprint api_bp debe estar registrado con el prefijo /api.
UBICACION: pronto-employees/src/pronto_employees/app.py
EVIDENCIA: Función register_blueprints() solo incluye blueprints de autenticación de roles.
HIPOTESIS_CAUSA: Omisión durante la refactorización modular de rutas.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Importar api_bp desde pronto_employees.routes.api en app.py.
2. Registrar el blueprint en register_blueprints(app) usando url_prefix="/api".
3. Validar accesibilidad de endpoints clave tras el registro.
