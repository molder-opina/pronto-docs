ID: STA-20260307-005
FECHA: 2026-03-07
PROYECTO: pronto-static
SEVERIDAD: media
TITULO: script shell con naming no canonico (create_avatar.sh)
DESCRIPCION:
  El script auxiliar `create_avatar.sh` usaba `snake_case`, violando el canon `kebab-case.sh` para shell scripts.
PASOS_REPRODUCIR:
  1. Revisar el nombre del archivo en la raíz de `pronto-static`.
RESULTADO_ACTUAL:
  El script ahora usa nombre canónico: `create-avatar.sh`.
RESULTADO_ESPERADO:
  Nombre en kebab-case (`create-avatar.sh` o equivalente canónico).
UBICACION:
  - `pronto-static/create-avatar.sh`
ESTADO: RESUELTO
SOLUCION:
  Se renombró `pronto-static/create_avatar.sh` a `pronto-static/create-avatar.sh`.
  Validación: `bash -n pronto-static/create-avatar.sh` => OK; check de existencia confirma que el path nuevo existe y el viejo ya no.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
