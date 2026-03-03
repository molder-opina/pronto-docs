ID: ERR-20260223-HARD-REFRESH-LOSES-ORDERS-SESSION-UUID
FECHA: 2026-02-23
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Hard refresh pierde órdenes activas por invalidación de session_id UUID
DESCRIPCION: Al recargar fuerte el navegador, usuario autenticado perdía visualización de órdenes activas por pérdida del `pronto-session-id` válido en frontend.
PASOS_REPRODUCIR:
1) Tener órdenes activas con usuario autenticado.
2) Ejecutar hard refresh.
3) Observar que el tracker/tab órdenes no muestra órdenes y redirige a estado de login/perfil.
RESULTADO_ACTUAL: Órdenes no rehidratadas tras refresh.
RESULTADO_ESPERADO: Rehidratación automática de sesión/órdenes activas desde API con sesión autenticada.
UBICACION: pronto-static/src/vue/clients/modules/client-base.ts, pronto-static/src/vue/clients/modules/session-manager.ts
EVIDENCIA: Código convertía `data.session.id` a `Number`, provocando `NaN` para UUID y posterior limpieza de sesión local; además no se llamaba rehidratación cuando localStorage venía vacío.
HIPOTESIS_CAUSA: Suposición legacy de IDs numéricos en session_id y flujo de init condicionado a session local previa.
ESTADO: RESUELTO
SOLUCION: 1) `setSessionId(String(data.session.id))` en validación de sesión. 2) `initClientBase` ahora siempre ejecuta `validateAndCleanSession()` para rehidratar desde `/api/sessions/me` aunque no exista session local. 3) `session-manager` actualizado a tipos `string | number` y retorno `string` para compatibilidad UUID.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
