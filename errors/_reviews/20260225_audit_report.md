# PRONTO Project Audit Report - 2026-02-25

Este reporte documenta los hallazgos de la auditoría completa del proyecto Pronto, enfocándose en seguridad, cumplimiento de principios de arquitectura, calidad de código, UX y mantenimiento de assets estáticos.

## Resumen Ejecutivo
El proyecto presenta una base sólida con una clara separación de responsabilidades. Sin embargo, se han detectado inconsistencias críticas en el manejo de PII, violaciones a principios de no eliminación, alta redundancia de código, deuda técnica en forma de archivos masivos y una gestión de assets estáticos que requiere limpieza y corrección de extensiones y rutas.

---

## Hallazgos de Assets Estáticos (P2 - P3)

### [BUG-STATIC-01] Ruta de Imagen Placeholder Incorrecta (P2)
*   **Descripción**: El template `index.html` de `pronto-client` intenta cargar el placeholder de productos desde `branding/placeholder.png`, pero el archivo real se encuentra en `icons/placeholder.png`.
*   **Impacto**: Las imágenes de productos sin definir muestran iconos rotos en el cliente.
*   **Recomendación**: Actualizar la ruta a `{{ restaurant_assets }}/icons/placeholder.png`.

### [BUG-STATIC-02] Discrepancia en Extensión de Logo (P2)
*   **Descripción**: El componente `BrandingSettings.vue` de empleados espera `logo.png`, pero el archivo en el servidor de assets es `logo.jpg`.
*   **Ubicación**: `pronto-static/src/vue/employees/components/BrandingSettings.vue`.
*   **Impacto**: El logo del restaurante no se visualiza correctamente en la configuración de branding de empleados.
*   **Recomendación**: Normalizar el nombre del archivo a `.png` en el servidor o actualizar el componente para buscar `.jpg`.

### [BUG-STATIC-03] Acumulación de "Zombies" CSS en Static (P3)
*   **Descripción**: El directorio `assets/css/clients/` contiene más de 15 archivos CSS que no son referenciados por ningún template activo.
*   **Recomendación**: Depurar y eliminar archivos CSS obsoletos.

---

## Hallazgos de Código y Buenas Prácticas (P1 - P3)

### [BUG-CODE-01] Fragmentación de Lógica: JS Vanilla en Templates Vue (P1)
*   **Descripción**: `pronto-client` utiliza bloques extensos de `<script>` en sus templates para gestionar lógica crítica como modales de productos y gestión de mesas.
*   **Recomendación**: Migrar toda la lógica de los scripts inline a componentes Vue 3 nativos en `pronto-static`.

### [BUG-CODE-02] Archivos de Código Masivos (Deuda Técnica) (P2)
*   **Descripción**: Archivos como `WaiterBoard.vue` (1,776 líneas) y `seed.py` (5,159 líneas) superan los límites razonables de mantenimiento.
*   **Recomendación**: Fragmentar en sub-componentes y servicios especializados.

---

## Hallazgos de UX y Accesibilidad (P1 - P3)

### [BUG-UX-01] Uso Masivo de `alert()` Bloqueante (P1)
*   **Descripción**: La aplicación de empleados utiliza `alert()` en más de 40 lugares, bloqueando la interacción en entornos críticos.
*   **Recomendación**: Migrar a `window.showToast()`.

### [BUG-UX-02] Inconsistencia en Accesibilidad - Client (P1)
*   **Descripción**: Elementos interactivos implementados como `<div>` con `onclick`, inaccesibles por teclado.
*   **Recomendación**: Reemplazar por `<button>` o `<a>`.

---

## Hallazgos de Seguridad (P0 - P1)

### [BUG-SEC-01] Inconsistencia en Encriptación de PII de Empleados (P0)
*   **Descripción**: El modelo `Customer` encripta PII, pero el modelo `Employee` guarda `email` y `phone` en texto plano.
*   **Recomendación**: Implementar `hybrid_property` con encriptación en `Employee`.

### [BUG-SEC-02] Riesgo de Inyección SQL en Scripts (P1)
*   **Descripción**: Interpolación directa de strings en SQL en `pronto-abc.sh`.
*   **Recomendación**: Usar parámetros posicionales.

---

## Hallazgos de Arquitectura y Documentación (P1 - P2)

### [BUG-ARC-01] Redundancia Masiva de Rutas API (P2)
*   **Descripción**: `pronto-employees` duplica rutas API de `pronto-api` sin protección de ScopeGuard en las rutas directas.
*   **Recomendación**: Eliminar redundancia y centralizar en `pronto-api`.

---

**Auditor**: Gemini CLI
**Fecha**: 2026-02-25
**Estado**: Auditoría de Assets Finalizada.
