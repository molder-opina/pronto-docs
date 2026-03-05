ID: ERR-CLIENT-DETAILS-CONTRAST-20260305
FECHA: 2026-03-05
PROYECTO: pronto-client
SEVERIDAD: media
TITULO: Tab Detalles en cliente muestra texto con bajo contraste
DESCRIPCION: En `http://localhost:6080/?view=profile&tab=login` al abrir el tab `Detalles`, los textos y controles del checkout heredan color claro sobre fondo blanco, generando baja legibilidad.
PASOS_REPRODUCIR:
1. Abrir `http://localhost:6080/?view=profile&tab=login`
2. Cerrar modal de login
3. Abrir tab `Detalles`
4. Observar títulos, labels, textarea y resumen con color casi blanco
RESULTADO_ACTUAL: Textos principales del bloque de detalles se renderizan con color claro sobre fondo blanco y el botón principal pierde jerarquía visual.
RESULTADO_ESPERADO: Controles y textos del tab `Detalles` deben usar contraste alto (texto oscuro sobre superficies claras y CTA visible).
UBICACION: pronto-client/src/pronto_clients/templates/base.html
EVIDENCIA: Captura compartida por usuario + inspección de estilos computados (`.checkout-shell`, `.checkout-summary__title`, `#notes`) con color `rgb(247, 250, 252)` en fondo `rgb(255, 255, 255)`.
HIPOTESIS_CAUSA: Variables globales de tema oscuro aplicadas al contenedor `checkout-shell` sin override local para la vista `Detalles`.
ESTADO: RESUELTO
SOLUCION: Se aplicó hardening de contraste específico al bloque `#checkout-section` en `base.html` para forzar texto oscuro en contenido claro (títulos, labels, inputs, resumen y CTA) y mantener encabezados del acordeón con texto claro sobre fondo oscuro.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
