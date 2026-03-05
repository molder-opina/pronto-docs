ID: CODE-20260303-021
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: Lógica de UI legacy (manipulación directa del DOM) en proyecto Vue

DESCRIPCION: |
  Se ha identificado que el archivo `ui-utils.ts` en el módulo de meseros utiliza manipulación directa del DOM (`document.createElement`, `Object.assign(notification.style, ...)`, `document.head.appendChild`) para mostrar notificaciones y modales. 
  
  Esta práctica es contraria a los principios de Vue.js y genera:
  1. Dificultad para mantener la consistencia visual (estilos hardcodeados en JS).
  2. Problemas potenciales de hidratación y reactividad.
  3. Código difícil de testear con herramientas estándar de Vue (Vue Test Utils).

RESULTADO_ACTUAL: |
  Presencia de lógica de UI "imperativa" conviviendo con la arquitectura "declarativa" de Vue 3.

RESULTADO_ESPERADO: |
  Refactorizar `showNewOrderNotification`, `showModal` y `showOrderSelectionModal` para que sean componentes Vue estándar consumidos a través de un store (Pinia) o un sistema de eventos global compatible con Vue.

UBICACION: |
  - `pronto-static/src/vue/employees/waiter/modules/waiter/legacy/ui-utils.ts`

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Migrar la lógica de notificaciones al componente `NotificationToast.vue` compartido.
  - [ ] Convertir los modales de selección de órdenes en componentes Vue.
  - [ ] Eliminar el archivo `ui-utils.ts` una vez completada la migración.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
