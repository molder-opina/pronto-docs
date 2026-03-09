ID: EMP-20260307-005
FECHA: 2026-03-07
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: proxies usan hosts de upstream hardcodeados en vez de configuracion canonica
DESCRIPCION:
  Múltiples módulos proxy de `pronto-employees` apuntaban a `http://api:5000`, `http://pronto-api:5000`
  o `http://localhost:5000` en lugar de resolver el upstream desde configuración canónica del servicio.
PASOS_REPRODUCIR:
  1. Buscar literales de host upstream en `pronto-employees/src/pronto_employees/routes/**`.
  2. Confirmar duplicación fuera de la configuración central del app.
RESULTADO_ACTUAL:
  Los proxies y BFFs de `pronto-employees` ya leen la base URL de upstream desde una única resolución canónica.
RESULTADO_ESPERADO:
  Todo proxy/BFF de employees debe resolver upstream desde configuración central, sin literales repartidos por módulo.
UBICACION:
  - `pronto-employees/src/pronto_employees/routes/_upstream.py`
  - `pronto-employees/src/pronto_employees/routes/api/config.py`
  - `pronto-employees/src/pronto_employees/routes/api/sessions.py`
  - `pronto-employees/src/pronto_employees/routes/api/promotions.py`
  - `pronto-employees/src/pronto_employees/routes/api/proxy_console_api.py`
  - `pronto-employees/src/pronto_employees/routes/{waiter,chef,cashier,admin,system}/auth.py`
  - `pronto-employees/tests/test_upstream_base_url.py`
ESTADO: RESUELTO
SOLUCION:
  Se añadió `pronto_employees.routes._upstream.get_api_base_url()` como resolución canónica del upstream usando `current_app.config['PRONTO_API_URL']` y fallback único controlado.
  Luego se migraron a ese helper los proxies de `auth`, `promotions`, `config`, `sessions` y `proxy_console_api`, eliminando literales duplicados en módulos operativos.
  Validación: `python3 -m py_compile pronto-employees/src/pronto_employees/routes/_upstream.py pronto-employees/src/pronto_employees/routes/waiter/auth.py pronto-employees/src/pronto_employees/routes/chef/auth.py pronto-employees/src/pronto_employees/routes/cashier/auth.py pronto-employees/src/pronto_employees/routes/admin/auth.py pronto-employees/src/pronto_employees/routes/system/auth.py pronto-employees/src/pronto_employees/routes/api/promotions.py pronto-employees/src/pronto_employees/routes/api/proxy_console_api.py pronto-employees/src/pronto_employees/routes/api/config.py pronto-employees/src/pronto_employees/routes/api/sessions.py pronto-employees/tests/test_upstream_base_url.py` => OK;
  `PYTHONPATH=pronto-employees/src pronto-api/.venv/bin/python -m pytest pronto-employees/tests/test_upstream_base_url.py -q` => `1 passed`;
  `rg -n 'http://api:5000|http://pronto-api:5000|http://localhost:5000' pronto-employees/src/pronto_employees -g '*.py'` deja únicamente la configuración central (`app.py`) y el helper canónico `_upstream.py`.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
