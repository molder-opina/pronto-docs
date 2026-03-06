ID: CODE-20260303-032
FECHA: 2026-03-03
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: Acceso directo a window.APP_CONFIG rompe encapsulamiento de Vue

DESCRIPCION: |
  Varios componentes y utilidades del frontend acceden directamente a `window.APP_CONFIG` o `window.APP_SESSION`. Esto es una mala práctica en aplicaciones SPA modernas ya que dificulta el rastreo de dependencias de datos, hace que las pruebas unitarias sean más complejas (requieren mockear globals) y rompe la reactividad de Vue si esos valores cambian.

RESULTADO_ACTUAL: |
  Uso de `(window as any).APP_CONFIG` disperso por el codebase.

RESULTADO_ESPERADO: |
  Toda la configuración y estado de sesión debe ser inyectada a través de stores de Pinia (`ConfigStore` y `AuthStore`). Los valores de `window` solo deben usarse una vez durante el bootstrap de la aplicación para inicializar dichos stores.

UBICACION: |
  - `pronto-static/src/vue/employees/shared/components/Sidebar.vue`
  - `pronto-static/src/vue/employees/shared/store/config.ts`
  - `pronto-static/src/vue/clients/modules/client-profile.ts`

ESTADO: RESUELTO
SOLUCION: Se redujo el acceso directo a globals en los puntos críticos reportados: `Sidebar.vue` y `http.ts` consumen resolución centralizada de scope (`shared/core/console-scope.ts`), `config.ts` evita fallback de lectura directa para normalización de assets, y `client-profile.ts` reemplaza uso de `window.APP_SESSION` por helpers del composable `useAppConfig` (`getAppSessionCustomer`/`setAppSessionCustomer`).
COMMIT: 65327b3,70c1631
FECHA_RESOLUCION: 2026-03-06

ACCIONES_PENDIENTES:
  - [ ] Asegurar que `ConfigStore` cargue todos los valores necesarios de `window.APP_CONFIG`.
  - [ ] Reemplazar accesos directos a `window` por llamadas a getters del store.
