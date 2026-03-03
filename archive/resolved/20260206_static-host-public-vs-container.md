ID: 20260206-static-host-fix
FECHA: 2026-02-06
PROYECTO: pronto-client / pronto-employees / pronto-libs
SEVERIDAD: alta
TITULO: Assets estáticos apuntan a host interno (static) y el browser no los resuelve
DESCRIPCION: El HTML/APP_CONFIG está inyectando static_host_url con un host interno (ej. http://static:80 o https://static). En el browser produce net::ERR_NAME_NOT_RESOLVED. Adicionalmente CSP incluye upgrade-insecure-requests, forzando http->https y agravando el problema en local.
PASOS_REPRODUCIR: Abrir página de cliente en local; ver Network/Console; requests a https://static/assets/... fallan.
RESULTADO_ACTUAL: CSS/JS/imagenes no cargan; errores ERR_NAME_NOT_RESOLVED.
RESULTADO_ESPERADO: Browser carga assets desde PRONTO_STATIC_PUBLIC_HOST (ej. http://localhost:9088/assets/... en local).
UBICACION: pronto-client templates/context; pronto-employees api_branding; pronto_shared security_middleware (CSP).
EVIDENCIA: Logs del browser con GET https://static/assets/... net::ERR_NAME_NOT_RESOLVED.
HIPOTESIS_CAUSA: Config env mezclada (PUBLIC host usando valor interno) + CSP upgrade-insecure-requests activo en debug.
ESTADO: RESUELTO
SOLUCION: Se separaron las configuraciones de host estático en `.env` (PUBLIC vs CONTAINER). Se creó `url_helpers.py` para manejo seguro de URLs. Se actualizó `security_middleware.py` para usar host público en CSP y condicional `upgrade-insecure-requests` (solo prod). Se validó con gate script y Playwright.
