# Auditoria Cross-Module & UX - 2026-02-19

## Resumen Ejecutivo

| Severidad | Cantidad |
|-----------|----------|
| BLOQUEANTE | 1 |
| ALTA | 1 |
| MEDIA | 1 |
| BAJA | 0 |

---

## BLOQUEANTE

### ERR-20260219-MISSING-BACKEND-ENDPOINTS

- **Severidad:** BLOQUEANTE
- **Archivo:** 
  - pronto-static/src/vue/employees/components/SessionsManager.vue:308
  - pronto-static/src/vue/employees/modules/anonymous-sessions-manager.ts:86
- **Evidencia:**
```bash
curl -s http://localhost:6081/api/sessions/merge -X POST
{"data":null,"error":"Recurso no encontrado","status":"error"}

curl -s http://localhost:6081/api/sessions/anonymous
{"data":null,"error":"Recurso no encontrado","status":"error"}

curl -s http://localhost:6081/api/branding/config
{"data":null,"error":"Recurso no encontrado","status":"error"}
```
- **Impacto:** Funcionalidad de sesiones en employees panel falla silenciosamente. UX degradado.
- **Fix minimo:**
  - Opcion A: Implementar endpoints faltantes en pronto-employees/src/pronto_employees/routes/api/
  - Opcion B: Remover llamadas del frontend si la funcionalidad no es necesaria

---

## ALTA

### ERR-20260219-HARDCODED-HOSTS

- **Severidad:** ALTA
- **Archivo:** Multiples (ver listado en expediente)
- **Evidencia:**
```bash
rg -n "localhost|:6080|:6081|:6082|:9088" pronto-static/src pronto-client/src pronto-employees/src
```
- **Impacto:** Imposible desplegar en produccion sin modificar codigo. Valores hardcodeados rompen conectividad en entornos no-localhost.
- **Fix minimo:**
  - Usar variables de entorno para todos los hosts/puertos
  - Defaults solo para desarrollo local (detectado por ENV=dev o similar)

---

## MEDIA

### ERR-20260219-MISSING-PLACEHOLDER-ASSET

- **Severidad:** MEDIA
- **Archivo:** pronto-static/src/vue/clients/components/menu/ProductDetailModal.vue:127
- **Evidencia:**
```vue
<img :src="product.image_path || '/assets/images/placeholder-food.png'" :alt="product.name" />
```
```bash
ls pronto-static/src/static_content/assets/images/ | grep placeholder
# default-avatar.png (existe)
# placeholder-food.png (NO existe)
```
- **Impacto:** 404 en consola al cargar productos sin imagen. UX degradado.
- **Fix minimo:**
  - Crear asset placeholder-food.png en pronto-static/src/static_content/assets/images/
  - O usar default-avatar.png como fallback temporal

---

## Verificaciones OK

### A1) Roles (canonicos estrictos)
- **Estado:** OK
- **Verificacion:** Todos los roles usados en backend y frontend pertenecen al catalogo canonico: waiter, chef, cashier, admin, system
- **Evidencia:**
```bash
rg -n "role|user_role|employee_role" pronto-libs/src pronto-employees/src pronto-client/src --type py
# Todos los roles encontrados son canonicos
```

### A2) Estados / Flows
- **Estado:** OK
- **Verificacion:** Estados en frontend coinciden con enums en constants.py
- **Estados canonicos:** new, queued, preparing, ready, delivered, awaiting_payment, paid, cancelled

### A4) Imports / Legacy
- **Estado:** OK
- **Verificacion:** No se encontraron imports legacy rotos
```bash
rg -n "import .*legacy|from .*legacy" pronto-libs/src pronto-employees/src pronto-client/src pronto-api/src --type py
# Sin resultados
```

### B1) Static local en employees
- **Estado:** OK
- **Verificacion:** employees usa static_folder=None correctamente
```python
# pronto-employees/src/pronto_employees/app.py:229
static_folder=None,
```

---

## Expedientes Creados

1. `pronto-docs/errors/20260219_missing_backend_endpoints.md`
2. `pronto-docs/errors/20260219_hardcoded_hosts.md`
3. `pronto-docs/errors/20260219_missing_placeholder_asset.md`

---

## Proximos Pasos Recomendados

1. **Prioridad BLOQUEANTE:** Implementar o remover endpoints faltantes
2. **Prioridad ALTA:** Parametrizar hosts/puertos via variables de entorno
3. **Prioridad MEDIA:** Crear asset placeholder faltante
