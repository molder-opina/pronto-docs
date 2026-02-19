# Frontend Master Audit Report

**Fecha:** 2026-02-17
**Estado:** CRÍTICO 🚨
**Objetivo:** Eliminar 100% de la manipulación manual del DOM y adoptar Vue 3 reactivo.

## Resumen Ejecutivo

- **Total Archivos:** 158
- **Violaciones de Paradigma (DOM Manual):** 34 archivos
- **Riesgo de Seguridad (innerHTML):** 36 archivos
- **Estado de Calidad:** FAILED

## 1. Archivos Críticos (Riesgo de Seguridad: innerHTML)

Estos archivos inyectan HTML crudo, lo que rompe la reactividad de Vue y expone vulnerabilidades XSS. **Prioridad P0**.

| Archivo | Módulo | Estado | Acción Requerida |
|---------|--------|--------|------------------|
| `active-orders.ts` | Clients | **ELIMINADO** ✅ | Reemplazado por `OrdersTab.vue` |
| `menu-flow.ts` | Clients | 🚨 FAIL | Migrar a `Menu.vue` |
| `modal-manager.ts` | Clients | 🚨 FAIL | Usar `ModalDialog.vue` |
| `order-tracker.ts` | Clients | 🚨 FAIL | Migrar a `OrderTracker.vue` |
| `session-timeout.ts` | Clients | 🚨 FAIL | Migrar a `SessionTimer.vue` |
| `thank-you.ts` | Clients | 🚨 FAIL | Migrar a `ThankYouView.vue` |
| `post-payment-feedback.ts` | Clients | 🚨 FAIL | Migrar a `FeedbackForm.vue` |
| `cart-renderer.ts` | Clients | 🚨 FAIL | Migrar a `CartPanel.vue` |
| `tables-manager.ts` | Clients | 🚨 FAIL | Migrar a `TableSelector.vue` |
| `checkout-handler.ts` | Clients | 🚨 FAIL | Migrar a `CheckoutView.vue` |
| `client-base.ts` | Clients | 🚨 FAIL | Limpiar inicializadores |
| `notifications.ts` | Employees | 🚨 FAIL | Usar `NotificationToast.vue` |
| `toast.ts` | Employees | 🚨 FAIL | Usar `NotificationToast.vue` |
| `FeedbackDashboard.vue` | Employees | ⚠️ WARN | Refactorizar lógica interna |
| `modifiers-manager.ts` | Employees | 🚨 FAIL | Migrar a `ModifiersEditor.vue` |
| `orders-board.ts` | Employees | 🚨 FAIL | Migrar a `KDSBoard.vue` |
| `table-assignment.ts` | Employees | 🚨 FAIL | Migrar a `TableAssigner.vue` |
| `role-management.ts` | Employees | **MIGRADO** 🔄 | Reemplazado por `RolesManager.vue` (Refactorizado) |
| `areas-manager.ts` | Employees | 🚨 FAIL | Migrar a `AreasEditor.vue` |
| `prep-times-manager.ts` | Employees | 🚨 FAIL | Migrar a `PrepTimes.vue` |
| `cashier-board.ts` | Employees | 🚨 FAIL | Migrar a `CashierView.vue` |
| `reports-manager.ts` | Employees | 🚨 FAIL | Migrar a `ReportsView.vue` |
| `recommendations-manager.ts` | Employees | 🚨 FAIL | Migrar a `Recommendations.vue` |
| `anonymous-sessions-manager.ts` | Employees | 🚨 FAIL | Migrar a `GuestSessions.vue` |
| `employees-manager.ts` | Employees | 🚨 FAIL | Migrar a `StaffList.vue` |
| `waiter/legacy/ui-utils.ts` | Employees | 🚨 FAIL | Eliminar |
| `promotions-manager.ts` | Employees | 🚨 FAIL | Migrar a `PromotionsEditor.vue` |
| `employee-events.ts` | Employees | 🚨 FAIL | Usar Pinia Actions |
| `customers-manager.ts` | Employees | 🚨 FAIL | Migrar a `CustomerList.vue` |
| `product-schedules-manager.ts` | Employees | 🚨 FAIL | Migrar a `SchedulesEditor.vue` |
| `config-manager.ts` | Employees | 🚨 FAIL | Migrar a `SystemSettings.vue` |
| `menu-manager.ts` | Employees | 🚨 FAIL | Migrar a `MenuEditor.vue` |
| `branding-manager.ts` | Employees | 🚨 FAIL | Migrar a `BrandingSettings.vue` |
| `confirmation-dialog.ts` | Employees | 🚨 FAIL | Usar `ConfirmDialog.vue` |

## 2. Archivos con Manipulación de DOM (getElementById/querySelector)

Estos archivos violan el paradigma declarativo de Vue. **Prioridad P1**.

| Archivo | Módulo | Estado | Acción Requerida |
|---------|--------|--------|------------------|
| `client-profile.ts` | Clients | 🚨 FAIL | Migrar a `UserProfile.vue` |
| `menu-shortcuts.ts` | Clients | 🚨 FAIL | Migrar a `KeyboardListener.vue` |
| `AssetCard.vue` | Employees | ⚠️ WARN | Limpiar script setup |
| `ReportsManager.vue` | Employees | ⚠️ WARN | Limpiar script setup |
| `login-form.ts` | Employees | 🚨 FAIL | Migrar a `StaffLogin.vue` |
| `dashboard-shortcuts.ts` | Employees | 🚨 FAIL | Migrar a `QuickActions.vue` |

## 3. Plan de Acción

1.  **Stop the Bleeding**: Prohibido crear nuevos archivos `.ts` para UI.
2.  **Modularización**: Atacar un archivo a la vez, creando su equivalente `.vue` en `components/`.
3.  **Desvinculación**: Eliminar el `import` del entrypoint (`base.ts` o `main.ts`).
4.  **Eliminación**: Borrar el archivo legacy.

## 4. Métricas de Progreso

- **Archivos Limpios:** 2 / 36 (5.5%)
- **Archivos Pendientes:** 34
- **Meta:** 100% Limpio para v1.1

---
*Generado automáticamente por Pronto Audit Agent*
