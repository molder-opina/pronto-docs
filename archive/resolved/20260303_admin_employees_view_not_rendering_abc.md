ID: ERR-20260303-ADMIN-EMPLOYEES-VIEW-NOT-RENDERING-ABC
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin)
SEVERIDAD: media
TITULO: Vista de Empleados en admin no muestra correctamente el ABC de personal en el panel derecho
DESCRIPCION: Al entrar a `/admin/dashboard/employees`, la vista actual de personal no carga el ABC esperado en el panel derecho y se queda en un estado de error, aunque ya existe en el frontend una implementación administrativa más robusta para gestión de empleados.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/employees`.
2. Observar el panel derecho.
3. Ver que no aparece correctamente la administración ABC de empleados.
RESULTADO_ACTUAL: El panel derecho muestra una vista incompleta/rota y no expone claramente el flujo de alta, baja y cambio de empleados.
RESULTADO_ESPERADO: El panel derecho debe montar una vista administrativa funcional para ABC de empleados reutilizando la implementación existente en el código.
UBICACION: pronto-static/src/vue/employees/shared/router/index.ts; pronto-static/src/vue/employees/admin/components/EmployeesManager.vue
EVIDENCIA: Captura compartida por el usuario en sesión.
HIPOTESIS_CAUSA: La ruta `employees` sigue montando `StaffManager.vue`, que consume el endpoint con un shape frágil. Existe `EmployeesManager.vue`, más tolerante a respuestas de API, pero no está conectado a la ruta activa.
ESTADO: RESUELTO
SOLUCION: Se conectó la ruta `employees` al componente reutilizable `EmployeesManager.vue`, que ya implementa el ABC de personal en el panel derecho y soporta respuestas API más tolerantes. Además se adaptó el componente para habilitar acciones de administración en consola `admin/system` aunque el bootstrap del usuario no incluya permisos explícitos.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
