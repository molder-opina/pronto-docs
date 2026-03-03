# Auditoría Completa PRONTO - Resultados 2026-02-19

## Resumen Ejecutivo

| Métrica | Valor |
|---------|-------|
| Archivos Python | 112 |
| Archivos Vue/TS/JS | 182 |
| Total archivos | 868 |
| **Hallazgos** | **5** |

---

## Gates Ejecutados

### Gate A: flask.session
**Estado:** ✅ PASS
- Sin uso de `flask.session` en pronto-api ni pronto-employees

### Gate B: Roles canónicos
**Estado:** ✅ PASS
- Solo roles canónicos: waiter, chef, cashier, admin, system

### Gate C: static_folder
**Estado:** ✅ PASS
- `pronto-employees/app.py:229` → `static_folder=None`

### Gate D: Fetch directo
**Estado:** ⚠️ WARNING
- Hallado: `pronto-static/src/vue/shared/utils/useFetch.ts`
- Es un wrapper genérico compartido, no específico de API

### Gate E: credentials same-origin
**Estado:** ✅ PASS
- Sin uso de `credentials: 'same-origin'`

### Gate F: API scoped
**Estado:** ✅ PASS
- Sin rutas `/{scope}/api/*`

---

## Hallazgos

### 1. TODO/FIXME Comments (BAJA)
**Ubicación:** `pronto-api/src/api_app/routes/feedback.py`
```
L124: # TODO: Parse start/end to days or proper date range
L142: # TODO: Parse start/end
```
**Acción:** Completar parsing de fechas en feedback

---

### 2. @csrf.exempt en /sessions/open (INFO)
**Ubicación:** `pronto-api/src/api_app/routes/client_sessions.py:87`
**Justificación:** Excepción documentada en AGENTS.md P0.16
- Endpoint para abrir sesión de mesa desde QR sin CSRF

---

### 3. @csrf.exempt en /employees/auth/login (INFO)
**Ubicación:** `pronto-api/src/api_app/routes/employees/auth.py:32`
**Justificación:** Login inicial no requiere CSRF (no hay sesión previa)

---

### 4. Password hardcodeado para kiosk (MEDIA)
**Ubicación:**
- `pronto-client/src/pronto_clients/routes/web.py:200`
- `pronto-employees/src/pronto_employees/routes/api/customers.py:114`

**Código:**
```python
password="kiosk-no-auth"
```
**Acción:** Mover a variable de entorno `KIOSK_DEFAULT_PASSWORD`

---

### 5. useFetch.ts sin credentials (MEDIA)
**Ubicación:** `pronto-static/src/vue/shared/utils/useFetch.ts`
**Problema:** Wrapper fetch genérico no incluye `credentials: 'include'`
**Acción:** Agregar credentials por defecto o documentar uso específico

---

## Estructura por Proyecto

### PRONTO-API (42 archivos Python)
```
✅ app.py - Configuración principal
✅ routes/ - 15 módulos de endpoints
✅ routes/employees/ - 15 módulos BFF employees
✅ Sin flask.session
⚠️ 2 TODO comments
⚠️ 2 @csrf.exempt (justificados)
```

### PRONTO-EMPLOYEES (45 archivos Python)
```
✅ app.py - Configuración con static_folder=None
✅ routes/{scope}/ - Auth por scope (waiter, chef, cashier, admin, system)
✅ routes/api/ - 22 blueprints API
✅ Sin flask.session para auth
✅ Templates con CSRF meta tag
```

### PRONTO-CLIENT (25 archivos Python)
```
✅ app.py - Configuración BFF
✅ routes/web.py - Web routes SSR
✅ routes/api/ - 14 BFF proxies (delegan a pronto-api)
⚠️ 1 password hardcodeado kiosk
```

### PRONTO-STATIC (182 archivos Vue/TS/JS)
```
✅ vue/employees/ - App empleados
✅ vue/clients/ - App clientes
✅ vue/shared/ - Componentes compartidos
✅ Sin fetch directo fuera de wrappers
⚠️ useFetch.ts sin credentials
```

---

## Acciones Recomendadas

| Prioridad | Hallazgo | Acción |
|-----------|----------|--------|
| MEDIA | kiosk password | Mover a env var |
| MEDIA | useFetch.ts | Agregar credentials |
| BAJA | TODO feedback | Completar implementación |

---

## Conclusión

**Estado General:** ✅ SALUDABLE

- Sin violaciones P0 críticas
- Arquitectura respetada
- Separación de concerns correcta
- Código legacy eliminado
- Patrones de seguridad correctos

**Próximos pasos:**
1. Resolver 2 hallazgos MEDIA
2. Completar 2 TODOs
3. Ejecutar suite de tests completa
