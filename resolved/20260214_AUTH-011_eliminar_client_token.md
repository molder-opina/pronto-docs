ID: AUTH-011
FECHA: 2026-02-14
PROYECTO: pronto-libs
SEVERIDAD: baja
TITULO: create_client_token - Separación de concerns auth vs anonymous sessions
DESCRIPCION: 
create_client_token se usa para sesiones anónimas (dining), NO para auth de clientes registrados.
La separación correcta es:
- Clientes registrados → Redis customer_ref (AUTH-007)
- Sesiones anónimas (dining) → JWT con anon_id/session_id (create_client_token)
PASOS_REPRODUCIR:
1. POST /api/sessions/open con table_id
2. Token JWT generado para sesión anónima
RESULTADO_ACTUAL:
create_client_token usado para anonymous sessions correctamente
RESULTADO_ESPERADO:
- Mantener create_client_token para anonymous sessions
- Documentar separación en jwt_service.py docstring
- client_sessions.py es el único consumidor
UBICACION:
- pronto-libs/src/pronto_shared/jwt_service.py
- pronto-api/src/api_app/routes/client_sessions.py
EVIDENCIA:
client_sessions.py usa create_client_token para sesiones anónimas
HIPOTESIS_CAUSA:
Malentendido del alcance del refactor
ESTADO: CANCELADO
DEPENDENCIAS: AUTH-007 (nuevo auth funcionando)
BLOQUEA: Ninguna
NOTA: create_client_token NO se elimina, se mantiene para sesiones anónimas de dining