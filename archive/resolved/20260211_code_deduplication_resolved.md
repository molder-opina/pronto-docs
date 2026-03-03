---
ID: BUG-20250209-003-CODE-DEDUPLICATION
FECHA: 20260211
PROYECTO: PRONTO
SEVERIDAD: alta
TITULO: Deduplicación de Código y Eliminación de flask.session [RESUELTO]
DESCRIPCION: Se ha eliminado el uso de `flask.session` en el portal del cliente, moviendo toda la gestión de estado temporal y PII (Personally Identifiable Information) a Redis mediante la librería compartida `pronto_shared`. También se ha unificado la lógica de gestión de sesiones en `DiningSessionService`.
ESTADO: RESUELTO
---
SOLUCION:
1.  **Limpieza de flask.session**: Eliminadas todas las dependencias de `flask.session` en `pronto-client`. La aplicación ahora es verdaderamente stateless desde la perspectiva del servidor de Flask.
2.  **Centralización de PII**: Migradas las funciones `store_customer_ref`, `get_customer_data` y `clear_customer_ref` de una utilidad local en el cliente a `pronto_shared.services.dining_session_service`.
3.  **Uso de Redis**: Los datos sensibles de clientes se almacenan ahora exclusivamente en Redis con un TTL de 60 minutos, cumpliendo con los estándares de seguridad de `AGENTS.md`.
4.  **Deduplicación**: Eliminado el archivo `pronto-client/src/pronto_clients/utils/customer_session.py` y actualizados los puntos de entrada para usar la librería compartida.
---
