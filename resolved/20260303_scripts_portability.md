ID: OPS-20260303-SCRIPTS-PORTABILITY
FECHA: 2026-03-03
PROYECTO: pronto-scripts
SEVERIDAD: baja
TITULO: Falta de portabilidad y consistencia en shell scripts (macOS vs Linux)

DESCRIPCION: |
  Se han detectado inconsistencias en el uso de comandos básicos entre scripts que impiden su correcto funcionamiento en diferentes sistemas operativos:
  1. `up.sh` usa `sed -i ''` (sintaxis requerida en macOS/BSD).
  2. `rebuild.sh` usa `sed -i` (sintaxis estándar de GNU/Linux).
  3. `os-detect.sh`, destinado a centralizar la detección del SO, se encuentra vacío.
  4. `rebuild.sh` referencia una variable `ENV_FILE_DOT` que no parece estar definida en el script ni en sus librerías.

RESULTADO_ACTUAL: |
  Los scripts fallan silenciosamente o con errores de sintaxis dependiendo del SO donde se ejecuten.

RESULTADO_ESPERADO: |
  1. Implementar la detección de SO en `os-detect.sh`.
  2. Crear un wrapper para `sed` o usar una sintaxis compatible para ambos sistemas.
  3. Asegurar que todas las variables utilizadas estén definidas o tengan un valor por defecto.

UBICACION: |
  - `pronto-scripts/bin/up.sh`
  - `pronto-scripts/bin/rebuild.sh`
  - `pronto-scripts/bin/lib/os-detect.sh`

ESTADO: RESUELTO
SOLUCION: Se implementó `bin/lib/os-detect.sh` con detección de SO y helper `sed_inplace`, y se normalizó su uso en `bin/up.sh` y `bin/rebuild.sh`; además se definió `ENV_FILE_DOT` en `rebuild.sh` para evitar referencia indefinida.
COMMIT: c0407fe
FECHA_RESOLUCION: 2026-03-05

ACCIONES_PENDIENTES:
  - [ ] Poblar `os-detect.sh` con lógica de detección de SO (uname).
  - [ ] Normalizar el uso de `sed` en todos los scripts.
  - [ ] Definir `ENV_FILE_DOT` en `rebuild.sh` o eliminar su uso si es redundante.
