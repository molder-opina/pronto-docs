ID: TEST-20260307-056
FECHA: 2026-03-07
PROYECTO: root,pronto-scripts
SEVERIDAD: media
TITULO: pronto-apps.sh usa sustitución anidada inválida para resolver puertos en print_status
DESCRIPCION:
  `./pronto-apps.sh` fallaba con `bad substitution` al resolver los puertos de las apps, porque usaba
  `eval port="\${PORTS_${app^^}}"`. En macOS esto rompe doblemente: por expansión anidada frágil y por el
  uso de `${var^^}`, no soportado por Bash 3.2.
PASOS_REPRODUCIR:
  1. Ejecutar `./pronto-apps.sh status`.
  2. Observar `bad substitution` en la sección de `Service Status` y/o `URLs`.
RESULTADO_ACTUAL:
  El script no podía imprimir el estado/URLs de apps por una expansión inválida.
RESULTADO_ESPERADO:
  El script debe resolver el puerto por app usando una técnica segura y compatible con Bash en macOS.
UBICACION:
  - `pronto-apps.sh`
  - `pronto-scripts/pronto-root/pronto-apps.sh`
ESTADO: RESUELTO
SOLUCION:
  Se reemplazó el patrón con `eval` y `${app^^}` por una resolución portable: se convierte el nombre del
  servicio a mayúsculas usando `tr` y luego se usa expansión indirecta `${!port_var}`. Se corrigieron las dos
  ocurrencias: la tabla `Service Status` y la sección `URLs`, tanto en root como en `pronto-scripts/pronto-root/`.
  Validación: `bash -n pronto-apps.sh && bash -n pronto-scripts/pronto-root/pronto-apps.sh` => OK;
  `./pronto-apps.sh status` => exit 0 y muestra puertos/URLs sin errores.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-07
