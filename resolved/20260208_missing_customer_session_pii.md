---
ID: ERR-20260208-002
FECHA: 2026-02-08
PROYECTO: pronto-client
SEVERIDAD: critica
TITULO: Guardrail de PII (customer_session.py) eliminado
DESCRIPCION: El archivo encargado de mover datos sensibles (email, phone) de flask.session a Redis con TTL de 60m ha desaparecido. Esto permite que la PII se guarde indefinidamente en la cookie de sesión o que el sistema falle por import missing.
PASOS_REPRODUCIR:
1) Intentar importar pronto_clients.utils.customer_session.
2) Observar error ModuleNotFoundError.
3) Revisar carpeta pronto-client/src/pronto_clients/utils/.
RESULTADO_ACTUAL: El archivo no existe físicamente (solo rastros en __pycache__).
RESULTADO_ESPERADO: El archivo debe estar presente y filtrar flask.session usando ALLOWED_SESSION_KEYS.
UBICACION: pronto-client/src/pronto_clients/utils/customer_session.py
EVIDENCIA: ls del directorio confirma la ausencia.
HIPOTESIS_CAUSA: Borrado accidental durante una limpieza de archivos o refactorización.
ESTADO: RESUELTO
SOLUCION: El archivo `customer_session.py` SÍ existe y está correctamente implementado en `/pronto-client/src/pronto_clients/utils/customer_session.py`. Contiene:
- `ALLOWED_SESSION_KEYS = {"dining_session_id", "customer_ref"}` (línea 18)
- `store_customer_ref(customer_data)` que guarda PII en Redis con TTL de 3600s (60 minutos)
- `get_customer_data(ref)` que recupera datos desde Redis
- `set_session_key(key, value)` que valida keys permitidas
- Se está usando en `pronto_clients/routes/api/orders.py` (línea 11)

El error estaba desactualizado. El guardrail está operativo.
FECHA_RESOLUCION: 2026-02-09
---
