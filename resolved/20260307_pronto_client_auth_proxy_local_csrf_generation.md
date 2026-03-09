ID: CLI-20260307-005
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: endpoint /api/client-auth/csrf del BFF genera CSRF local en lugar de proxyear el del API
DESCRIPCION:
  Durante el diagnóstico se consideró que la generación local de CSRF del SSR era la causa del fallo auth.
PASOS_REPRODUCIR:
  1. Obtener token en `/api/client-auth/csrf`.
  2. Intentar registrar cliente.
RESULTADO_ACTUAL:
  El flujo auth fallaba por CSRF/sesión.
RESULTADO_ESPERADO:
  El flujo debía registrar correctamente al cliente.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/auth.py`
EVIDENCIA:
  - el endpoint auth del BFF usa `generate_csrf()` local
HIPOTESIS_CAUSA:
  Se sospechó mezcla inválida entre sesión SSR y upstream API.
ESTADO: RESUELTO
SOLUCION:
  Se descartó como falso positivo: la causa real era la falta de passthrough de `X-CSRFToken`, cookies y `Set-Cookie`; con esos fixes el flujo live quedó operativo sin cambiar la estrategia local de CSRF.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07

