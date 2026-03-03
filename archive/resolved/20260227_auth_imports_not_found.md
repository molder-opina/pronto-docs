# BUG-20260227-AUTH-01: Importación incorrecta en auth routes

## Estado
✅ **RESUELTO** - 2026-02-27

## Severidad
Alta - Impedía login en todas las consolas de empleados

## Síntoma
Error 500 en `/system/login` (y otras consolas) con mensaje:
```
name 'verify_credentials' is not defined
```

## Causa Raíz
En los archivos de autenticación de empleados, las funciones `hash_identifier` y `verify_credentials` estaban siendo importadas dentro del bloque `try` del método `process_login()`:

```python
# INCORRECTO
def process_login():
    try:
        with get_session() as db_session:
            from pronto_shared.security import hash_identifier
            # verify_credentials NO está importado aquí
            ...
            if not verify_credentials(...):  # ERROR: name 'verify_credentials' is not defined
```

El problema era que:
1. `verify_credentials` solo se importaba si se ejecutaba el código dentro del `with`
2. El import estaba dentro de un bloque condicional
3. El scope de Python no propagaba el import al resto de la función

## Solución
Mover los imports al inicio de cada archivo:

```python
# CORRECTO
from pronto_shared.security import hash_identifier, verify_credentials

def process_login():
    try:
        with get_session() as db_session:
            email_hash = hash_identifier(email)
            ...
            if not verify_credentials(email, password, employee.auth_hash or ""):
```

## Archivos Modificados

| Archivo | Línea de Import |
|---------|-----------------|
| `pronto-employees/src/pronto_employees/routes/system/auth.py` | 27 |
| `pronto-employees/src/pronto_employees/routes/admin/auth.py` | 21 |
| `pronto-employees/src/pronto_employees/routes/waiter/auth.py` | 22 |
| `pronto-employees/src/pronto_employees/routes/chef/auth.py` | 22 |
| `pronto-employees/src/pronto_employees/routes/cashier/auth.py` | 22 |

## Verificación

### Test Manual
```bash
curl -X POST http://localhost:6081/system/login \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "Accept: application/json" \
  -H "X-Requested-With: XMLHttpRequest" \
  -d 'email=system@pronto.test&password=ChangeMe!123'
```

Respuesta esperada:
```json
{"status":"success","redirect":"/system/dashboard","data":{...}}
```

### Test Automatizado
```bash
cd pronto-tests
source .venv-test/bin/activate
python -m pytest tests/test_employee_auth.py -v
```

Resultado: 7 passed

## Prevención
1. Los imports siempre deben ir al inicio del archivo (PEP8)
2. Agregar linting con `flake8` o `ruff` para detectar imports dentro de funciones
3. Tests de integración para login en todas las consolas

## Lecciones Aprendidas
- Los imports dentro de funciones son un anti-patrón
- Los tests de integración son críticos para detectar errores de configuración
- El rate limiting puede ocultar errores reales durante testing

---

*Resuelto por: Memo (Pronto Agent)*
*Fecha: 2026-02-27*
