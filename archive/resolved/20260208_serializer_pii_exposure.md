---
ID: ERR-20260208-005
FECHA: 2026-02-08
PROYECTO: pronto-shared
SEVERIDAD: media
TITULO: Exposición de PII en serializadores para empleados
DESCRIPCION: La función serialize_customer incluye email y phone sin enmascarar. Cuando un empleado consulta una orden, ve los datos privados completos del cliente, lo cual excede el "principio de mínimo privilegio".
PASOS_REPRODUCIR:
1) Consultar una orden vía API de empleados.
2) Revisar el objeto "customer" en el JSON de respuesta.
RESULTADO_ACTUAL: Email y teléfono visibles en su totalidad.
RESULTADO_ESPERADO: Datos enmascarados (ej. j***@gmail.com) a menos que el scope sea administrativo/sistema específico.
UBICACION: pronto-libs/src/pronto_shared/serializers.py
EVIDENCIA: Función serialize_customer líneas 130-145.
HIPOTESIS_CAUSA: Falta de lógica de enmascaramiento basada en scope en los serializadores compartidos.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Implementar helper mask_pii(value, type) en pronto_shared.utils.
2. Modificar serialize_customer para aplicar la máscara si no es el dueño de la cuenta o un rol admin.
