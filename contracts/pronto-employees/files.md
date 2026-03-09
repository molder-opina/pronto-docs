| Path | Purpose |
|---|---|
| `src/pronto_employees/` | App SSR principal de employees |
| `src/pronto_employees/routes/api/proxy_console_api.py` | Proxy técnico scope-aware `/<scope>/api/*` |
| `src/pronto_employees/routes/` | Rutas web por scope y vistas SSR |
| `src/pronto_employees/templates/` | Templates Jinja por consola/rol |
| `tests/test_proxy_console_scope_mismatch.py` | Seguridad del proxy contra scope mismatch |
| `tests/test_public_endpoint_security_regressions.py` | Reglas de endpoints públicos permitidos |
| `tests/test_sessions_proxy_security_regressions.py` | Seguridad de sesiones/proxy |
| `tests/test_upstream_base_url.py` | Validación de resolución upstream |

### Notas
- `pronto-employees` renderiza UI SSR y transporta requests hacia `pronto-api`; no debe introducir lógica de negocio paralela.
