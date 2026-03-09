# Guía Maestra de Uso de Prompts (Meta-Prompt): Proyecto PRONTO

Este documento es la brújula para navegar y utilizar toda la documentación generada en la carpeta `pronto-docs/business/`. Explica cómo alimentar a una IA con el contexto adecuado según la tarea.

---

## 🏗️ Cómo usar esta Biblioteca de Prompts

Para obtener los mejores resultados de una IA (Claude, Gemini, ChatGPT), sigue estos pasos:

### 1. Elige tu "Persona"
Dependiendo de qué parte del código vayas a tocar, copia el contenido del archivo `prompt-*.md` correspondiente y pégalo al inicio de tu conversación.
- **¿Vas a tocar el Frontend del cliente?** Usa `prompt-customer-view.md`.
- **¿Vas a modificar la base de datos?** Usa `prompt-database-engineer.md`.
- **¿Es una tarea de DevOps?** Usa `prompt-devops-ops.md`.

### 2. Carga el Contexto Maestro (Recomendado)
Para cualquier tarea que involucre lógica de negocio (órdenes, pagos, sesiones), carga siempre el archivo `pronto-service-flow-master.md`. Este archivo garantiza que la IA no rompa el ciclo de vida de las órdenes.

### 3. Aplica los Guardrails
Si quieres que la IA audite tu código, dale el archivo `technical-debt-guardrails.md`. Esto evitará que te sugiera anti-patrones como usar sesiones de Flask para empleados.

---

## 🗺️ Mapa de Referencia Rápida

| Tarea | Archivo de Contexto Primario |
|---|---|
| **Nueva funcionalidad de cliente** | `prompt-customer-view.md` |
| **Cambios en el KDS (Cocina)** | `prompt-chef-view.md` |
| **Reportes y Dashboard Admin** | `prompt-admin-view.md` |
| **Integración de IA Local** | `prompt-ai-orchestrator.md` |
| **Refactorización de Lógica Shared** | `prompt-architect-general.md` |
| **Automatización de Pruebas** | `prompt-qa-automation.md` |
| **Auditoría de Archivos** | `master-compliance-checklist.md` |

---

## 🤖 Prompt para Inicializar una Sesión de Desarrollo Nueva

"Hola. Vamos a trabajar en el proyecto **Pronto**. Por favor, lee y asume las reglas de negocio y estándares técnicos definidos en `pronto-docs/business/pronto-service-flow-master.md` y `pronto-docs/business/prompt-architect-general.md`. Mi tarea actual es: [DESCRIBE TU TAREA AQUÍ]. Utiliza el checklist en `pronto-docs/business/master-compliance-checklist.md` para validar que cada archivo que toquemos cumpla con su responsabilidad."
