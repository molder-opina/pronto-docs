ID: EMP-20260307-009
FECHA: 2026-03-07
PROYECTO: pronto-employees
SEVERIDAD: bloqueante
TITULO: pronto-employees mantiene logica de negocio y DB en rutas API locales
DESCRIPCION:
  AGENTS define que `pronto-employees` debe actuar como SSR/UI y no como dueño de logica de negocio API.
  Sin embargo, multiples rutas bajo `routes/api` realizan consultas y mutaciones directas via `get_session`,
  servicios de dominio y operaciones de estado dentro del propio servicio.
PASOS_REPRODUCIR:
  1. Buscar `get_session` en `pronto-employees/src/pronto_employees/routes/api`.
  2. Revisar handlers de ordenes, clientes, descuentos, modifiers, maintenance, etc.
RESULTADO_ACTUAL:
  La capa employees conserva ownership de endpoints de negocio y acceso directo a DB.
RESULTADO_ESPERADO:
  La logica de negocio canonica debe vivir en `pronto-api` bajo `/api/*`; employees solo transporte/SSR.
UBICACION:
  - pronto-employees/src/pronto_employees/routes/api/orders.py:52
  - pronto-employees/src/pronto_employees/routes/api/customers.py:34
  - pronto-employees/src/pronto_employees/routes/api/discount_codes.py:21
  - pronto-employees/src/pronto_employees/routes/api/modifiers.py:40
  - pronto-employees/src/pronto_employees/routes/api/maintenance.py:45
  - pronto-employees/src/pronto_employees/routes/api/menu_items.py:101
EVIDENCIA:
  - Presencia extendida de `with get_session()` y commits en modulos API de employees.
HIPOTESIS_CAUSA:
  Migracion a aislamiento de API incompleta; coexisten rutas legacy con capas nuevas de proxy.
ESTADO: RESUELTO
SOLUCION:
  `pronto-employees/src/pronto_employees/routes/api/__init__.py` ahora exporta únicamente
  el proxy scope-aware y se retiraron los módulos locales con acceso DB/lógica de negocio.
  `proxy_console_api.py` resuelve el scope desde el path y mantiene `/{scope}/api/*`
  como superficie de transporte solamente.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07