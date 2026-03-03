ID: AUTH-012
FECHA: 2026-02-14
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Kiosko endpoints - GET pantalla y POST auto-login
DESCRIPCION: 
No hay endpoints para kiosko con auto-login seguro.
Se requiere GET para pantalla y POST para iniciar sesión.
PASOS_REPRODUCIR:
1. curl http://localhost:6080/kiosk/lobby
2. 404 Not Found
RESULTADO_ACTUAL:
No hay endpoints de kiosko
RESULTADO_ESPERADO:
- GET /kiosk/<location> - Muestra pantalla
- POST /kiosk/<location>/start - Auto-login con kind=kiosk
- Secret requerido en producción
UBICACION:
- pronto-client/src/pronto_clients/routes/web.py
EVIDENCIA:
No hay rutas /kiosk/
HIPOTESIS_CAUSA:
Funcionalidad no implementada
ESTADO: RESUELTO
DEPENDENCIAS: AUTH-003, AUTH-005 (requiere store y service)
BLOQUEA: Ninguna
SOLUCION:
- GET /kiosk/<location> - Pantalla de bienvenida (template kiosk.html)
- POST /kiosk/<location>/start - Auto-login con cuenta kiosk
- Crea/reutiliza cuenta con email kiosk+<location>@pronto.local
- kind="kiosk" en customer y customer_ref
- Seguridad: PRONTO_KIOSK_SECRET en producción, debug mode sin secret
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-14