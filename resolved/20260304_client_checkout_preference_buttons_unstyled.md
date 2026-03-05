ID: 20260304_client_checkout_preference_buttons_unstyled
FECHA: 2026-03-04
PROYECTO: pronto-client, pronto-static
SEVERIDAD: media
TITULO: Botones de método de pago se renderizan sin estilos en cliente 6080
DESCRIPCION: En la superposición de preferencia de checkout (`checkout-preference`) los botones (`Pago en efectivo`, `Terminal`, `Pago digital`) se muestran como texto plano sin fondo ni padding.
PASOS_REPRODUCIR: 1) Abrir cliente `:6080` 2) Activar overlay de checkout preference 3) Inspeccionar botón XPath `/html/body/main/div[3]/div/div[2]/button[1]`.
RESULTADO_ACTUAL: Botón sin estilos visuales (fondo transparente, padding 0, sin borde).
RESULTADO_ESPERADO: Botones visibles con apariencia de acción, contraste y espaciado correcto.
UBICACION: pronto-static/src/static_content/assets/css/clients/qa-consolidated.css
EVIDENCIA: Captura del usuario + inspección runtime del XPath con estilos calculados sin formato.
HIPOTESIS_CAUSA: Assets estáticos publicados sin regla para `.checkout-preference__btn` y caché de CSS previos.
ESTADO: RESUELTO
SOLUCION: Se añadieron reglas CSS para `.checkout-preference`, `.checkout-preference__card`, `.checkout-preference__buttons` y `.checkout-preference__btn` en `qa-consolidated.css` y se sincronizó el contenido estático al contenedor `pronto-static-1`; la validación runtime del XPath confirmó fondo, borde, padding y peso tipográfico correctos.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-04
