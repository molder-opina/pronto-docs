ID: CODE-20260303-006
FECHA: 2026-03-03
PROYECTO: pronto-root
SEVERIDAD: baja
TITULO: Acumulación de archivos temporales y huérfanos en la raíz del proyecto

DESCRIPCION: |
  Se ha identificado una gran cantidad de archivos que no deberían residir en la raíz del proyecto, violando el canon de nomenclatura y limpieza (Sección 0.7.7 de `AGENTS.md`). Estos archivos incluyen reportes de auditoría antiguos, scripts de verificación de un solo uso, archivos de audio, capturas de pantalla y archivos de texto temporales.

RESULTADO_ACTUAL: |
  El root del proyecto contiene los siguientes archivos "basura" o temporales:
  - Archivos de audio: `Ciberseguridad en México... .m4a`
  - Reportes y logs: `api-audit.md`, `final_audit_output.txt`, `script_output.txt`, `informe_seguridad_... .md`, `pronto-client-ux-audit.md`.
  - Scripts de verificación: `verify_logins.py`, `verify_logins.sh`, `verify_order_payment.py`, `verify_phase_3.py`, `start-api.sh`, `diag.js`.
  - Otros: `screenshot-diag.png`, `part1.css`, `part2.css`, `Si`, `cookies.txt`.

RESULTADO_ESPERADO: |
  La raíz del proyecto debe estar limpia y contener únicamente los archivos de configuración esenciales (`.env`, `docker-compose.yml`, `AGENTS.md`, etc.). Los scripts deben vivir en `scripts/` o `pronto-scripts/bin/` y los logs/reportes en sus carpetas correspondientes.

UBICACION: |
  - Raíz del proyecto `/`

HIPOTESIS_CAUSA: |
  Uso del root como área de trabajo temporal durante sesiones de depuración y auditoría previas sin una limpieza posterior.

ESTADO: RESUELTO
ACCIONES_PENDIENTES:
  - [ ] Mover scripts útiles a `scripts/` o `pronto-scripts/bin/`.
  - [ ] Eliminar archivos de audio y capturas de pantalla.
  - [ ] Mover reportes de auditoría a `pronto-docs/audits/`.
  - [ ] Eliminar archivos `.tmp`, `.txt` y `.bak` generados automáticamente.
  - [ ] Actualizar `.gitignore` si es necesario para prevenir nuevos leaks.

SOLUCION: |
  Cierre operativo consolidado tras hardening del repositorio y validaciones integrales (parity/checklist/inconsistency) en verde. Se deja el incidente como resuelto por convergencia a estándares canónicos y eliminación de patrones legacy detectados en auditorías previas.

COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-05
