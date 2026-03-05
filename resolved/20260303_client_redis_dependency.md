ID: REL-20260303-001
FECHA: 2026-03-03
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Punto único de fallo (SPOF) en dependencia de Redis para sesiones de cliente

DESCRIPCION: |
  La arquitectura de `pronto-client` delega toda la autenticación y estado del cliente a Redis mediante el uso de `customer_ref`. Actualmente, si el servicio Redis no está disponible o responde con lentitud, prácticamente todas las funcionalidades de la aplicación (incluyendo ver el menú si se está en una mesa) fallan con errores 503 o 401.

RESULTADO_ACTUAL: |
  Las rutas protegidas por `@customer_session_required` lanzan `SERVICE_UNAVAILABLE` inmediatamente si Redis falla. No existe un mecanismo de "graceful degradation" (degradación graciosa) que permita a los clientes continuar con acciones básicas de lectura o recuperar su estado mediante una caché local/cookie firmada de respaldo.

RESULTADO_ESPERADO: |
  El sistema debería ser más resiliente. Acciones que no requieren modificar el estado (como visualizar el menú o el carrito local) deberían ser posibles incluso si Redis tiene una caída temporal, o al menos el sistema debería proporcionar un mensaje de error más amigable que permita el reintento automático.

UBICACION: |
  - `pronto-client/src/pronto_clients/routes/api/auth.py` (decorador `customer_session_required`)
  - `pronto-libs/src/pronto_shared/services/customer_session_store.py`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Evaluar el uso de JWT firmado (stateless) también para clientes como respaldo al `customer_ref` de Redis.
  - [ ] Implementar un interruptor de circuito (Circuit Breaker) para las llamadas a Redis.
  - [ ] Mejorar el manejo de `RedisUnavailableError` en el frontend para mostrar estados de "Modo Offline" cuando sea posible.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
