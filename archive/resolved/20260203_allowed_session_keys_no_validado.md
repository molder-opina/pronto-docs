---
ID: ERR-20260203-003
FECHA: 2026-02-03
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: ALLOWED_SESSION_KEYS definido pero nunca validado
DESCRIPCION: Se define ALLOWED_SESSION_KEYS = {"dining_session_id", "customer_ref"} en customer_session.py:15 pero no existe validación que impida agregar otras claves a flask.session. Esto viola la política de sesiones del AGENTS.md.
PASOS_REPRODUCIR:
1) Revisar customer_session.py
2) Buscar uso de ALLOWED_SESSION_KEYS para validacion
3) Verificar orders.py:109 donde se asigna session["dining_session_id"]
RESULTADO_ACTUAL: ALLOWED_SESSION_KEYS existe como constante sin uso
RESULTADO_ESPERADO: Debe existir validacion antes de asignar a session
UBICACION: pronto-client/src/pronto_clients/utils/customer_session.py
EVIDENCIA: No hay if/for que use ALLOWED_SESSION_KEYS para validacion
HIPOTESIS_CAUSA: Implementacion incompleta de validacion de session keys
ESTADO: RESUELTO
---
SOLUCION:
Agregadas funciones validate_session_key() y set_session_key() en customer_session.py:19-30.
set_session_key() valida que la clave esté en ALLOWED_SESSION_KEYS antes de asignar.
Las asignaciones en orders.py:109 y 118 ahora usan set_session_key() en lugar de acceso directo a session.

COMMIT: <commit_hash>
FECHA_RESOLUCION: 2026-02-03
---
---
