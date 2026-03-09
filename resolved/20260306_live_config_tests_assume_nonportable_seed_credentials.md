ID: TEST-20260306-040
FECHA: 2026-03-06
PROYECTO: pronto-tests
SEVERIDAD: media
TITULO: live config tests asumen credenciales seed no portables en entorno live
DESCRIPCION:
  `test_config_settings_roundtrip_live.py` usaba cuentas hardcodeadas y fallaba con 401 cuando el
  entorno live no tenía exactamente esas credenciales sembradas.
ESTADO: RESUELTO
SOLUCION:
  La suite ahora admite overrides por `PRONTO_LIVE_ADMIN_EMAIL`, `PRONTO_LIVE_SYSTEM_EMAIL` y
  `PRONTO_LIVE_PASSWORD`, valida la existencia de cuentas activas en DB antes de intentar login y
  hace `skip` explícito cuando el entorno live no está preparado. Validación: `3 skipped` en el
  entorno actual sin tocar runtime ni datos de negocio.
COMMIT: NO_COMMIT_LOCAL
FECHA_RESOLUCION: 2026-03-06
