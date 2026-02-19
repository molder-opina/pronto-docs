# Reporte SLA de Bugs

Fuente: pronto-docs/resueltos.txt (BUG/ERR) + enriquecimiento de expedientes

## Resumen
- Tickets BUG/ERR analizados: 47
- Promedio global (dias): 23.55

## Promedio por severidad
- bloqueante: total=10, medidos=10, promedio=36.50 dias
- alta: total=21, medidos=21, promedio=17.76 dias
- media: total=11, medidos=11, promedio=33.55 dias
- baja: total=1, medidos=1, promedio=0.00 dias
- desconocida: total=4, medidos=4, promedio=0.00 dias

## Tickets con mayor tiempo de resolucion (Top 10)
1. [x] BUG-20250215-001 | sev=bloqueante | 2025-02-15 -> 2026-02-15 | 365 dias | pronto-client
   Endpoints de pagos sin autenticación de cliente
2. [x] BUG-20250215-002 | sev=alta | 2025-02-15 -> 2026-02-15 | 365 dias | pronto-client
   Feedback usa JWT de empleados en lugar de customer session
3. [x] BUG-20250215-003 | sev=media | 2025-02-15 -> 2026-02-15 | 365 dias | pronto-static
   Datos de usuario en localStorage vulnerable a XSS
4. [x] BUG-20260210-001-TEMPLATE-CLEANUP | sev=alta | 2026-02-10 -> 2026-02-18 | 8 dias | pronto-employees
   Template cleanup in-place (employees) para eliminar inline CSS/JS legacy
5. [x] BUG-2026-0216-001 | sev=media | 2026-02-16 -> 2026-02-18 | 2 dias | pronto-static
   Memory leak en event listeners de checkout (rebinding sin cleanup)
6. [x] BUG-2026-0216-003 | sev=media | 2026-02-16 -> 2026-02-18 | 2 dias | pronto-client, pronto-static
   Bloque grande de estilos inline en index-alt.html (checkout-offers)
7. [x] BUG-20260214-003 | sev=alta | 2026-02-14 -> 2026-02-14 | 0 dias | pronto-client
   /api/me no verifica revocación de customer_ref
8. [x] BUG-20260214-004 | sev=media | 2026-02-14 -> 2026-02-14 | 0 dias | pronto-client
   auth.py usa auth_bp = api_bp (blueprint frágil) + doble import en __init__.py
9. [x] BUG-20260214-001 | sev=bloqueante | 2026-02-14 -> 2026-02-14 | 0 dias | pronto-client
   notifications.py usa JWT (modelo incorrecto para clientes)
10. [x] BUG-20260214-002 | sev=bloqueante | 2026-02-14 -> 2026-02-14 | 0 dias | pronto-libs
   Password hashing usa SHA256 con pepper estático
