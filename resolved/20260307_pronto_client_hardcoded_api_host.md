ID: CLIENT-20260307-008
FECHA: 2026-03-07
PROYECTO: pronto-client
SEVERIDAD: alta
TITULO: proxy API usa host hardcodeado http://api:5000 en multiples modulos
DESCRIPCION:
  Los módulos proxy de `routes/api/*.py` construían la URL destino con `api_base_url = "http://api:5000"`, ignorando
  configuración centralizada y rompiendo portabilidad entre Docker y host local.
PASOS_REPRODUCIR:
  1. Buscar `http://api:5000` en `pronto-client/src/pronto_clients/routes/api/*.py`.
  2. Comparar con `.env.example` y `docker-compose.yml`, que definen `PRONTO_API_INTERNAL_BASE_URL` / `PRONTO_API_BASE_URL`.
RESULTADO_ACTUAL:
  Los proxies usan resolución canónica a través de un helper compartido.
RESULTADO_ESPERADO:
  Los proxies deben resolver base URL desde configuración canónica.
UBICACION:
  - `pronto-client/src/pronto_clients/routes/api/_upstream.py`
  - `pronto-client/src/pronto_clients/routes/api/*.py`
ESTADO: RESUELTO
SOLUCION:
  Se añadió el helper `routes/api/_upstream.py` con precedencia `PRONTO_API_INTERNAL_BASE_URL` → `PRONTO_API_BASE_URL` → `http://localhost:6082`,
  y se migraron todos los proxies afectados para usarlo. Validación: `rg -n 'http://api:5000' pronto-client/src/pronto_clients/routes/api -g '*.py'`
  => sin resultados; `python3 -m py_compile` sobre todos los módulos proxy tocados => OK.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
