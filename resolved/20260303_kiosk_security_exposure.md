ID: SEC-20260303-001
FECHA: 2026-03-03
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Exposición de auto-login de kioscos sin secreto obligatorio

DESCRIPCION: |
  El endpoint de inicio de sesión para kioscos (`/kiosk/<location>/start`) permite omitir la validación de seguridad si la variable de entorno `PRONTO_KIOSK_SECRET` no está definida o si la aplicación se ejecuta con `DEBUG_MODE=True`. Esto permite la creación indiscriminada de cuentas de tipo 'kiosk' en el sistema.

RESULTADO_ACTUAL: |
  En el archivo `routes/web.py`, la validación `if _KIOSK_SECRET and not debug_mode:` permite que cualquier cliente cree una sesión de kiosco si falta la configuración o se está en modo desarrollo. Esto otorga una referencia de cliente (`customer_ref`) válida para operar en la API.

RESULTADO_ESPERADO: |
  El inicio de sesión de kioscos debe ser estrictamente controlado. El secreto debería ser obligatorio en producción y, en desarrollo, debería haber una advertencia clara o una restricción por IP/User-Agent para evitar abusos durante las pruebas.

UBICACION: |
  - `pronto-client/src/pronto_clients/routes/web.py` (función `kiosk_start`)

ESTADO: RESUELTO

SOLUCION:
- Se reforzó `kiosk_start` en `pronto-client/src/pronto_clients/routes/web.py`.
- Si `PRONTO_KIOSK_SECRET` está configurado, ahora se valida siempre (incluyendo debug), y secret inválido devuelve `401`.
- Si no hay secret y no es debug, el endpoint falla con `503` por mala configuración.
- En debug sin secret se restringe a origen local (`127.0.0.1`, `::1`, `localhost`) y se registran advertencias de seguridad para trazabilidad.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-04

ACCIONES_PENDIENTES:
  - [x] Hacer que la validación del secreto sea obligatoria independientemente del modo debug si la variable está presente.
  - [x] Implementar un mecanismo de bloqueo o registro para intentos de inicio de kiosco sin secreto válido.
  - [ ] Documentar la necesidad de rotación de `PRONTO_KIOSK_SECRET`.
