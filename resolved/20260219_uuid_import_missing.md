ID: ERR-20260219-UUID-IMPORT-MISSING
FECHA: 2026-02-19
PROYECTO: pronto-libs
SEVERIDAD: bloqueante
TITULO: customer_service.py usa UUID sin importarlo
DESCRIPCION: El archivo customer_service.py tiene una funcion update_customer que usa el tipo UUID en la signatura pero no importa UUID del modulo uuid, causando NameError al importar el modulo.
PASOS_REPRODUCIR:
1. Reiniciar contenedor employees
2. Verificar logs del contenedor
3. Observar NameError: name 'UUID' is not defined
RESULTADO_ACTUAL: El contenedor employees entra en ciclo de reinicio fallido
RESULTADO_ESPERADO: El contenedor employees debe arrancar correctamente
UBICACION: pronto-libs/src/pronto_shared/services/customer_service.py linea 171
EVIDENCIA: docker logs pronto-employees-1 muestra NameError: name 'UUID' is not defined
HIPOTESIS_CAUSA: Cambio reciente agrego el tipo UUID sin agregar el import
ESTADO: RESUELTO
SOLUCION: Agregado 'from uuid import UUID' a los imports del archivo
COMMIT: pending
FECHA_RESOLUCION: 2026-02-19
