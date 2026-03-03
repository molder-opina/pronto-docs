ID: ERR-20260303-ADMIN-ROLES-SIDEBAR-REOPEN-01
FECHA: 2026-03-03
PROYECTO: pronto-static (employees/admin)
SEVERIDAD: media
TITULO: Reapertura: Roles y Permisos en admin sigue mostrando módulos operativos en el sidebar lateral
DESCRIPCION: Al entrar a `/admin/dashboard/roles`, el sidebar conserva el bloque `Módulos de operación` con opciones de operación y gestión, cuando esa vista debe permanecer dentro del shell administrativo y mostrar únicamente las opciones administrativas del lateral.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6081/admin/dashboard/roles`.
2. Revisar el sidebar lateral izquierdo.
3. Observar que sigue apareciendo el bloque `Módulos de operación`.
RESULTADO_ACTUAL: La vista `Roles y Permisos` mezcla navegación administrativa con módulos operativos en el sidebar.
RESULTADO_ESPERADO: En `roles`, el sidebar debe mostrar solo las opciones administrativas del shell `/admin`.
UBICACION: pronto-static/src/vue/employees/shared/components/Sidebar.vue
EVIDENCIA: Captura compartida por el usuario en sesión.
HIPOTESIS_CAUSA: La ocultación de módulos depende de un scope o lista de secciones que no siempre queda normalizada al entrar en rutas administrativas, por lo que el componente sigue agrupando secciones operativas cuando recibe props amplias.
ESTADO: RESUELTO
SOLUCION: Se endureció `Sidebar.vue` para detectar el shell administrativo por scope, nombre de ruta y pathname actual, y a partir de ello filtrar internamente las secciones visibles a solo `ADMIN`. Con esto, en `/admin/dashboard/roles` ya no se renderizan módulos operativos aunque el componente reciba un arreglo de secciones más amplio.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-03-03
