ID: BUG-20260214-004
FECHA: 2026-02-14
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: auth.py usa auth_bp = api_bp (blueprint frágil) + doble import en __init__.py
DESCRIPCION: |
  En auth.py línea 29, `auth_bp = api_bp` registra las rutas de auth directamente
  en el blueprint principal. Esto rompe la estructura modular de sub-blueprints.
  Además, __init__.py importa el módulo auth dos veces:
  - Línea 27: `from pronto_clients.routes.api import auth`
  - Línea 44: `from . import auth  # noqa: F401`
  Funciona por cache de módulos de Python pero es confuso y frágil.
PASOS_REPRODUCIR: |
  1. Revisar pronto-client/src/pronto_clients/routes/api/auth.py línea 29.
  2. Revisar pronto-client/src/pronto_clients/routes/api/__init__.py líneas 27 y 44.
  3. Observar que auth no se registra como sub-blueprint como los demás módulos.
RESULTADO_ACTUAL: |
  auth_bp = api_bp (alias directo). Doble import en __init__.py.
RESULTADO_ESPERADO: |
  auth_bp debe ser un Blueprint propio (`Blueprint("client_auth", __name__)`)
  y registrarse vía `api_bp.register_blueprint(auth_bp)` como los demás módulos.
  Eliminar el import duplicado.
UBICACION: |
  pronto-client/src/pronto_clients/routes/api/auth.py (línea 29)
  pronto-client/src/pronto_clients/routes/api/__init__.py (líneas 27, 44)
EVIDENCIA: Todos los demás módulos (orders, menu, config, etc.) crean su propio Blueprint y se registran como sub-blueprint. auth.py es la excepción.
HIPOTESIS_CAUSA: Se implementó como atajo rápido para evitar crear otro blueprint.
ESTADO: RESUELTO
SOLUCION: auth_bp ahora es `Blueprint("client_auth", __name__)` propio, registrado como sub-blueprint via `api_bp.register_blueprint(auth_bp)`. Eliminado import circular (`from pronto_clients.routes.api import api_bp`) y doble import en `__init__.py`.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-14
