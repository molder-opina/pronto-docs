ID: ERR-20260223-REFRESH-LOOP-SESSION-CLOSED-REDIRECT
FECHA: 2026-02-23
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Loop de refresh por redirección forzada en SESSION_CLOSED
DESCRIPCION: En hard refresh, cuando `/api/sessions/me` devolvía `SESSION_CLOSED`, frontend ejecutaba `resetClientSession()->window.location='/'`, provocando recarga reiterada.
PASOS_REPRODUCIR:
1) Entrar con cookie/token de sesión cerrada.
2) Hard refresh en cliente.
3) Observar recarga continua.
RESULTADO_ACTUAL: Refresh en bucle.
RESULTADO_ESPERADO: Limpiar contexto local y mantener navegación estable sin redirección forzada.
UBICACION: pronto-static/src/vue/clients/modules/client-base.ts
EVIDENCIA: Rama de manejo 410/SESSION_CLOSED ejecutaba redirección diferida en cada carga.
HIPOTESIS_CAUSA: Manejo agresivo de cierre de sesión de mesa con navegación automática en init.
ESTADO: RESUELTO
SOLUCION: Se elimina redirección en `SESSION_CLOSED`; ahora solo limpia `session_id` local, oculta tracker, detiene polling y muestra notificación informativa.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
