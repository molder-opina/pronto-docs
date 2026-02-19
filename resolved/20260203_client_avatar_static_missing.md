---
ID: ERR-20260203-006
FECHA: 2026-02-03
PROYECTO: pronto-client/pronto-static
SEVERIDAD: media
TITULO: API de avatars apunta a /static/avatars con static_folder deshabilitado
DESCRIPCION: La API de clientes expone URLs /static/avatars/*, pero Flask static_folder está deshabilitado y no existe carpeta de avatars en pronto-static.
PASOS_REPRODUCIR: 1) Llamar GET /api/auth/avatars. 2) Intentar cargar una URL devuelta.
RESULTADO_ACTUAL: URLs /static/avatars/* no resuelven.
RESULTADO_ESPERADO: Assets de avatars servidos desde pronto-static con assets_*.
UBICACION: pronto-client/src/pronto_clients/routes/api/auth.py:371-385; pronto-client/src/pronto_clients/app.py:55-58
EVIDENCIA: url = "/static/avatars/{filename}" y Flask static_folder=None.
HIPOTESIS_CAUSA: Migración a static container sin actualizar rutas de avatars.
ESTADO: RESUELTO
---
