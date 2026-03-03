ID: 20260213_employees_waiter_root_empty_reply
FECHA: 2026-02-13
PROYECTO: pronto-employees, pronto-libs
SEVERIDAD: alta
TITULO: /waiter devuelve Empty reply por error handler sin template error.html
DESCRIPCION: La ruta `/waiter` en empleados no está definida y cae en 404. El manejador de errores intenta renderizar `error.html`, pero el template no existe en `pronto-employees`, causando excepción secundaria y respuesta vacía.
PASOS_REPRODUCIR: 1) Abrir `http://localhost:6081/waiter`. 2) Observar `curl: (52) Empty reply from server`. 3) Revisar logs y ver `TemplateNotFound: error.html`.
RESULTADO_ACTUAL: `/waiter` no responde correctamente (socket error / empty reply).
RESULTADO_ESPERADO: `/waiter` debe responder con redirección/HTML válido y los errores deben renderizarse sin romper el request.
UBICACION: pronto-employees/src/pronto_employees/routes/waiter/auth.py, pronto-employees/src/pronto_employees/templates/
EVIDENCIA: logs de `pronto-employees-1`: `jinja2.exceptions.TemplateNotFound: error.html`.
HIPOTESIS_CAUSA: Drift entre error handlers compartidos (que asumen `error.html`) y templates disponibles en `pronto-employees`.
ESTADO: RESUELTO
