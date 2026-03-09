| Path | Purpose |
|---|---|
| `src/pronto_shared/constants.py` | Constantes canónicas y estados del dominio |
| `src/pronto_shared/services/` | Servicios reutilizables del dominio |
| `src/pronto_shared/models/` | Modelos SQLAlchemy compartidos |
| `src/pronto_shared/jwt_service.py` | Generación/validación JWT |
| `src/pronto_shared/jwt_middleware.py` | Decorators y helpers auth |
| `src/pronto_shared/permissions.py` | Permisos y RBAC compartido |
| `src/pronto_shared/logging_config.py` | Configuración de logging estructurado |
| `src/pronto_shared/trazabilidad.py` | Correlation ID, audit y mensajes amigables |
| `tests/unit/` | Unit tests de la librería |
| `tests/integration/` | Integración de componentes shared |
