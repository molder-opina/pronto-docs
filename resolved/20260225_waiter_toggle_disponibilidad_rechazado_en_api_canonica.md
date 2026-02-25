ID: ERR-20260225-WAITER-MENU-AVAILABILITY-FORBIDDEN
FECHA: 2026-02-25
PROYECTO: pronto-api
SEVERIDAD: alta
TITULO: Mesero no puede activar/desactivar disponibilidad de productos en /waiter/dashboard/products
DESCRIPCION: En el dashboard de mesero, al usar el switch "Disponible" de productos, la UI muestra "Error al actualizar disponibilidad" tanto al habilitar como al deshabilitar.
PASOS_REPRODUCIR: 1) Iniciar sesión con rol waiter. 2) Ir a /waiter/dashboard/products. 3) Cambiar switch de disponibilidad en un producto.
RESULTADO_ACTUAL: La mutación PUT a /api/menu-items/<id> es rechazada y la UI muestra error.
RESULTADO_ESPERADO: El mesero debe poder cambiar únicamente `is_available` desde ese módulo.
UBICACION: pronto-api/src/api_app/routes/employees/menu_items.py
EVIDENCIA: Reporte de usuario en UI con mensaje "Error al actualizar disponibilidad" en waiter/products.
HIPOTESIS_CAUSA: Regla de autorización en API canónica restringida a `admin` para `PUT /menu-items/<id>`, sin excepción controlada para toggle de disponibilidad por rol waiter.
ESTADO: RESUELTO
SOLUCION: Se habilitó `PUT /api/menu-items/<id>` para scopes `waiter|admin|system` y se restringió explícitamente al rol waiter a enviar solo `is_available`. Además se corrigió validación de updates parciales en `MenuValidator` para no exigir `category` cuando no se está editando.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-25
