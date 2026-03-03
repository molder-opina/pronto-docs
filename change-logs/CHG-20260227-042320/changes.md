# Change Log - 2026-02-27

## Bug Fixes

### BUG-20260227-AUTH-01: Importación incorrecta en auth routes

**Síntoma**: Error 500 en `/system/login` con mensaje `name 'verify_credentials' is not defined`

**Causa Raíz**: En los archivos de autenticación de empleados, las funciones `hash_identifier` y `verify_credentials` estaban siendo importadas dentro del bloque `try` en lugar de al inicio del archivo. Esto causaba que `verify_credentials` no estuviera disponible en el scope global.

**Archivos Afectados**:
- `pronto-employees/src/pronto_employees/routes/system/auth.py`
- `pronto-employees/src/pronto_employees/routes/admin/auth.py`
- `pronto-employees/src/pronto_employees/routes/waiter/auth.py`
- `pronto-employees/src/pronto_employees/routes/chef/auth.py`
- `pronto-employees/src/pronto_employees/routes/cashier/auth.py`

**Corrección**: Mover imports al inicio de cada archivo:
```python
from pronto_shared.security import hash_identifier, verify_credentials
```

**Estado**: ✅ RESUELTO

---

## Verificación

```bash
# Test system login
curl -X POST http://localhost:6081/system/login \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "Accept: application/json" \
  -H "X-Requested-With: XMLHttpRequest" \
  -d 'email=system@pronto.test&password=ChangeMe!123'

# Response: {"status":"success","redirect":"/system/dashboard",...}
```

---

## Archivos Modificados

| Archivo | Cambio |
|---------|--------|
| `pronto-employees/src/pronto_employees/routes/system/auth.py` | Import movido a nivel de módulo |
| `pronto-employees/src/pronto_employees/routes/admin/auth.py` | Import movido a nivel de módulo |
| `pronto-employees/src/pronto_employees/routes/waiter/auth.py` | Import movido a nivel de módulo |
| `pronto-employees/src/pronto_employees/routes/chef/auth.py` | Import movido a nivel de módulo |
| `pronto-employees/src/pronto_employees/routes/cashier/auth.py` | Import movido a nivel de módulo |

---

*Documento generado: 2026-02-27 04:23:20 UTC*
