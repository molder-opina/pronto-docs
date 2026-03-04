ID: 20260304_profile_modal_missing_assigned_email
FECHA: 2026-03-04
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: El modal Editar perfil no muestra el correo asignado por administrador
DESCRIPCION: En las consolas de empleados, el modal "Editar perfil" abre correctamente pero el campo "Correo asignado por administrador" aparece vacío aunque la cuenta sí tiene email asignado en administración.
PASOS_REPRODUCIR:
1. Iniciar sesión en una consola de empleado.
2. Abrir el modal "Editar perfil".
3. Revisar el campo "Correo asignado por administrador".
RESULTADO_ACTUAL: El campo aparece vacío.
RESULTADO_ESPERADO: El modal debe mostrar el email asignado por administración en modo solo lectura.
UBICACION: /waiter/dashboard/waiter y modal compartido de perfil en pronto-static/pronto-employees
EVIDENCIA: Captura provista por el usuario mostrando el campo vacío en el modal.
HIPOTESIS_CAUSA: El bootstrap SSR de current_user no hidrata employee_email cuando el JWT ya trae employee_name, por lo que el fallback de UI queda vacío si la respuesta de preferencias no rellena el valor a tiempo.
ESTADO: RESUELTO
SOLUCION:
- `pronto-employees/app.py` ahora hidrata desde DB cualquier identidad faltante (`name`, `email` o `role`) en el `current_user` SSR, no solo el nombre.
- `GET/PUT /employees/me/preferences` en `pronto-employees` volvió a usar el servicio compartido `employee_service`, que sí devuelve el shape canónico con `assigned_email` y mantiene la actualización de perfil alineada.
- Validado con `GET /waiter/api/employees/me/preferences` retornando `assigned_email=juan@pronto.com` y con el modal `Editar perfil` mostrando el correo asignado en runtime.
COMMIT: b9025e6
FECHA_RESOLUCION: 2026-03-04
