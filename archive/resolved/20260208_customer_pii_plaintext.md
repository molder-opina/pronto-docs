---
ID: ERR-20260208-004
FECHA: 2026-02-08
PROYECTO: pronto-shared
SEVERIDAD: alta
TITULO: Cliente PII almacenada en texto plano (Inconsistencia)
DESCRIPCION: El modelo Customer almacena email y phone directamente como String, mientras que Employee usa encrypt_string. Esto viola el guardrail de cifrado de PII para datos de clientes.
PASOS_REPRODUCIR:
1) Revisar la definición de la clase Customer en models.py.
2) Comparar con la clase Employee.
RESULTADO_ACTUAL: Customer.email y Customer.phone son columnas de texto plano.
RESULTADO_ESPERADO: Deben ser hybrid_properties que cifren al escribir y descifren al leer.
UBICACION: pronto-libs/src/pronto_shared/models.py
EVIDENCIA: Definición de columnas en líneas 100-115.
HIPOTESIS_CAUSA: Omisión de seguridad durante la creación inicial del dominio de clientes.
ESTADO: PENDIENTE
---
PLAN DE SOLUCION:
1. Renombrar columnas a email_encrypted y phone_encrypted.
2. Implementar hybrid_properties para email y phone usando pronto_shared.security.encrypt_string/decrypt_string.
3. Asegurar que email_hash se actualice automáticamente para permitir búsquedas.
