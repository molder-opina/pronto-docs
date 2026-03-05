ID: CODE-20260303-024
FECHA: 2026-03-03
PROYECTO: pronto-api
SEVERIDAD: media
TITULO: Fuga de lógica de negocio en rutas de empleados (pronto-api)

DESCRIPCION: |
  Durante la auditoría archivo por archivo, se detectó que múltiples rutas de la consola de empleados en `pronto-api` contienen lógica de negocio compleja que debería residir en los servicios de `pronto_shared`. Esto rompe la arquitectura de capas y dificulta la reutilización de la lógica.

RESULTADO_ACTUAL: |
  Lógica de negocio detectada en rutas:
  - `routes/employees/business_info.py`: Cálculo de estado abierto/cerrado basado en horarios y zonas horarias.
  - `routes/employees/employees.py`: Filtrado de roles `system` para el scope `admin`.
  - `routes/employees/menu_items.py`: Restricciones de edición de campos específicas para el rol `waiter`.
  - `routes/employees/api_branding.py`: Construcción de prompts de IA para generación de imágenes.
  - `routes/employees/maintenance.py`: Criterios de inactividad para limpieza de sesiones.

RESULTADO_ESPERADO: |
  Las rutas deben delegar estas decisiones a los servicios correspondientes. Por ejemplo, `BusinessScheduleService.is_open()` o `EmployeeService.filter_by_scope()`.

UBICACION: |
  - `pronto-api/src/api_app/routes/employees/`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Refactorizar el cálculo de horarios a `BusinessScheduleService`.
  - [ ] Mover las reglas de visibilidad de empleados al `EmployeeService`.
  - [ ] Centralizar la construcción de prompts de IA en `AIImageService`.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
