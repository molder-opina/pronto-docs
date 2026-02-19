## [BUG - Deuda Técnica] Dependencias de Desarrollo Faltantes en `pronto-static`

**Componente:** `pronto-static`
**Severidad:** Media

**Descripción:**
El archivo `package.json` del componente `pronto-static` define scripts para `lint` y `format` que dependen de `eslint` y `prettier` respectivamente. Sin embargo, ninguno de estos paquetes está incluido en las `devDependencies`.

Esto indica un entorno de desarrollo incompleto que puede llevar a inconsistencias en el estilo del código y a la omisión de errores comunes que el linter podría detectar. La falta de estas dependencias explícitas es una mala práctica, ya que depende de que los desarrolladores tengan estas herramientas instaladas globalmente.

**Acción Recomendada:**
Añadir `eslint`, `prettier` y sus plugins correspondientes (ej. `eslint-plugin-vue`, `@typescript-eslint/parser`) a las `devDependencies` en `package.json` y confirmar que los scripts `lint` y `format` se ejecutan correctamente en un entorno limpio.

---

## [BUG - Calidad de Código] Ausencia de Framework de Pruebas en `pronto-static`

**Componente:** `pronto-static`
**Severidad:** Alta

**Descripción:**
El archivo `package.json` no incluye ninguna dependencia de un framework de pruebas de frontend (como `vitest`, `jest`, `cypress`, o `playwright`). Esto sugiere fuertemente que el componente `pronto-static` carece de una suite de pruebas automatizadas (unitarias, de integración o E2E).

La ausencia de pruebas automatizadas es una deuda técnica grave que incrementa el riesgo de regresiones, dificulta la refactorización y reduce la fiabilidad general de la interfaz de usuario.

**Acción Recomendada:**
1.  Integrar un framework de pruebas moderno y compatible con Vite/Vue, como `vitest`.
2.  Establecer una política de desarrollo que requiera la creación de pruebas para nuevas funcionalidades y correcciones de bugs.
3.  Comenzar a escribir pruebas para los componentes más críticos de la aplicación (ej. autenticación, gestión de órdenes, pagos).

---

ID: AUDIT-20260215-FRONTEND
FECHA: 2026-02-15
PROYECTO: pronto-static
SEVERIDAD: alta
TITULO: Auditoría frontend - dependencias de lint/format y framework de pruebas
ESTADO: RESUELTO
SOLUCION: Verificado en `pronto-static/package.json` que existen scripts `lint`, `format`, `test`, `test:run`, `test:coverage` y dependencias `eslint`, `prettier`, `eslint-plugin-vue`, `@vue/eslint-config-*`, `vitest`, `@vue/test-utils`, `jsdom`.
COMMIT: pendiente
FECHA_RESOLUCION: 2026-02-18
