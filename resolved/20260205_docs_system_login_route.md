---
ID: ERR-20260205-009
FECHA: 2026-02-05
PROYECTO: pronto-docs
SEVERIDAD: media
TITULO: Docs mencionan /system/system_login pero el contrato es /system/login
DESCRIPCION: La documentacion de pronto-employees lista `GET /system/system_login` como login, pero el login/handoff debe ocurrir via /system/login.
PASOS_REPRODUCIR: 1) Abrir pronto-docs/pronto-employees/README.md. 2) Buscar system_login.
RESULTADO_ACTUAL: Se documenta /system/system_login.
RESULTADO_ESPERADO: Documentar /system/login (GET/POST) y el handoff por token via POST /system/login.
UBICACION: pronto-docs/pronto-employees/README.md
EVIDENCIA: Linea que lista `GET /system/system_login`.
HIPOTESIS_CAUSA: Docs no actualizados tras cambio de rutas.
ESTADO: RESUELTO
---

SOLUCION: Se actualizo pronto-docs/pronto-employees/README.md para documentar /system/login (GET/POST) y eliminar /system/system_login.
COMMIT: 95d2dc1
FECHA_RESOLUCION: 2026-02-05
