ID: 20260213_employees_realtime_css_logo_console_errors
FECHA: 2026-02-13
PROYECTO: pronto-static, pronto-employees
SEVERIDAD: media
TITULO: Console errors en employees por polling realtime, selector CSS inválido y logo legacy 404
DESCRIPCION: En la SPA de empleados aparecen errores en consola: `NetworkError` al hacer polling realtime, reglas CSS ignoradas por selector inválido y solicitud 404 de logo en `/static/images/restaurant/branding/logo.jpg`.
PASOS_REPRODUCIR: 1) Abrir `http://localhost:6081`. 2) Iniciar sesión de empleado. 3) Revisar consola del navegador. 4) Observar errores de realtime y CSS, y request 404 del logo.
RESULTADO_ACTUAL: Consola con ruido de errores y warning recurrente; branding de logo intenta ruta legacy inexistente.
RESULTADO_ESPERADO: Polling realtime resiliente sin ruido espurio, CSS sin selectores inválidos y logo cargado desde ruta canónica de assets.
UBICACION: pronto-static/src/vue/employees/core/realtime.ts, pronto-static/src/vue/employees/store/config.ts, pronto-static/src/static_content/assets/css/employees/components/base.css, pronto-static/src/static_content/assets/css/employees/waiter-pos-modern.css
EVIDENCIA: Mensajes reportados por usuario: `Error while fetching events: TypeError: NetworkError...`, `Juego de reglas ignoradas debido a un mal selector`, `GET /static/images/restaurant/branding/logo.jpg 404`.
HIPOTESIS_CAUSA: Polling registra cualquier fallo transitorio como warning; CSS contiene llave huérfana y selectores `::-webkit-scrollbar-thumb:hover` inválidos en Firefox; `restaurant_assets` puede llegar en formato legacy desde API pública.
ESTADO: ABIERTO
