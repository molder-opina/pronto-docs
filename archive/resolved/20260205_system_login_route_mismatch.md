---
ID: ERR-20260205-008
FECHA: 2026-02-05
PROYECTO: pronto-employees
SEVERIDAD: alta
TITULO: Ruta de handoff usa /system/system_login pero debe ser /system/login
DESCRIPCION: Existe un endpoint POST /system/system_login para el handoff. El contrato esperado es que solo exista /system/login (GET/POST) y no exista /system_login.
PASOS_REPRODUCIR: 1) Generar token de reauth desde /system/reauth. 2) Observar que el POST se hace a /system/system_login.
RESULTADO_ACTUAL: Se expone POST /system/system_login.
RESULTADO_ESPERADO: El handoff debe ocurrir via POST /system/login.
UBICACION: pronto-employees/src/pronto_employees/routes/system/auth.py
EVIDENCIA: @system_bp.route("/system_login", methods=["POST"]).
HIPOTESIS_CAUSA: Implementacion intermedia para cumplir "no /system_login fuera de /system".
ESTADO: RESUELTO
---

SOLUCION: Se eliminó POST /system/system_login. El handoff por token ahora se procesa en POST /system/login (process_login) cuando llega un campo form token.
COMMIT: 09c9411
FECHA_RESOLUCION: 2026-02-05
