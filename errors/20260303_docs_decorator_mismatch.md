ID: DOCS-20260303-001
FECHA: 2026-03-03
PROYECTO: pronto-docs, pronto-employees
SEVERIDAD: baja
TITULO: Discrepancia en documentación para decorador de autenticación web

DESCRIPCION: |
  La documentación principal del proyecto (`GEMINI.md`) especifica el uso del decorador `@web_login_required` para proteger las rutas web (que renderizan HTML) en la aplicación de empleados. Sin embargo, una revisión del código fuente revela que este decorador no se utiliza.

RESULTADO_ACTUAL: |
  - `GEMINI.md` instruye el uso de `@web_login_required`.
  - El archivo `pronto-employees/src/pronto_employees/decorators.py` no define ni exporta este decorador.
  - Las rutas web, como las definidas en `pronto-employees/src/pronto_employees/routes/admin/auth.py`, están protegidas mediante un manejador `@blueprint.before_request` que utiliza una clase `ScopeGuard`.
  - La implementación actual es segura y robusta, pero no coincide con la documentación.

RESULTADO_ESPERADO: |
  La documentación debe reflejar con precisión la implementación real para evitar confusiones a los desarrolladores. O el código debe ser refactorizado para usar el decorador documentado si ese es el patrón deseado.

UBICACION: |
  - `GEMINI.md`
  - `pronto-employees/src/pronto_employees/decorators.py`
  - `pronto-employees/src/pronto_employees/routes/admin/auth.py` (y otros blueprints de rutas web)

HIPOTESIS_CAUSA: |
  Es probable que `@web_login_required` fuera un patrón de diseño inicial que luego fue reemplazado por el enfoque más centralizado de `ScopeGuard` en `before_request`. La documentación no se actualizó para reflejar este cambio.

ESTADO: ABIERTO

ACCIONES_PENDIENTES:
  - [ ] Validar con el equipo de arquitectura si el patrón `ScopeGuard` es el definitivo.
  - [ ] Si `ScopeGuard` es el patrón correcto, actualizar la sección "Available Decorators" en `GEMINI.md` para eliminar la mención a `@web_login_required` y describir el uso de `before_request` con `ScopeGuard` para la protección de rutas web.
  - [ ] Si se prefiere el uso de `@web_login_required`, refactorizar las rutas web para utilizar dicho decorador.
