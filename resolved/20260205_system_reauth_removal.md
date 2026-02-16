---
ID: ERR-20260205-010
FECHA: 2026-02-05
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: System permite reautenticacion cross-scope; debe requerir login separado por contexto
DESCRIPCION: El contexto /system permite reauth/handoff a otros scopes (waiter/chef/cashier/admin) sin login separado. Se requiere que cada consola autentique por separado al entrar a su contexto.
PASOS_REPRODUCIR: 1) Login en /system. 2) Cambiar a otra consola via reauth. 3) Entra sin credenciales del contexto.
RESULTADO_ACTUAL: Se genera token de handoff y se inicia sesion en otro scope.
RESULTADO_ESPERADO: No existe reauth/handoff desde /system; al entrar a otro scope debe pedir login de ese contexto.
UBICACION: pronto-employees/src/pronto_employees/routes/system/auth.py; pronto-employees/src/pronto_employees/templates/dashboard_system.html
EVIDENCIA: Endpoints /system/reauth y flujo de token/handoff.
HIPOTESIS_CAUSA: Feature de acceso rapido agregada para conveniencia.
ESTADO: RESUELTO
---

SOLUCION: Se eliminaron endpoints /system/reauth y templates asociados. System ya no genera tokens/handoff cross-scope; al entrar a otra consola se requiere login del contexto.
COMMIT: f853b20
FECHA_RESOLUCION: 2026-02-05
