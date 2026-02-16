ID: AUTH-008
FECHA: 2026-02-14
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: Proxy API - Agregar header X-PRONTO-CUSTOMER-REF y auto-clear session
DESCRIPCION: 
orders.py en pronto-client usa @jwt_required y no envía customer_ref.
Debe ser proxy puro que envíe header desde session.
PASOS_REPRODUCIR:
1. POST /api/orders con sesión válida
2. Error: "Autenticacion requerida" (busca JWT)
RESULTADO_ACTUAL:
Proxy usa @jwt_required, no envía customer_ref
RESULTADO_ESPERADO:
- Quitar @jwt_required
- Leer customer_ref de session
- Enviar header X-PRONTO-CUSTOMER-REF
- Auto-clear session si API retorna 401 revoked/expired
UBICACION:
- pronto-client/src/pronto_clients/routes/api/orders.py (líneas 21-22)
EVIDENCIA:
@jwt_required decorator presente
HIPOTESIS_CAUSA:
Código usa JWT heredado
ESTADO: RESUELTO
DEPENDENCIAS: AUTH-003, AUTH-006 (requiere store y sin JWT)
BLOQUEA: AUTH-010
SOLUCION:
- Eliminado @jwt_required decorator
- Creada función _get_customer_ref() para leer de session
- Creada función _forward_to_api() que envía header X-PRONTO-CUSTOMER-REF
- Auto-clear session si API retorna 401
- Simplificado create_order() y get_current_session_orders()
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-14