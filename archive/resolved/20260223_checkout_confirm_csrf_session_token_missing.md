ID: BUG-20260223-CHK-CSRF-001
FECHA: 2026-02-23
PROYECTO: pronto-client / pronto-static
SEVERIDAD: bloqueante
TITULO: Confirmar pedido falla tras login/registro por token CSRF inválido de sesión anterior
DESCRIPCION: Después de autenticarse (login o registro), el flujo de checkout intenta crear orden con el token CSRF anterior y el backend responde error CSRF, por lo que no se confirma la orden.
PASOS_REPRODUCIR:
1. Abrir cliente en http://localhost:6080.
2. Registrarse o iniciar sesión desde modal de perfil.
3. Agregar producto al carrito.
4. Ir a Detalles y presionar Confirmar Pedido.
RESULTADO_ACTUAL: Respuesta 400 con mensaje "The CSRF session token is missing." y la orden no se crea.
RESULTADO_ESPERADO: Al confirmar pedido tras autenticarse, se debe crear la orden correctamente y mostrar confirmación.
UBICACION: pronto-client/src/pronto_clients/routes/api/auth.py, pronto-client/src/pronto_clients/routes/api/orders.py, pronto-static/src/vue/clients/modules/client-profile.ts, pronto-static/src/vue/clients/store/user.ts
EVIDENCIA: Prueba HTTP local register -> POST /api/customer/orders con CSRF renovado devuelve 201 y retorna order_id/session_id.
HIPOTESIS_CAUSA: En login/register se ejecutaba session.clear(), invalidando el CSRF ligado a la sesión previa; frontend conservaba token antiguo en meta csrf-token y además el proxy BFF no enviaba auth interno para bypass CSRF inter-servicio.
ESTADO: RESUELTO
SOLUCION: Se agregó rotación/retorno de csrf_token en login/register, actualización inmediata del meta csrf-token en frontend tras auth, y header X-Pronto-Internal-Auth en el proxy BFF hacia pronto-api; además se robusteció el fallback de API_BASE_URL cuando apunta a localhost dentro de contenedor.
COMMIT: local-uncommitted
FECHA_RESOLUCION: 2026-02-23
