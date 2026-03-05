ID: ERR-CLIENT-LOGIN-CSRF-20260305
FECHA: 2026-03-05
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Login cliente falla con CSRF Error en modal de perfil
DESCRIPCION: El flujo de login del cliente en `:6080` puede responder `CSRF Error` al enviar `POST /api/auth/login` cuando el token en meta está ausente o desfasado.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6080/?view=profile&tab=login`
2. Completar correo y contraseña
3. Presionar `Iniciar Sesión`
RESULTADO_ACTUAL: El formulario muestra `CSRF Error`.
RESULTADO_ESPERADO: El cliente debe refrescar token CSRF y completar login sin error.
UBICACION: pronto-static/src/vue/clients/core/http.ts
EVIDENCIA: Captura de usuario + fallo reportado en login cliente.
HIPOTESIS_CAUSA: Petición mutante usa token CSRF stale/sin renovar y el cliente no reintenta con token nuevo.
ESTADO: RESUELTO
SOLUCION: Se reforzó la renovación de CSRF en `pronto-static/src/vue/clients/core/http.ts`: el cliente intenta `/api/auth/csrf` para sesiones autenticadas y, si falla (401 en pre-login), hace fallback leyendo el token desde el HTML actual (`meta[name=\"csrf-token\"]`) para reintentar automáticamente la mutación.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
