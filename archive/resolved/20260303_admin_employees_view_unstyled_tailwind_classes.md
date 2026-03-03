ID: ERR-20260303-ADMIN-EMPLOYEES-VIEW-UNSTYLED-TAILWIND-CLASSES
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin)
SEVERIDAD: media
TITULO: Vista de Empleados en admin renderiza HTML casi crudo por depender de clases utilitarias inexistentes
DESCRIPCION: Al abrir `/admin/dashboard/employees`, la administración de empleados se muestra sin jerarquía visual ni layout consistente con el shell administrativo. El contenido aparece como HTML casi crudo, con botones, tabla y modal sin estilizado efectivo.
PASOS_REPRODUCIR:
1. Iniciar sesión en la consola administrativa.
2. Abrir `http://localhost:6081/admin/dashboard/employees`.
3. Observar la vista principal y abrir el modal de nuevo empleado.
RESULTADO_ACTUAL: La pantalla muestra estructura desalineada y estilos ausentes; el componente usa clases utilitarias tipo Tailwind que no existen en el bundle actual de employees.
RESULTADO_ESPERADO: La gestión de empleados debe verse consistente con `Roles y Permisos` y `Configuración`, usando CSS real del proyecto y un layout administrativo legible.
UBICACION: pronto-static/src/vue/employees/admin/components/EmployeesManager.vue
EVIDENCIA: Captura compartida por el usuario en sesión donde el módulo aparece sin estilos aplicados.
HIPOTESIS_CAUSA: `EmployeesManager.vue` fue conectado a la ruta correcta pero está implementado con clases utilitarias (`p-6`, `bg-white`, `rounded-xl`, etc.) sin una hoja de estilos compatible; por eso el navegador renderiza el contenido sin la presentación esperada.
ESTADO: RESUELTO
SOLUCION: Se reescribió `EmployeesManager.vue` con layout y estilos scoped reales del proyecto, reutilizando componentes compartidos (`Spinner`, `SearchFilter`, `Alert`, `Badge`) y manteniendo el flujo ABC sobre la misma API. La vista ahora incluye encabezado administrativo, métricas, buscador, tabla consistente, estados visuales y modal con formulario estilizado sin depender de utilidades inexistentes.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
