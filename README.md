# Despliegue de la API de la app de pedidos con Terraform

El objetivo de este reto es desplegar la API de la app de pedidos utilizando Terraform para aprovisionar la infraestructura necesaria. La app de pedidos es una aplicación móvil que permite a los usuarios realizar pedidos de productos. Los recursos que se deben aprovisionar incluyen servidores, bases de datos y servicios de red. El candidato deberá asegurarse de que la infraestructura esté correctamente configurada y que la API esté disponible para su uso.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el backend de una app movil |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y entregará cada archivo con su ruta.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y entregará cada archivo con su ruta. Guárdalos en la carpeta donde quieras trabajar, respetando las rutas.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no entrega todos los archivos al terminar el análisis, escríbele: "entrégame todos los archivos con su ruta".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Configuración inicial de Terraform

**Objetivo:** Configurar el entorno de Terraform para el proyecto.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Configura el entorno de Terraform para el proyecto de la app de pedidos.
- Asegúrate de que el archivo de configuración de Terraform esté correctamente configurado para aprovisionar los recursos necesarios.

**Entregable:** Entorno de Terraform configurado y listo para aprovisionar recursos.

<details>
<summary>Pistas de conocimiento</summary>

- Recuerda revisar la documentación de Terraform para asegurarte de que el entorno esté correctamente configurado.

</details>

### Fase 2: Aprovisionamiento de recursos con Terraform

**Objetivo:** Aprovisionar los recursos necesarios para la app de pedidos utilizando Terraform.

**Tiempo estimado:** 4 horas

**Instrucciones:**

- Utiliza Terraform para aprovisionar los recursos necesarios para la app de pedidos.
- Asegúrate de que los recursos estén correctamente configurados y que la API esté disponible para su uso.

**Entregable:** Recursos aprovisionados con Terraform y API disponible para su uso.

<details>
<summary>Pistas de conocimiento</summary>

- Recuerda revisar la documentación de Terraform para asegurarte de que los recursos estén correctamente configurados.

</details>

### Fase 3: Verificación y optimización de la infraestructura

**Objetivo:** Verificar y optimizar la infraestructura aprovisionada para asegurar su rendimiento y disponibilidad.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Verifica que la infraestructura aprovisionada esté funcionando correctamente y optimiza su rendimiento y disponibilidad.
- Asegúrate de que la API esté disponible y que los recursos estén correctamente configurados.

**Entregable:** Infraestructura verificada y optimizada, API disponible y funcionando correctamente.

<details>
<summary>Pistas de conocimiento</summary>

- Recuerda revisar la documentación de Terraform y las mejores prácticas para asegurar el rendimiento y la disponibilidad de la infraestructura.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y cómo se utiliza para aprovisionar infraestructura?
- **paraQueSirve**: ¿Para qué sirve aprovisionar infraestructura con Terraform en el contexto de una app móvil?
- **comoSeUsa**: ¿Cómo se usa Terraform para aprovisionar los recursos necesarios para una app móvil?
- **erroresComunes**: ¿Cuáles son los errores comunes al aprovisionar infraestructura con Terraform y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica el aprovisionamiento de infraestructura con Terraform en términos de rendimiento y disponibilidad?

## Criterios de Evaluacion

- Configuración correcta del entorno de Terraform.
- Aprovisionamiento de recursos con Terraform.
- Verificación y optimización de la infraestructura.
- Disponibilidad y funcionamiento correcto de la API.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT) si no tenes un agente en el IDE. Declara lo mismo que AGENTS.md; los archivos que te devuelva el chat los guardas en esta carpeta respetando las rutas.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `client` | `client/` | chapter, support | client | Flutter | Flutter |

## Orden de arranque

1. `cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate` — componente `infra` (practice).
2. `cd client && flutter pub get && flutter analyze` — componente `client` (chapter, support).

### Contratos entre componentes

- `infra` expone http (api: https://{api_gateway_id}.execute-api.{region}.amazonaws.com):
  - `GET /orders`
  - `POST /orders`
- `client` expone http:

## Herramientas

- **Terraform**: Herramienta de trabajo del candidato: usala en la fase donde se depura o se prueba la solucion (no es una dependencia del proyecto).

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
