ID: ERR-20260213-LOGIN-LAYOUT-VERSION
FECHA: 2026-02-13
PROYECTO: pronto-employees
SEVERIDAD: media
TITULO: Login de empleados desproporcionado y versión fuera de viewport
DESCRIPCION: El layout de login en empleados quedó sobredimensionado y visualmente descuadrado. La versión del sistema aparece al final del documento (abajo a la derecha) obligando a hacer scroll para verla.
PASOS_REPRODUCIR:
1) Abrir cualquier login de empleados (ej. /waiter/login).
2) Verificar proporciones del panel/hero en desktop.
3) Confirmar ubicación de "Versión X.YYYY" al final de la página.
RESULTADO_ACTUAL: El login ocupa una altura mayor a la esperada y la versión queda fuera de vista inicial por estar en flujo normal del documento.
RESULTADO_ESPERADO: Login uniforme entre roles con proporción estable en desktop/mobile y versión visible fija sin necesidad de scroll.
UBICACION: pronto-static/src/vue/employees/components/LoginShell.vue; pronto-static/src/vue/employees/App.vue; pronto-employees/src/pronto_employees/templates/index.html
EVIDENCIA: Reporte visual del usuario con captura mostrando panel sobredimensionado y versión en esquina inferior tras desplazamiento.
HIPOTESIS_CAUSA: La pantalla guest usa min-height de viewport sin restricciones de alto del shell y el footer de versión está renderizado como bloque normal fuera del contenedor principal.
ESTADO: RESUELTO
SOLUCION: Se normalizó el shell de login de empleados con ancho/alto máximos, grilla estable de dos columnas en desktop y una en móvil, además de padding ajustado para evitar desproporción visual. La versión del sistema se movió a un badge fijo en viewport para permanecer visible sin scroll.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-13
