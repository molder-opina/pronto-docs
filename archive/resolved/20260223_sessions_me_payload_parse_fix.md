ID: ERR-20260223-SESSIONS-ME-PAYLOAD-PARSE-FIX
FECHA: 2026-02-23
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Rehidratación de sesión falla por parseo incorrecto de /api/sessions/me
DESCRIPCION: Frontend esperaba `session.id`, pero el endpoint canónico entrega `session_id` plano; en refresh no se restauraba `pronto-session-id` y se perdía vista de órdenes activas.
PASOS_REPRODUCIR:
1) Usuario autenticado con órdenes activas.
2) Hard refresh.
3) Revisar logs de frontend con warning de `Error validating session`.
RESULTADO_ACTUAL: Sin rehidratación de órdenes activas.
RESULTADO_ESPERADO: Recuperación automática de sesión y órdenes activas tras refresh.
UBICACION: pronto-static/src/vue/clients/modules/client-base.ts
EVIDENCIA: XHR `/api/sessions/me` exitoso y warning de validación; parseo anterior solo consideraba `data.session.id`.
HIPOTESIS_CAUSA: Desalineación de contrato de payload entre frontend y endpoint canónico.
ESTADO: RESUELTO
SOLUCION: Parseo compatible (`session_id`, `session.id`, variantes bajo `data`) y preservación de session local en errores transitorios para evitar pérdida de contexto.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
