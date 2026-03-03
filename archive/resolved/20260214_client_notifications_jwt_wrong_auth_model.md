ID: BUG-20260214-001
FECHA: 2026-02-14
PROYECTO: pronto-client
SEVERIDAD: bloqueante
TITULO: notifications.py usa JWT (modelo de auth incorrecto para clientes)
DESCRIPCION: |
  El endpoint GET /api/notifications en pronto-client usa `get_current_user()` de
  `pronto_shared.jwt_middleware`, que es el modelo de autenticación de **empleados** (JWT).
  pronto-client debe usar `customer_ref` respaldado en Redis, no JWT.
  Adicionalmente, POST /api/notifications/<id>/read no tiene ninguna autenticación
  ni verificación de ownership — cualquier usuario puede marcar cualquier notificación
  como leída sin estar autenticado.
PASOS_REPRODUCIR: |
  1. Acceder a GET /api/notifications sin JWT cookie (como cliente normal).
  2. Observar que devuelve 401 porque busca JWT, no customer_ref.
  3. Acceder a POST /api/notifications/1/read sin autenticación.
  4. Observar que marca la notificación como leída sin verificar identidad.
RESULTADO_ACTUAL: |
  - GET /api/notifications usa JWT middleware (incorrecto para clientes).
  - POST /api/notifications/<id>/read no verifica autenticación ni ownership.
RESULTADO_ESPERADO: |
  - Ambos endpoints deben usar customer_ref de flask.session + Redis lookup.
  - POST /read debe verificar que la notificación pertenece al cliente autenticado.
UBICACION: pronto-client/src/pronto_clients/routes/api/notifications.py
EVIDENCIA: Línea 19-23 importa y usa `get_current_user` de `jwt_middleware`. Línea 61-75 no tiene ningún guard de autenticación.
HIPOTESIS_CAUSA: Se copió el patrón de pronto-employees sin adaptarlo al modelo de auth de clientes (Redis customer_ref).
ESTADO: RESUELTO
SOLUCION: Corregido en versión 1.0038
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-14
