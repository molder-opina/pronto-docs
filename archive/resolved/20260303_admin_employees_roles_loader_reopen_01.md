ID: ERR-20260303-ADMIN-EMPLOYEES-ROLES-LOADER-REOPEN-01
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: Reapertura: EmployeesManager sigue siendo frágil ante variaciones del envelope de roles
DESCRIPCION: La consola reporta `Error loading roles, using fallback: Respuesta de roles sin formato esperado` cuando la carga de roles no coincide exactamente con un array puro. Aunque el endpoint actual puede responder `data: []`, la vista sigue siendo frágil ante shapes como `{ roles: [...] }` o envelopes anidados.
PASOS_REPRODUCIR:
1. Abrir `/admin/dashboard/employees`.
2. Observar logs del navegador durante la carga inicial.
3. Verificar que la vista puede caer al fallback aunque el backend entregue un envelope válido distinto a array puro.
RESULTADO_ACTUAL: Se emite error de consola y la vista usa fallback de roles.
RESULTADO_ESPERADO: La vista debe aceptar los envelopes válidos del backend sin registrar error falso.
UBICACION: pronto-static/src/vue/employees/admin/components/EmployeesManager.vue
EVIDENCIA: Log reportado por usuario: `[ERROR] [EmployeesManager] Error loading roles, using fallback: Respuesta de roles sin formato esperado`.
HIPOTESIS_CAUSA: `loadRoles()` solo acepta `Array.isArray(payload)` y no normaliza otras variantes razonables del contrato.
ESTADO: RESUELTO
SOLUCION: `EmployeesManager.vue` ahora normaliza roles desde array directo, `roles[]` o `items[]`, evitando errores falsos de consola y preservando el fallback solo cuando no exista ningún rol utilizable.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
