ID: TEST-20260307-057
FECHA: 2026-03-07
PROYECTO: root,pronto-scripts
SEVERIDAD: media
TITULO: pronto-dev.sh falla tarde con puertos ocupados y no aborta explícitamente si Postgres no queda listo
DESCRIPCION:
  `./pronto-dev.sh` intentaba levantar todo el stack sin revisar antes si los puertos canónicos ya estaban
  ocupados por otro stack/proceso. En ese caso el fallo aparecía a mitad de `docker compose up -d` con errores de
  bind poco guiados. Además, el loop de espera de Postgres no abortaba explícitamente si el servicio no quedaba
  listo dentro del timeout.
PASOS_REPRODUCIR:
  1. Tener otro stack/proceso usando puertos canónicos de PRONTO (por ejemplo 9088/6082/6081/6080/5432/6379).
  2. Ejecutar `./pronto-dev.sh`.
  3. Observar fallo tardío de Docker por bind ocupado o avance del script aunque Postgres no haya quedado listo.
RESULTADO_ACTUAL:
  El script fallaba tarde y con mensajes poco accionables; además no aseguraba abortar si Postgres no estaba listo.
RESULTADO_ESPERADO:
  El script debe detectar conflictos de puertos antes del `up`, explicar qué contenedor/proceso ocupa el puerto
  y abortar claramente si Postgres no queda listo dentro del timeout.
UBICACION:
  - `pronto-dev.sh`
  - `pronto-scripts/pronto-root/pronto-dev.sh`
ESTADO: RESUELTO
SOLUCION:
  Se agregaron helpers de preflight para revisar puertos canónicos (`5432`, `6379`, `9088`, `6082`, `6080`, `6081`),
  permitiendo continuar solo si el puerto ya pertenece al servicio del proyecto actual. Si el puerto está ocupado por
  otro contenedor/proceso, el script ahora aborta antes de `docker compose up -d` con mensajes claros. También se
  añadió una guard clause para abortar si Postgres no queda ready dentro de 30s. El cambio se replicó en la copia
  versionada `pronto-scripts/pronto-root/pronto-dev.sh`. En una segunda iteración del mismo fix, el preflight quedó
  más accionable: ahora también sugiere comandos concretos de inspección (`docker ps`, `lsof`) y, si los conflictos
  provienen de Docker, muestra un `docker stop <contenedores>` listo para copiar/pegar.
  Validación: `bash -n pronto-dev.sh && bash -n pronto-scripts/pronto-root/pronto-dev.sh` => OK; ejecución real con
  stack paralelo `pronto-app-*` => exit 1 temprano, listando los seis conflictos de puerto y sin crear contenedores
  del proyecto actual (`docker compose ps -a` => vacío).
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
