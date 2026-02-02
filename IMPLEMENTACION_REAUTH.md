# Implementación de Reautenticación Super Admin

## Resumen

Se ha implementado un sistema de reautenticación rápida para super_admin que permite acceder a múltiples consolas (waiter, chef, cashier, admin) sin re-escribir credenciales, manteniendo aislamiento estricto por cookies.

## Archivos Creados

### 1. Extensiones Flask

- `build/pronto_employees/extensions.py` - CSRF protection sin side effects

### 2. Utilidades

- `build/shared/datetime_utils.py` - Helper UTC compatible Python 3.10+

### 3. Modelos

- Agregados a `build/shared/models.py`:
  - `SuperAdminHandoffToken` - Tokens one-time con TTL
  - `AuditLog` - Logs de auditoría de seguridad

### 4. Documentación

- `.env.example` - Template de configuración
- `docs/PROXY_CONFIGURATION.md` - Guía de configuración de proxies
- Este archivo

## Archivos Modificados

### 1. Configuración

- `build/pronto_employees/requirements.txt` - Agregado Flask-WTF>=1.2.0
- `.env` - Agregadas configuraciones:
  - `HANDOFF_PEPPER` - Generado automáticamente
  - `NUM_PROXIES=0`
  - `ALLOWED_HOSTS=localhost:6081,127.0.0.1:6081`
  - `CORS_ALLOWED_ORIGINS=`

### 2. Modelos

- `build/shared/models.py`:
  - Import de `timezone` para compatibilidad Python 3.10+
  - Modelos `SuperAdminHandoffToken` y `AuditLog` agregados al final

## Próximos Pasos (PENDIENTES)

Los siguientes archivos necesitan ser creados/actualizados manualmente o mediante scripts:

### 1. CRÍTICO - Actualizar app.py

`build/pronto_employees/app.py` necesita:

- Import de `csrf` desde `extensions`
- Inicialización con `csrf.init_app(app)`
- CORS con orígenes explícitos (no wildcards)
- ProxyFix para manejo de proxies
- Headers de seguridad (Referrer-Policy, Cache-Control, Vary)
- HANDOFF_PEPPER con fail-hard en producción

### 2. CRÍTICO - Crear /system console

`build/pronto_employees/routes/system/auth.py` - Nuevo archivo:

- Login exclusivo super_admin
- Dashboard system
- Endpoints `/system/reauth` (GET y POST)
- Validación Origin/Referer con ALLOWED_HOSTS
- Generación de tokens one-time

### 3. CRÍTICO - Actualizar scopes existentes

Cada archivo `build/pronto_employees/routes/{scope}/auth.py` necesita:

- Import de `csrf` desde `extensions`
- Import de `utcnow` desde `shared.datetime_utils`
- Reemplazar `datetime.now(UTC)` por `utcnow()`
- Endpoint `@csrf.exempt /super_admin_login` con:
  - UPDATE atómico de token (no SELECT FOR UPDATE)
  - Validación one-time + TTL
  - Transacción única
  - Audit con token_id

Scopes a actualizar:

- `waiter/auth.py`
- `chef/auth.py`
- `cashier/auth.py`
- `admin/auth.py`

### 4. IMPORTANTE - Templates

Crear/actualizar:

- `build/pronto_employees/templates/login_system.html`
- `build/pronto_employees/templates/system_reauth_confirm.html`
- `build/pronto_employees/templates/system_reauth_redirect.html`
- Actualizar templates de login de cada scope con botón "Entrar como super_admin"

### 5. Base de datos

```bash
cd build/shared
alembic revision --autogenerate -m "Add super_admin_handoff_tokens and audit_logs"
alembic upgrade head
```

## Verificación

### Checklist Pre-Deploy

- [ ] Flask-WTF instalado: `pip install -r build/pronto_employees/requirements.txt`
- [ ] HANDOFF_PEPPER configurado en `.env`
- [ ] Migración de DB aplicada
- [ ] ProxyFix configurado correctamente (NUM_PROXIES)
- [ ] ALLOWED_HOSTS configurado para el entorno
- [ ] Templates creados
- [ ] Endpoints `/system/*` creados
- [ ] Endpoints `*/super_admin_login` creados en todos los scopes

### Checklist Post-Deploy

- [ ] Login en /system funciona solo con super_admin
- [ ] Reauth flow completo: /system → /waiter sin re-login
- [ ] Cookies separadas por Path en DevTools
- [ ] Token one-time: segundo uso falla
- [ ] Token TTL: expira después de 60s
- [ ] Origin/Referer validation funciona
- [ ] Auditoría en DB: `SELECT * FROM audit_logs`
- [ ] No hay errores CSRF en logs

## Seguridad

### Características Implementadas

✅ Cookies aisladas por Path (/waiter, /chef, /cashier, /admin, /system)
✅ Tokens one-time con TTL de 60 segundos
✅ Token hashing con pepper
✅ UPDATE atómico para prevenir race conditions
✅ Validación Origin/Referer con allowlist
✅ CSRF protection con Flask-WTF
✅ Anti-cache headers en rutas sensibles
✅ Referrer-Policy: no-referrer en auth
✅ Auditoría completa de accesos
✅ ProxyFix para headers confiables
✅ Python 3.10+ compatible (timezone.utc)

### Notas Importantes

1. **HANDOFF_PEPPER**: Nunca commitear el valor real. Usar secrets manager en producción.
2. **NUM_PROXIES**: Solo activar si proxy está correctamente configurado.
3. **ALLOWED_HOSTS**: Debe incluir host:puerto exacto.
4. **CORS**: Nunca usar `origins="*"` con `supports_credentials=True`.

## Troubleshooting

Ver `docs/PROXY_CONFIGURATION.md` para problemas comunes de configuración.

Para reportar bugs o solicitar mejoras:
https://github.com/anthropics/claude-code/issues
