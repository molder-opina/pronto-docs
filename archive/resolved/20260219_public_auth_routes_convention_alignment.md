ID: ERR-20260219-PUBLIC-AUTH-ROUTE-CONVENTION
FECHA: 2026-02-19
PROYECTO: pronto-api, pronto-employees, pronto-client, pronto-static
SEVERIDAD: media
TITULO: Rutas públicas y de autenticación fuera de la convención `/public` y `/auth`
DESCRIPCION: Existían endpoints y consumidores frontend con patrones mixtos como `/api/config/public`, `/api/stats/public`, `/api/login`, `/api/register`, `/api/logout` y `/api/me`, lo que incumplía la regla operativa de centralizar contexto público bajo `/public/*` y autenticación bajo `/auth/*`.
PASOS_REPRODUCIR:
1. Buscar rutas y llamadas API con segmentos legacy
2. Verificar presencia de `/api/*/public` y `/api/login|register|logout|me`
RESULTADO_ACTUAL: Convenciones inconsistentes entre módulos y pathing no unificado.
RESULTADO_ESPERADO: Contexto público bajo `/api/public/*` y auth bajo `/api/auth/*`, manteniendo compatibilidad temporal donde aplique.
UBICACION:
- pronto-employees/src/pronto_employees/routes/api/stats.py
- pronto-employees/src/pronto_employees/routes/api/config.py
- pronto-employees/src/pronto_employees/routes/api/auth.py
- pronto-client/src/pronto_clients/routes/api/auth.py
- pronto-client/src/pronto_clients/routes/api/config.py
- pronto-api/src/api_app/routes/employees/auth.py
- pronto-api/src/api_app/routes/employees/config.py
- pronto-api/src/api_app/routes/employees/stats.py
- pronto-api/src/api_app/routes/settings.py
- pronto-static/src/vue/employees/**
- pronto-static/src/vue/clients/**
EVIDENCIA:
```bash
rg -n --hidden "(/api/config/public|/api/stats/public|/api/settings/public|/api/login|/api/register|/api/logout|/api/me\b|/api/employees/auth/)" pronto-api/src pronto-client/src pronto-employees/src pronto-static/src
```
HIPOTESIS_CAUSA: Evolución incremental de rutas sin una normalización transversal por convención única.
ESTADO: RESUELTO
SOLUCION: Se implementaron rutas canónicas `/public/*` y `/auth/*` y se migraron consumidores frontend a `/api/public/*` y `/api/auth/*`. Se conservaron aliases legacy críticos para compatibilidad temporal y reducción de regresiones.
COMMIT: N/A
FECHA_RESOLUCION: 2026-02-19
