ID: 20260213_employees_spa_login_alias_y_assets_404
FECHA: 2026-02-13
PROYECTO: pronto-employees, pronto-static
SEVERIDAD: alta
TITULO: Login SPA de empleados redirige a /employees/* y rompe por 404 de rutas/asset chunks
DESCRIPCION: Al abrir `/cashier|admin|system|chef|waiter/login`, el frontend navega a `/employees/<scope>/login`. Esa ruta devuelve 404 y los chunks CSS/JS se solicitan en `http://localhost:6081/assets/...` (no servidos), por lo que no aparece formulario de autenticacion.
PASOS_REPRODUCIR: 1) Abrir `http://localhost:6081/admin/login`. 2) Observar URL final `/employees/admin/login` y errores de consola de chunks/CSS. 3) Ver que no existen campos `email/password` en pantalla.
RESULTADO_ACTUAL: No se renderiza formulario login en contextos empleados via SPA.
RESULTADO_ESPERADO: `/employees/*` deep links deben resolver al SPA y los assets bajo `/assets/*` deben servirse desde host estatico canonico.
UBICACION: pronto-employees/src/pronto_employees/app.py
EVIDENCIA: Playwright reporta URL final `/employees/<scope>/login`, `hasEmail=0`, `hasPassword=0`, 404 en `/login` y errores `Failed to load ... /assets/js/employees/chunks/*`.
HIPOTESIS_CAUSA: Falta de aliases para rutas SPA `/employees/*` y ausencia de passthrough/redirect de `/assets/*` en host employees.
ESTADO: RESUELTO
SOLUCION: Se agregó protección de sesión en modo login para evitar bucle de redirect por 401 (`checkAuthAndRedirect` no redirige cuando la ruta actual ya es un login), se recompilaron assets de employees y se añadió prueba E2E de regresión para validar que `/employees/login` renderiza formulario sin sidebar autenticado.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-13
