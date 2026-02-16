# PLAN

1. Documentar incidente de schema en `pronto-docs/errors`.
2. Agregar bootstrap de extensiones necesarias.
3. Definir tablas base canónicas en `10_schema`.
4. Normalizar seeds para cumplir deny-rules de `pronto-init`.
5. Ajustar migraciones incompatibles con safety-check y/o tipos.
6. Ejecutar `pronto-init --apply`, `pronto-migrate --apply`, `pronto-init --check`.
7. Desactivar bypass de schema en `.env` y reiniciar stack.
8. Validar salud de client/employees y exposición de versión.
9. Registrar cierre en `pronto-docs/resolved` y `resueltos.txt`.
