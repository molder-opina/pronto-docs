ID: ERR-20260220-002
FECHA: 2026-02-20
PROYECTO: pronto-static
SEVERIDAD: baja
TITULO: Test fallando en EmployeesManager.spec.ts
DESCRIPCION: |
  El test "renders correctly and has accessible buttons" falla porque busca
  un boton con `title="Editar"` que no existe en el DOM renderizado.

PASOS_REPRODUCIR:
  1. cd pronto-static
  2. npm run test:run
  3. Observar fallo en EmployeesManager.spec.ts

RESULTADO_ACTUAL: |
  ```
  FAIL  components/EmployeesManager.spec.ts > EmployeesManager > renders correctly and has accessible buttons
  AssertionError: expected false to be true
  expect(editBtn.exists()).toBe(true);
  ```

RESULTADO_ESPERADO: |
  Test debe pasar exitosamente.

UBICACION: |
  - src/vue/employees/components/EmployeesManager.spec.ts
  - src/vue/employees/components/EmployeesManager.vue

EVIDENCIA: |
  ```
  ❯ components/EmployeesManager.spec.ts:55:30
     53|     const editBtn = wrapper.find('button[title="Editar"]');
     54|     expect(editBtn.exists()).toBe(true);
  ```

HIPOTESIS_CAUSA: |
  El test no esperaba suficiente tiempo para que las operaciones async
  (carga de roles y empleados) completaran antes de verificar el DOM.

ESTADO: RESUELTO

SOLUCION: |
  - Agregado timeout mas largo para operaciones async (100ms + 50ms)
  - Agregado multiples llamadas a $nextTick()
  - Agregado verificacion de que employees se cargaron antes de buscar botones

COMMIT: 5e5c15b
FECHA_RESOLUCION: 2026-02-21
