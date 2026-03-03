ID: ERR-20260303-ADMIN-EMPLOYEES-ROLES-RESPONSE-SHAPE-MISMATCH
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin)
SEVERIDAD: media
TITULO: EmployeesManager interpreta mal la respuesta de roles y cae en fallback innecesario
DESCRIPCION: En `/admin/dashboard/employees`, la consola registra `[EmployeesManager] Error loading roles, using fallback: Respuesta de roles sin formato esperado` aunque el endpoint de roles sí responde correctamente para la vista de RBAC.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/employees`.
2. Revisar la consola del navegador.
3. Observar el log de fallback de roles.
RESULTADO_ACTUAL: `EmployeesManager` descarta la respuesta real del endpoint y usa una lista hardcodeada de respaldo.
RESULTADO_ESPERADO: La vista debe consumir el mismo shape real del endpoint `/api/roles/roles` que ya usa `use-rbac`, sin registrar error falso ni depender de fallback local.
UBICACION: pronto-static/src/vue/employees/admin/components/EmployeesManager.vue
EVIDENCIA: Log compartido por el usuario en sesión.
HIPOTESIS_CAUSA: `EmployeesManager.loadRoles()` sigue validando un contrato viejo (`response.data.roles`) y no contempla el envelope actual donde el payload útil puede venir directamente como arreglo o en `data`.
ESTADO: RESUELTO
SOLUCION: Se alineó `EmployeesManager.vue` con los contratos reales de empleados y RBAC. Primero se corrigió la carga de roles usando `unwrapApiResponse()` sobre `/api/roles/roles?include_inactive=true`. Después se ajustó la carga de empleados para soportar el payload paginado real de `/api/employees` (`success -> data -> { data: [...], meta: ... }`), y se añadieron acciones explícitas de `Editar`, `Activar/Desactivar` y `Eliminar` en cada fila. Finalmente se recompiló `employees` y se reinició `pronto-employees-1`, validando en runtime que `/admin/dashboard/employees` muestra 22 empleados reales.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
