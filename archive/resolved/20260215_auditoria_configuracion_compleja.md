## [BUG - Deuda Técnica] Sistema de Configuración Excesivamente Complejo y Frágil

**Componente:** `pronto-libs`
**Severidad:** Alta

**Descripción:**
La auditoría del sistema de configuración ha revelado una arquitectura compleja y frágil que constituye una deuda técnica significativa. El sistema mezcla la gestión de configuración a través de archivos `.env` y tablas en la base de datos de una manera poco intuitiva y propensa a errores.

### Puntos Clave de la Deuda Técnica:

1.  **Lógica de Precedencia Confusa:**
    *   **Hallazgo:** El sistema lee la configuración primero de la tabla `pronto_business_config` en la base de datos y, solo si no la encuentra, recurre al archivo `.env`. En el arranque de la aplicación, existe una sincronización unidireccional que copia valores del `.env` a la base de datos si no existen.
    *   **Impacto:** Este comportamiento es muy confuso. Un desarrollador podría modificar un valor en el archivo `.env` y no ver ningún cambio en la aplicación porque el valor antiguo en la base de datos tiene precedencia. Esto dificulta enormemente la depuración y la gestión de la configuración en diferentes entornos.

2.  **Sincronización Bidireccional Frágil:**
    *   **Hallazgo:** La función `set_config_value` escribe cambios en la base de datos y luego intenta escribir el mismo cambio de vuelta al archivo `.env`.
    *   **Impacto:** Modificar archivos de configuración en tiempo de ejecución es una mala práctica. En muchos entornos de producción modernos (ej. contenedores, sistemas de archivos de solo lectura), esta operación fallará silenciosamente, creando una desincronización entre la base de datos y el archivo `.env`. Esto hace que el estado de la configuración sea impredecible.

3.  **Duplicación de Tablas de Configuración (Confirmado):**
    *   **Hallazgo:** Como se documentó anteriormente en la auditoría del esquema de la base de datos, existen dos tablas casi idénticas para almacenar configuración: `pronto_business_config` y `pronto_system_settings`. El `business_config_service` solo opera sobre la primera, ignorando por completo la segunda.
    *   **Impacto:** Esta duplicación crea una ambigüedad fundamental sobre dónde se debe almacenar o buscar una configuración, fragmentando la gestión y aumentando la probabilidad de errores.

### Conclusión y Acción Recomendada

El sistema actual de configuración es una fuente importante de deuda técnica que debe ser abordada para mejorar la mantenibilidad y fiabilidad del proyecto.

**Acción Recomendada:**
1.  **Unificar las Tablas de Configuración:** Decidir cuál de las dos tablas (`pronto_business_config` o `pronto_system_settings`) será la fuente única de verdad para la configuración en la base de datos. Migrar los datos necesarios y eliminar la tabla redundante.
2.  **Simplificar el Flujo de Configuración:** Rediseñar el sistema para seguir un patrón más simple y predecible. Se recomiendan dos enfoques posibles:
    *   **Enfoque 1 (Configuración solo por Archivos):** Eliminar por completo el almacenamiento de configuración en la base de datos. Utilizar únicamente archivos `.env` (o un sistema de configuración similar) como fuente de verdad. Esto es simple y sigue la metodología de "12-factor app". La desventaja es que los cambios requieren un reinicio de la aplicación.
    *   **Enfoque 2 (DB como Fuente de Verdad):** Mantener la configuración en la base de datos, pero eliminar la sincronización con los archivos `.env`. Los archivos `.env` solo se usarían para la configuración inicial de la base de datos. Todos los cambios posteriores se realizarían a través de una interfaz de administrador y se leerían directamente desde la base de datos. Esto permite cambios en caliente pero requiere una buena interfaz de gestión.
3.  **Eliminar la Escritura a `.env` en Runtime:** Independientemente del enfoque elegido, la funcionalidad que intenta modificar archivos `.env` en tiempo de ejecución (`_update_env_value`) debe ser eliminada.

---

ID: AUDIT-20260215-CONFIG-COMPLEXITY
FECHA: 2026-02-15
PROYECTO: pronto-libs
SEVERIDAD: alta
TITULO: Auditoría de configuración compleja y frágil
ESTADO: RESUELTO
SOLUCION: Hallazgos originales desactualizados. Verificación actual: `pronto_business_config` no existe en esquema runtime, `business_config_service.py` usa `SystemSetting` (`pronto_system_settings`) como fuente activa y `set_config_value()` persiste en DB sin escritura de `.env` en runtime.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
