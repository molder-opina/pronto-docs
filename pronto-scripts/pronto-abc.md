# pronto-abc.sh

Script operativo para administración masiva de datos de negocio en entornos `dev/test`.

Ruta:
- `pronto-scripts/bin/pronto-abc.sh`

## Objetivo

Centralizar en un solo comando las operaciones ABC solicitadas:
- Limpieza de órdenes, sesiones y feedback
- Pago/cancelación/actualización masiva de estado de órdenes
- Gestión de asignación de mesas a meseros
- Limpieza de áreas, mesas, aditamientos, productos, empleados, clientes
- Gestión de parámetros de sistema

## Seguridad

- Bloquea operaciones destructivas fuera de `PRONTO_ENV=dev|test`.
- Requiere `--yes` para operaciones destructivas.
- Permite override explícito con `--force`.
- No usa `DROP` ni `TRUNCATE`.

## Comandos principales

```bash
./pronto-scripts/bin/pronto-abc.sh status
./pronto-scripts/bin/pronto-abc.sh orders:status
./pronto-scripts/bin/pronto-abc.sh orders:list

./pronto-scripts/bin/pronto-abc.sh orders:clean --yes
./pronto-scripts/bin/pronto-abc.sh sessions:clean --yes
./pronto-scripts/bin/pronto-abc.sh feedback:clean --yes

./pronto-scripts/bin/pronto-abc.sh orders:pay-all --yes
./pronto-scripts/bin/pronto-abc.sh orders:cancel-all --yes
./pronto-scripts/bin/pronto-abc.sh orders:set-status --status ready --yes

./pronto-scripts/bin/pronto-abc.sh tables:assign-waiter --waiter-id <uuid> --all-tables --yes
./pronto-scripts/bin/pronto-abc.sh tables:assign-waiter --waiter-id <uuid> --area-id 1 --yes

./pronto-scripts/bin/pronto-abc.sh areas:clean --yes
./pronto-scripts/bin/pronto-abc.sh tables:clean --yes
./pronto-scripts/bin/pronto-abc.sh modifiers:clean --yes
./pronto-scripts/bin/pronto-abc.sh products:clean --yes
./pronto-scripts/bin/pronto-abc.sh employees:clean --yes
./pronto-scripts/bin/pronto-abc.sh customers:clean --yes

./pronto-scripts/bin/pronto-abc.sh settings:list
./pronto-scripts/bin/pronto-abc.sh settings:set --key waiter_can_collect --value true --value-type boolean --category payments --yes
./pronto-scripts/bin/pronto-abc.sh settings:reset-defaults --yes

./pronto-scripts/bin/pronto-abc.sh full:clean --yes
```

## Notas

- `orders:pay-all` aplica métodos de pago rotativos (`cash`, `card`, `transfer`, `wallet`).
- `full:clean` ejecuta la limpieza integral por bloques y resetea defaults de `pronto_system_settings`.
- Si necesitas otra variante de limpieza por módulo, extender `pronto-abc.sh` con un subcomando dedicado.
