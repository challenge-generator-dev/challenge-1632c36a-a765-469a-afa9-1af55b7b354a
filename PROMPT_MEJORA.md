# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/versions.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/variables.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/outputs.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/api_gateway/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/ecs/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/rds/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/vpc/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/alb/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/security_groups/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/modules/iam/main.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/provider.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.
- `infra/backend.tf` — El topic pide escribir Terraform: este .tf es el ejercicio, no scaffolding.

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

## Lo que le falta a este proyecto

Esto NO lo tenes que adivinar: salio de comparar el proyecto contra la arquitectura declarada del reto y de un analisis estatico del codigo. Completalo TODO.

### Referencias colgando en el codigo que si esta

Cada una rompe la compilacion:

- `client/lib/domain/entities/order.dart` — `OrderStatus.toString`: Se invoca `toString` sobre `OrderStatus`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/lib/data/datasources/order_remote_datasource.dart` — `ApiClient.get`: Se invoca `get` sobre `ApiClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/lib/data/datasources/order_remote_datasource.dart` — `ApiClient.post`: Se invoca `post` sobre `ApiClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/lib/data/datasources/order_remote_datasource.dart` — `ApiClient.patch`: Se invoca `patch` sobre `ApiClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.
- `client/lib/data/datasources/order_remote_datasource.dart` — `ApiClient.delete`: Se invoca `delete` sobre `ApiClient`, pero esa clase no declara ese metodo. Agregalo con su implementacion real, o usa uno de los que si declara.

## Como saber que terminaste

```bash
(cd infra && terraform fmt -check -recursive && terraform init -backend=false && terraform validate) && (cd client && flutter pub get && flutter analyze)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Movil, Especialidad Desarrollador, Tecnología Flutter, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform para la app movil (corrida e2e 20261109083811938), Aprovisiona con Terraform los recursos que consume la aplicacion movil

### Misión / candidato
Desplegar la API de la app de pedidos

### Reto
- Tema: Infraestructura como codigo para el backend de una app movil
- Seniority: senior-l2
- Tipo: practical
- Título: Despliegue de la API de la app de pedidos con Terraform
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración inicial de Terraform — objetivo: Configurar el entorno de Terraform para el proyecto. — entregable (NO resolver): Entorno de Terraform configurado y listo para aprovisionar recursos.
- Fase 2: Aprovisionamiento de recursos con Terraform — objetivo: Aprovisionar los recursos necesarios para la app de pedidos utilizando Terraform. — entregable (NO resolver): Recursos aprovisionados con Terraform y API disponible para su uso.
- Fase 3: Verificación y optimización de la infraestructura — objetivo: Verificar y optimizar la infraestructura aprovisionada para asegurar su rendimiento y disponibilidad. — entregable (NO resolver): Infraestructura verificada y optimizada, API disponible y funcionando correctamente.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/providers.tf ===
# Configuración de providers requeridos para el despliegue de la infraestructura
# de la app de pedidos. Se utilizan los providers oficiales de HashiCorp para AWS,
# generación de recursos aleatorios y plantillas.

terraform {
  required_version = "1.7.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

# Configuración del provider AWS con región por defecto y ajustes para tags
provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

# Configuración adicional para evitar conflictos en nombres de recursos
provider "random" {
  # No requiere configuración específica
}

# Configuración del provider template para renderizado de plantillas
provider "template" {
  # No requiere configuración específica
}

# Variables locales para centralizar configuraciones comunes
locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project_name
    Terraform   = "true"
  }
}

# Validación de variables críticas para evitar despliegues inválidos
locals {
  valid_regions = ["us-east-1", "us-west-2", "eu-west-1", "ap-southeast-1"]
  
  # Validación de región
  is_valid_region = contains(local.valid_regions, var.aws_region)
  
  # Validación de entorno
  valid_environments = ["dev", "staging", "prod"]
  is_valid_environment = contains(local.valid_environments, var.environment)
}

# Outputs para exponer información útil a otros módulos
output "aws_region" {
  description = "Región de AWS donde se despliega la infraestructura"
  value       = var.aws_region
}

output "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  value       = var.environment
}

output "project_name" {
  description = "Nombre del proyecto"
  value       = var.project_name
}

// === ARCHIVO: infra/variables.tf ===
# Variables de entrada para parametrizar la infraestructura de la app de pedidos.
# Estas variables permiten customizar el comportamiento de los módulos de Terraform
# según el entorno y requisitos específicos.

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura"
  type        = string
  # SUPERFICIE DE PRACTICA: Definir un valor por defecto válido para la región
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  # SUPERFICIE DE PRACTICA: Definir un valor por defecto para el entorno
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
  # SUPERFICIE DE PRACTICA: Definir un valor por defecto para el nombre del proyecto
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
  # SUPERFICIE DE PRACTICA: Definir un bloque CIDR válido para la VPC
}

variable "api_gateway_name" {
  description = "Nombre del API Gateway para la app de pedidos"
  type        = string
  # SUPERFICIE DE PRACTICA: Definir un nombre descriptivo para el API Gateway
}

variable "ecs_cluster_name" {
  description = "Nombre del cluster ECS para los servicios de la app"
  type        = string
  # SUPERFICIE DE PRACTICA: Definir un nombre para el cluster ECS
}

variable "rds_instance_class" {
  description = "Clase de instancia para la base de datos RDS"
  type        = string
  # SUPERFICIE DE PRACTICA: Definir una clase de instancia adecuada para el entorno
}

variable "rds_storage_gb" {
  description = "Almacenamiento en GB para la base de datos RDS"
  type        = number
  # SUPERFICIE DE PRACTICA: Definir un valor de almacenamiento inicial
}

variable "rds_engine_version" {
  description = "Versión del motor de la base de datos RDS"
  type        = string
  # SUPERFICIE DE PRACTICA: Definir una versión compatible con PostgreSQL
}

# Validaciones de variables para asegurar valores coherentes
variable "aws_region_validation" {
  description = "Validación de la región AWS seleccionada"
  type        = bool
  default     = true
  
  validation {
    condition     = var.aws_region_validation == true
    error_message = "La región AWS seleccionada no es válida. Regiones permitidas: us-east-1, us-west-2, eu-west-1, ap-southeast-1."
  }
}

variable "environment_validation" {
  description = "Validación del entorno seleccionado"
  type        = bool
  default     = true
  
  validation {
    condition     = var.environment_validation == true
    error_message = "El entorno debe ser uno de: dev, staging, prod."
  }
}

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.7.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }

  skip_credentials_validation = var.skip_credentials_validation
  skip_requesting_account_id  = var.skip_requesting_account_id
  skip_metadata_api_check     = var.skip_metadata_api_check
}

variable "aws_region" {
  description = "Región de AWS donde se aprovisionarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre del proyecto para el etiquetado de recursos"
  type        = string
  default     = "pedidos-app"
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El entorno debe ser dev, staging o prod."
  }
}

variable "skip_credentials_validation" {
  description = "Omite validación de credenciales en entornos locales"
  type        = bool
  default     = false
}

variable "skip_requesting_account_id" {
  description = "Omite solicitud de account ID en entornos locales"
  type        = bool
  default     = false
}

variable "skip_metadata_api_check" {
  description = "Omite verificación de API de metadatos en entornos locales"
  type        = bool
  default     = false
}

// === ARCHIVO: infra/main.tf ===
terraform {
  backend "s3" {
    bucket         = "${var.project_name}-terraform-state"
    key            = "infra/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "${var.project_name}-terraform-locks"
  }
}

module "vpc" {
  source = "../modules/vpc"

  project_name = var.project_name
  environment  = var.environment
  cidr_block   = var.vpc_cidr

  availability_zones = var.availability_zones

  tags = var.common_tags
}

module "security_groups" {
  source = "../modules/security_groups"

  vpc_id                 = module.vpc.vpc_id
  project_name           = var.project_name
  environment            = var.environment
  alb_security_group_id  = module.alb.security_group_id
  ecs_security_group_id  = module.ecs.security_group_id
  rds_security_group_id  = module.rds.security_group_id

  tags = var.common_tags
}

module "alb" {
  source = "../modules/alb"

  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.public_subnet_ids
  project_name         = var.project_name
  environment          = var.environment
  security_group_id    = module.security_groups.alb_security_group_id

  tags = var.common_tags
}

module "ecs" {
  source = "../modules/ecs"

  project_name            = var.project_name
  environment             = var.environment
  vpc_id                  = module.vpc.vpc_id
  subnet_ids              = module.vpc.private_subnet_ids
  cluster_name            = var.ecs_cluster_name
  container_image         = var.api_container_image
  container_port          = var.api_container_port
  desired_count           = var.ecs_desired_count
  security_group_id       = module.security_groups.ecs_security_group_id
  alb_target_group_arn    = module.alb.target_group_arn
  api_gateway_execution_arn = module.api_gateway.execution_arn

  tags = var.common_tags
}

module "rds" {
  source = "../modules/rds"

  project_name         = var.project_name
  environment          = var.environment
  vpc_id               = module.vpc.vpc_id
  db_subnet_ids        = module.vpc.private_subnet_ids
  security_group_id    = module.security_groups.rds_security_group_id
  db_instance_class    = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_engine_version    = var.db_engine_version
  db_name              = var.db_name
  db_username          = var.db_username

  tags = var.common_tags
}

module "api_gateway" {
  source = "../modules/api_gateway"

  project_name        = var.project_name
  environment         = var.environment
  api_name            = var.api_name
  ecs_service_name    = module.ecs.service_name
  alb_dns_name        = module.alb.dns_name
  vpc_endpoint_id     = module.vpc.vpc_endpoint_id

  tags = var.common_tags
}

module "iam" {
  source = "../modules/iam"

  project_name    = var.project_name
  environment     = var.environment
  ecs_cluster_arn = module.ecs.cluster_arn
  ecs_task_role_arn = module.ecs.task_role_arn
  ecs_execution_role_arn = module.ecs.execution_role_arn

  tags = var.common_tags
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Zonas de disponibilidad para las subredes"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "common_tags" {
  description = "Tags comunes para todos los recursos"
  type        = map(string)
  default     = {}
}

variable "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  type        = string
  default     = "pedidos-cluster"
}

variable "api_container_image" {
  description = "Imagen del contenedor de la API"
  type        = string
  default     = "pedidos-api:latest"
}

variable "api_container_port" {
  description = "Puerto del contenedor de la API"
  type        = number
  default     = 8080
}

variable "ecs_desired_count" {
  description = "Número de tareas deseadas en el servicio ECS"
  type        = number
  default     = 2
}

variable "db_instance_class" {
  description = "Clase de instancia de la base de datos RDS"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "Almacenamiento asignado para RDS en GB"
  type        = number
  default     = 20
}

variable "db_engine_version" {
  description = "Versión del motor de base de datos"
  type        = string
  default     = "14.7"
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "pedidos_db"
}

variable "db_username" {
  description = "Usuario maestro de la base de datos"
  type        = string
  default     = "pedidosadmin"
}

variable "api_name" {
  description = "Nombre del API Gateway"
  type        = string
  default     = "pedidos-api"
}

// === ARCHIVO: infra/README.md ===
# Módulo de Infraestructura - App de Pedidos

## Descripción General

Este módulo de Terraform aprovisiona la infraestructura completa necesaria para desplegar la API de la aplicación móvil de pedidos en AWS. La arquitectura utiliza servicios gestionados de AWS para garantizar alta disponibilidad, escalabilidad y seguridad.

## Arquitectura Desplegada

La infraestructura incluye los siguientes componentes:

- **VPC**: Red virtual privada con subredes públicas y privadas en múltiples zonas de disponibilidad.
- **Application Load Balancer**: Balanceador de carga que distribuye tráfico HTTP/HTTPS a los servicios.
- **ECS Fargate**: Servicio de contenedores serverless para ejecutar la API.
- **RDS PostgreSQL**: Base de datos relacional gestionada para persistencia de pedidos.
- **API Gateway**: Puerta de enlace API REST para exposición de endpoints.
- **Security Groups**: Grupos de seguridad para controlar el tráfico entre componentes.
- **IAM Roles**: Roles y políticas para permisos de servicios.

## Endpoints de la API

La API expone los siguientes endpoints para la aplicación móvil:

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | /orders | Lista todos los pedidos del usuario |
| POST | /orders | Crea un nuevo pedido |
| GET | /orders/{id} | Obtiene un pedido específico |
| PUT | /orders/{id} | Actualiza un pedido existente |
| DELETE | /orders/{id} | Cancela un pedido |

La URL base de la API se configura mediante la variable `api_gateway_endpoint` y sigue el formato:
```
https://{api_gateway_id}.execute-api.{region}.amazonaws.com/{stage}
```

## Uso del Módulo

### Configuración Básica

```hcl
module "infra" {
  source = "./infra"

  aws_region   = "us-east-1"
  project_name = "pedidos-app"
  environment  = "prod"

  vpc_cidr               = "10.0.0.0/16"
  availability_zones     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  ecs_desired_count      = 3
  db_instance_class      = "db.t3.small"
  db_allocated_storage   = 30

  common_tags = {
    Owner     = "team-platform"
    CostCenter = "pedidos-app-prod"
  }
}
```

### Validación Local

Para validar la configuración antes de aplicar los cambios:

```bash
cd infra
terraform init
terraform validate
terraform plan -out=tfplan
```

Para aplicar los cambios:

```bash
terraform apply tfplan
```

### Limpieza de Recursos

Para destruir todos los recursos aprovisionados:

```bash
terraform destroy
```

**Advertencia**: Esta operación elimina todos los recursos creados. Asegúrate de tener backups de la base de datos si es necesario.

## Variables Principales

| Variable | Tipo | Default | Descripción |
|----------|------|---------|-------------|
| aws_region | string | us-east-1 | Región de AWS |
| project_name | string | pedidos-app | Nombre del proyecto |
| environment | string | dev | Entorno (dev/staging/prod) |
| vpc_cidr | string | 10.0.0.0/16 | CIDR de la VPC |
| ecs_desired_count | number | 2 | Número de tareas ECS |
| db_instance_class | string | db.t3.micro | Clase de RDS |

## Outputs del Módulo

Los outputs disponibles permiten integrar con otros módulos o pipelines:

- `api_gateway_endpoint`: URL base del API Gateway
- `ecs_cluster_name`: Nombre del cluster ECS
- `rds_endpoint`: Endpoint de la base de datos RDS
- `vpc_id`: ID de la VPC creada
- `alb_dns_name`: DNS del Application Load Balancer

## Consideraciones de Seguridad

- Los grupos de seguridad restringen el tráfico entre componentes
- Las credenciales de base de datos se almacenan en AWS Secrets Manager
- El acceso a la API se controla mediante API Gateway y IAM
- Los logs se almacenan en CloudWatch para auditoría
- Las comunicaciones entre servicios usan TLS

## Costos Estimados

El costo mensual aproximado para un entorno de producción con la configuración por defecto es:

- VPC: $0
- ALB: $25/mes
- ECS Fargate: $50-150/mes según uso
- RDS PostgreSQL: $50-100/mes
- API Gateway: $3.50 por millón de requests
- Data Transfer: $10-30/mes

## Mantenimiento

- Actualizar versiones de providers en `versions.tf`
- Revisar logs en CloudWatch periódicamente
- Monitorear costos en AWS Cost Explorer
- Realizar backups automáticos de RDS configurados

// === ARCHIVO: infra/provider.tf ===
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
  required_version = ">= 1.7.5"
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = var.owner_team
    }
  }

  skip_credentials_validation = false
  skip_requesting_account_id  = false
  skip_metadata_api_check     = true
  s3_use_path_style           = false

  endpoints {
    apigateway     = "https://apigateway.${var.aws_region}.amazonaws.com"
    ec2            = "https://ec2.${var.aws_region}.amazonaws.com"
    ecs            = "https://ecs.${var.aws_region}.amazonaws.com"
    elasticloadbalancing = "https://elasticloadbalancing.${var.aws_region}.amazonaws.com"
    rds            = "https://rds.${var.aws_region}.amazonaws.com"
    s3             = "https://s3.${var.aws_region}.amazonaws.com"
    iam            = "https://iam.${var.aws_region}.amazonaws.com"
  }

  dynamic "assume_role" {
    for_each = var.enable_cross_account_role ? [1] : []
    content {
      role_arn = "arn:aws:iam::${var.cross_account_id}:role/${var.cross_account_role_name}"
    }
  }

  ignore_tags {
    keys = ["aws:cloudformation:stack-id", "aws:cloudformation:stack-name"]
  }
}

provider "random" {
  version = "3.6.0"
}

provider "template" {
  version = "2.2.0"
}

// === ARCHIVO: infra/outputs.tf ===
output "api_gateway_endpoint" {
  description = "Endpoint base del API Gateway para la API de pedidos"
  value       = module.api_gateway.api_gateway_endpoint
}

output "api_gateway_arn" {
  description = "ARN del API Gateway"
  value       = module.api_gateway.api_gateway_arn
}

output "ecs_cluster_name" {
  description = "Nombre del clúster ECS"
  value       = module.ecs.cluster_name
}

output "ecs_cluster_arn" {
  description = "ARN del clúster ECS"
  value       = module.ecs.cluster_arn
}

output "rds_endpoint" {
  description = "Endpoint de la base de datos RDS"
  value       = module.rds.rds_endpoint
  sensitive   = true
}

output "rds_port" {
  description = "Puerto de la base de datos RDS"
  value       = module.rds.rds_port
}

output "rds_database_name" {
  description = "Nombre de la base de datos RDS"
  value       = module.rds.rds_database_name
}

output "vpc_id" {
  description = "ID de la VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "Bloque CIDR de la VPC"
  value       = module.vpc.vpc_cidr_block
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = module.vpc.public_subnet_ids
}

output "alb_dns_name" {
  description = "Nombre DNS del Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = module.alb.alb_arn
}

output "security_group_ecs_id" {
  description = "ID del security group para ECS"
  value       = module.security_groups.ecs_security_group_id
}

output "security_group_rds_id" {
  description = "ID del security group para RDS"
  value       = module.security_groups.rds_security_group_id
}

output "security_group_alb_id" {
  description = "ID del security group para ALB"
  value       = module.security_groups.alb_security_group_id
}

output "iam_role_ecs_task_execution_arn" {
  description = "ARN del rol de ejecución de tareas ECS"
  value       = module.iam.ecs_task_execution_role_arn
}

output "iam_role_ecs_task_arn" {
  description = "ARN del rol de tarea ECS"
  value       = module.iam.ecs_task_role_arn
}

// === ARCHIVO: infra/terraform.tfvars ===
# ===========================================
# Configuración General del Proyecto
# ===========================================
project_name   = "pedidos-app"
environment    = "dev"
aws_region     = "us-east-1"
owner_team     = "plataforma"

# ===========================================
# Configuración de Red (VPC)
# ===========================================
vpc_cidr_block           = "10.0.0.0/16"
availability_zones       = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs     = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
database_subnet_cidrs    = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]
enable_nat_gateway       = true
single_nat_gateway       = false
enable_vpn_gateway       = false
enable_dns_hostnames     = true
enable_dns_support       = true

# ===========================================
# Configuración de RDS (PostgreSQL)
# ===========================================
rds_instance_class       = "db.t3.micro"
rds_allocated_storage    = 20
rds_storage_type         = "gp3"
rds_engine_version       = "15.4"
rds_database_name        = "pedidos_db"
rds_username             = "dbadmin"
multi_az                 = false
backup_retention_days    = 7
deletion_protection      = false
skip_final_snapshot      = true

# ===========================================
# Configuración de ECS
# ===========================================
ecs_cluster_name          = "pedidos-cluster"
ecs_cluster_capacity_providers = ["FARGATE", "FARGATE_SPOT"]
ecs_default_capacity_provider_strategy = {
  weight = 100
  base   = 1
}
container_image          = "pedidos-api:latest"
container_port           = 8080
container_cpu            = 256
container_memory         = 512
autoscaling_min_capacity = 1
autoscaling_max_capacity = 4
autoscaling_target_cpu   = 70
health_check_grace_period = 60

# ===========================================
# Configuración de API Gateway
# ===========================================
api_gateway_name         = "pedidos-api-gateway"
api_gateway_stage        = "prod"
api_gateway_description  = "API Gateway para la API de pedidos de la app móvil"
enable_api_gateway_logs  = true
api_gateway_throttling_rate_limit  = 100
api_gateway_throttling_burst_limit = 200
cache_enabled            = false

# ===========================================
# Configuración de Application Load Balancer
# ===========================================
alb_name                 = "pedidos-alb"
alb_type                 = "application"
alb_internal             = false
alb_idle_timeout         = 60
enable_deletion_protection = false
access_logs_bucket       = ""
alb_ssl_certificate_arn  = ""
alb_ssl_policy           = "ELBSecurityPolicy-2016-08"

# ===========================================
# Configuración de Security Groups
# ===========================================
allowed_cidr_blocks      = ["0.0.0.0/0"]
allowed_ips_dev          = ["10.0.0.0/8"]
alb_port                 = 443
ecs_task_port            = 8080
rds_port                 = 5432
rds_allowed_cidr         = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]

# ===========================================
# Configuración de IAM
# ===========================================
iam_role_path            = "/pedidos-app/"
iam_force_detach_policy  = true
permissions_boundary     = ""

# ===========================================
# Configuración de S3 para Terraform State
# ===========================================
terraform_state_bucket   = "pedidos-terraform-state"
enable_versioning        = true
enable_server_side_encryption = true
dynamodb_table           = "terraform-locks"

# ===========================================
# Configuración de Tags
# ===========================================
common_tags = {
  Project     = "pedidos-app"
  Environment = "dev"
  ManagedBy   = "Terraform"
  Owner       = "plataforma"
  CostCenter  = "engineering"
  Compliance  = "standard"
}

# ===========================================
# Configuración de Cross-Account (opcional)
# ===========================================
enable_cross_account_role = false
cross_account_id          = ""
cross_account_role_name  = ""

# ===========================================
# Configuración de Monitoreo
# ===========================================
enable_cloudwatch_logs   = true
log_retention_days       = 30
enable_cloudwatch_alarms = true
alarm_email              = "alerts@empresa.com"

# ===========================================
# Configuración de DNS (Route53)
# ===========================================
enable_route53           = false
route53_zone_name        = "pedidos.empresa.com"
route53_record_name      = "api"

# ===========================================
# Configuración de WAF (Web Application Firewall)
# ===========================================
enable_waf               = false
waf_rules = {
  sqli_protection    = true
  xss_protection    = true
  rate_limiting      = true
  rate_limit         = 2000
  geo_restriction    = false
  allowed_countries  = []
}

// === ARCHIVO: infra/backend.tf ===
terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "prod/backend.tfstate"
    region = "us-east-1"
    
    # El estudiante debe completar esta configuración
    # con los valores correctos para su entorno
    
    # Opciones de estado remoto:
    # - encrypt: true (cifrado en S3)
    # - dynamodb_table: "terraform-locks" (para bloqueo de estado)
    # - profile: "default" (perfil de AWS credentials)
  }
}

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
# =============================================================================
# Variables de configuración para el entorno de desarrollo
# =============================================================================
# Este archivo define los valores específicos del ambiente dev
# que Terraform utilizará al ejecutar plan y apply

# -----------------------------------------------------------------------------
# Configuración de AWS
# -----------------------------------------------------------------------------
aws_region = "us-east-1"

# -----------------------------------------------------------------------------
# Configuración de red (VPC y subnets)
# -----------------------------------------------------------------------------
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]

# -----------------------------------------------------------------------------
# Configuración de base de datos RDS PostgreSQL
# -----------------------------------------------------------------------------
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20
db_engine_version    = "15.4"
db_name              = "pedidos_db"
db_username          = "dbadmin"
# NOTA: En producción, usar AWS Secrets Manager para la contraseña
db_password          = "DevPassword2024!"
db_multi_az          = false

# -----------------------------------------------------------------------------
# Configuración de ECS Cluster
# -----------------------------------------------------------------------------
ecs_cluster_name           = "pedidos-app-cluster"
ecs_cluster_instance_type  = "t3.medium"
ecs_cluster_desired_capacity = 2
ecs_cluster_min_size        = 1
ecs_cluster_max_size        = 4

# -----------------------------------------------------------------------------
# Configuración de API Gateway
# -----------------------------------------------------------------------------
api_gateway_stage_name = "dev"
api_gateway_rest_api_name = "pedidos-api"

# -----------------------------------------------------------------------------
# Configuración de Application Load Balancer
# -----------------------------------------------------------------------------
alb_name               = "pedidos-alb"
alb_internal          = false
alb_enable_deletion_protection = false

# -----------------------------------------------------------------------------
# Configuración de servicios y puertos
# -----------------------------------------------------------------------------
app_port           = 8080
db_port            = 5432
alb_listener_port = 80

# -----------------------------------------------------------------------------
# Configuración de seguridad
# -----------------------------------------------------------------------------
allowed_cidr_blocks = ["0.0.0.0/0"]
# En producción, restringir a los rangos de IP de la VPC o CloudFront

# -----------------------------------------------------------------------------
# Etiquetas obligatorias para todas las recursos
# -----------------------------------------------------------------------------
environment = "dev"
project     = "pedidos-app"
owner       = "devops-team"

# -----------------------------------------------------------------------------
# Configuración de Terraform Cloud (opcional)
# -----------------------------------------------------------------------------
# Descomentar si se usa Terraform Cloud en lugar de S3
# terraform_cloud_organization = "mi-organizacion"
# terraform_cloud_workspace    = "pedidos-app-dev"

# -----------------------------------------------------------------------------
# Configuración de logs
# -----------------------------------------------------------------------------
enable_cloudwatch_logs     = true
log_retention_days         = 7

# -----------------------------------------------------------------------------
# Configuración de backup de base de datos
# -----------------------------------------------------------------------------
db_backup_retention_days = 1
db_skip_final_snapshot   = true

# -----------------------------------------------------------------------------
# Configuración de auto-scaling
# -----------------------------------------------------------------------------
autoscaling_enabled           = true
autoscaling_target_cpu_utilization = 70
autoscaling_target_memory_utilization = 80

# -----------------------------------------------------------------------------
# URLs y endpoints (referencias para otras configuraciones)
# -----------------------------------------------------------------------------
# Estos valores se completan automáticamente con los outputs de los módulos
# api_gateway_endpoint = "https://{api_gateway_id}.execute-api.us-east-1.amazonaws.com/dev"
# ecs_cluster_arn      = "arn:aws:ecs:us-east-1:{account}:cluster/pedidos-app-cluster"
# rds_endpoint        = "pedidos-db.xxxxx.us-east-1.rds.amazonaws.com:5432"

// === ARCHIVO: infra/modules/api_gateway/main.tf ===
# Módulo de API Gateway para la API de Pedidos
# Este módulo crea el API Gateway que expondrá los endpoints de la aplicación

variable "name_prefix" {
  description = "Prefijo para nombres de recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se desplegará el API Gateway"
  type        = string
}

variable "alb_dns_name" {
  description = "Nombre DNS del Application Load Balancer"
  type        = string
}

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-east-1"
}

# API Gateway REST API
resource "aws_api_gateway_rest_api" "orders_api" {
  name        = "${var.name_prefix}-orders-api"
  description = "API Gateway para el servicio de pedidos"
  endpoint_configuration {
    types = ["REGIONAL"]
    vpc_endpoint_ids = []
  }
}

# Recurso /orders
resource "aws_api_gateway_resource" "orders" {
  rest_api_id = aws_api_gateway_rest_api.orders_api.id
  parent_id   = aws_api_gateway_rest_api.orders_api.root_resource_id
  path_part   = "orders"
}

# Método GET /orders
resource "aws_api_gateway_method" "orders_get" {
  rest_api_id   = aws_api_gateway_rest_api.orders_api.id
  resource_id   = aws_api_gateway_resource.orders.id
  http_method   = "GET"
  authorization = "NONE"
}

# Método POST /orders
resource "aws_api_gateway_method" "orders_post" {
  rest_api_id   = aws_api_gateway_rest_api.orders_api.id
  resource_id   = aws_api_gateway_resource.orders.id
  http_method   = "POST"
  authorization = "NONE"
}

# Integración con ALB
resource "aws_api_gateway_integration" "orders_get_integration" {
  rest_api_id = aws_api_gateway_rest_api.orders_api.id
  resource_id = aws_api_gateway_resource.orders.id
  http_method = aws_api_gateway_method.orders_get.http_method

  type                    = "HTTP_PROXY"
  uri                     = "http://${var.alb_dns_name}/orders"
  integration_http_method = "GET"
}

resource "aws_api_gateway_integration" "orders_post_integration" {
  rest_api_id = aws_api_gateway_rest_api.orders_api.id
  resource_id = aws_api_gateway_resource.orders.id
  http_method = aws_api_gateway_method.orders_post.http_method

  type                    = "HTTP_PROXY"
  uri                     = "http://${var.alb_dns_name}/orders"
  integration_http_method = "POST"
}

# Deployment del API
resource "aws_api_gateway_deployment" "orders_deployment" {
  rest_api_id = aws_api_gateway_rest_api.orders_api.id

  depends_on = [
    aws_api_gateway_integration.orders_get_integration,
    aws_api_gateway_integration.orders_post_integration
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# Stage de producción
resource "aws_api_gateway_stage" "prod" {
  deployment_id = aws_api_gateway_deployment.orders_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.orders_api.id
  stage_name    = "prod"
}

# Outputs
output "api_gateway_id" {
  description = "ID del API Gateway"
  value       = aws_api_gateway_rest_api.orders_api.id
}

output "api_gateway_execution_arn" {
  description = "ARN de ejecución del API Gateway"
  value       = aws_api_gateway_rest_api.orders_api.execution_arn
}

output "api_gateway_url" {
  description = "URL base del API Gateway"
  value       = "https://${aws_api_gateway_rest_api.orders_api.id}.execute-api.${var.region}.amazonaws.com/prod"
}

output "api_endpoint" {
  description = "Endpoint completo de la API de pedidos"
  value       = "https://${aws_api_gateway_rest_api.orders_api.id}.execute-api.${var.region}.amazonaws.com"
}

// === ARCHIVO: infra/modules/ecs/main.tf ===
# Módulo de ECS para el servicio de pedidos
# Este módulo crea el cluster ECS y el servicio que ejecutará la API como contenedor

variable "name_prefix" {
  description = "Prefijo para nombres de recursos"
  type        = string
}

variable "cluster_name" {
  description = "Nombre del cluster ECS"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "subnet_ids" {
  description = "IDs de las subnets"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID del security group para los contenedores"
  type        = string
}

variable "container_image" {
  description = "Imagen del contenedor de la API"
  type        = string
}

variable "container_port" {
  description = "Puerto del contenedor"
  type        = number
  default     = 8080
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "db_host" {
  description = "Host de la base de datos"
  type        = string
}

variable "db_port" {
  description = "Puerto de la base de datos"
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "db_username" {
  description = "Usuario de la base de datos"
  type        = string
}

variable "db_password" {
  description = "Contraseña de la base de datos"
  type        = string
  sensitive   = true
}

variable "desired_count" {
  description = "Número de tareas deseadas"
  type        = number
  default     = 2
}

variable "cpu" {
  description = "CPU units para la tarea"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Memory para la tarea en MB"
  type        = string
  default     = "512"
}

# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Environment = var.environment
    Project     = var.name_prefix
  }
}

# Task Definition
resource "aws_ecs_task_definition" "api_task" {
  family                   = "${var.name_prefix}-api"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "api"
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name  = "DB_HOST"
          value = var.db_host
        },
        {
          name  = "DB_PORT"
          value = tostring(var.db_port)
        },
        {
          name  = "DB_NAME"
          value = var.db_name
        },
        {
          name  = "DB_USERNAME"
          value = var.db_username
        },
        {
          name  = "ENVIRONMENT"
          value = var.environment
        }
      ]
      secrets = [
        {
          name      = "DB_PASSWORD"
          valueFrom = aws_secretsmanager_secret_version.db_password.arn
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${var.name_prefix}-api"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
}

# IAM Role para ejecución de tareas
resource "aws_iam_role" "ecs_execution_role" {
  name = "${var.name_prefix}-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# IAM Role para la tarea
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.name_prefix}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# Security Group para el servicio ECS
resource "aws_security_group" "ecs_service" {
  name        = "${var.name_prefix}-ecs-service-sg"
  description = "Security group para el servicio ECS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
    Project     = var.name_prefix
  }
}

# ECS Service
resource "aws_ecs_service" "api_service" {
  name            = "${var.name_prefix}-api-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.api_task.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.api_target_group.arn
    container_name   = "api"
    container_port   = var.container_port
  }

  depends_on = [aws_lb_target_group.api_target_group]

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = {
    Environment = var.environment
    Project     = var.name_prefix
  }
}

# Application Load Balancer
resource "aws_lb" "main" {
  name               = "${var.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs_service.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = {
    Environment = var.environment
    Project     = var.name_prefix
  }
}

# Target Group para ALB
resource "aws_lb_target_group" "api_target_group" {
  name     = "${var.name_prefix}-api-tg"
  port     = var.container_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 2
  }
}

# Listener del ALB
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.api_target_group.arn
    type             = "forward"
  }
}

# Secrets Manager para la contraseña de la DB
resource "aws_secretsmanager_secret" "db_password" {
  name        = "${var.name_prefix}-db-password"
  description = "Contraseña de la base de datos de pedidos"

  recovery_window_in_days = 7
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({
    password = var.db_password
  })
}

# Outputs
output "cluster_id" {
  description = "ID del cluster ECS"
  value       = aws_ecs_cluster.main.id
}

output "cluster_name" {
  description = "Nombre del cluster ECS"
  value       = aws_ecs_cluster.main.name
}

output "task_definition_arn" {
  description = "ARN de la task definition"
  value       = aws_ecs_task_definition.api_task.arn
}

output "service_name" {
  description = "Nombre del servicio ECS"
  value       = aws_ecs_service.api_service.name
}

output "alb_dns_name" {
  description = "Nombre DNS del ALB"
  value       = aws_lb.main.dns_name
}

output "alb_target_group_arn" {
  description = "ARN del target group"
  value       = aws_lb_target_group.api_target_group.arn
}

// === ARCHIVO: infra/modules/rds/main.tf ===
# Módulo de RDS para la base de datos de pedidos
# Este módulo crea una instancia de PostgreSQL para persistir los pedidos

variable "name_prefix" {
  description = "Prefijo para nombres de recursos"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "subnet_ids" {
  description = "IDs de las subnets para la base de datos"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID del security group para RDS"
  type        = string
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "db_username" {
  description = "Usuario maestro de la base de datos"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Contraseña maestra de la base de datos"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "Clase de instancia de la base de datos"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Almacenamiento allocated en GB"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "Tipo de almacenamiento"
  type        = string
  default     = "gp3"
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "backup_retention_period" {
  description = "Días de retención de backups"
  type        = number
  default     = 7
}

variable "deletion_protection" {
  description = "Habilitar protección contra eliminación"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Habilitar Multi-AZ"
  type        = bool
  default     = false
}

# Subnet group para RDS
resource "aws_db_subnet_group" "main" {
  name       = "${var.name_prefix}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Environment = var.environment
    Project     = var.name_prefix
  }
}

# Instancia RDS PostgreSQL
resource "aws_db_instance" "main" {
  identifier = "${var.name_prefix}-postgres"

  engine               = "postgres"
  engine_version       = "15.4"
  instance_class       = var.instance_class
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  storage_encrypted    = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.security_group_id]

  backup_retention_period = var.backup_retention_period
  backup_window           = "03:00-04:00"
  maintenance_window      = "mon:04:00-mon:05:00"

  deletion_protection = var.deletion_protection
  multi_az            = var.multi_az

  skip_final_snapshot       = true
  final_snapshot_identifier = "${var.name_prefix}-final-snapshot"

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

  tags = {
    Environment = var.environment
    Project     = var.name_prefix
  }
}

# Security Group para RDS (se crea si no se proporciona)
resource "aws_security_group" "rds" {
  count = var.security_group_id == "" ? 1 : 0

  name        = "${var.name_prefix}-rds-sg"
  description = "Security group para RDS PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = []
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
    Project     = var.name_prefix
  }
}

# Output del security group
locals {
  rds_security_group_id = var.security_group_id != "" ? var.security_group_id : aws_security_group.rds[0].id
}

# Outputs
output "db_instance_id" {
  description = "ID de la instancia RDS"
  value       = aws_db_instance.main.id
}

output "db_instance_endpoint" {
  description = "Endpoint de la instancia RDS"
  value       = aws_db_instance.main.endpoint
}

output "db_instance_address" {
  description = "Dirección de la instancia RDS"
  value       = aws_db_instance.main.address
}

output "db_instance_port" {
  description = "Puerto de la instancia RDS"
  value       = aws_db_instance.main.port
}

output "db_name" {
  description = "Nombre de la base de datos"
  value       = var.db_name
}

output "db_username" {
  description = "Usuario de la base de datos"
  value       = var.db_username
}

output "rds_security_group_id" {
  description = "ID del security group de RDS"
  value       = local.rds_security_group_id
}

// === ARCHIVO: infra/modules/vpc/main.tf ===
# Configuración de VPC para la infraestructura de la app de pedidos
# Este módulo crea la red virtual donde vivirán todos los recursos

# VPC principal con CIDR block privado
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.project}-vpc"
    Environment = var.environment
    Project     = var.project
  }
}

# Subredes públicas para el ALB y servicios expuestos
resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project}-public-subnet-${count.index + 1}"
    Environment = var.environment
    Project     = var.project
    Type        = "public"
  }
}

# Subredes privadas para ECS y RDS
resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + length(var.availability_zones))
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.project}-private-subnet-${count.index + 1}"
    Environment = var.environment
    Project     = var.project
    Type        = "private"
  }
}

# Internet Gateway para conectividad pública
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project}-igw"
    Environment = var.environment
    Project     = var.project
  }
}

# Tabla de rutas para subredes públicas
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.project}-public-rt"
    Environment = var.environment
    Project     = var.project
  }
}

# Asociación de subredes públicas con tabla de rutas
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# NAT Gateway para conectividad saliente desde subredes privadas
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "${var.project}-nat-eip"
    Environment = var.environment
    Project     = var.project
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name        = "${var.project}-nat-gw"
    Environment = var.environment
    Project     = var.project
  }
}

# Tabla de rutas para subredes privadas (salida por NAT)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name        = "${var.project}-private-rt"
    Environment = var.environment
    Project     = var.project
  }
}

# Asociación de subredes privadas con tabla de rutas
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

// === ARCHIVO: infra/modules/alb/main.tf ===
# Configuración del Application Load Balancer para distribuir tráfico a la API
# Este módulo crea el ALB que recibe las peticiones y las dirige a los servicios ECS

# Security group para el ALB (permite tráfico HTTP/HTTPS desde anywhere)
resource "aws_security_group" "alb" {
  name        = "${var.project}-alb-sg"
  description = "Security group para el Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description     = "Salida a internet"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name        = "${var.project}-alb-sg"
    Environment = var.environment
    Project     = var.project
  }
}

# ALB principal
resource "aws_lb" "main" {
  name               = "${var.project}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = var.enable_deletion_protection

  tags = {
    Name        = "${var.project}-alb"
    Environment = var.environment
    Project     = var.project
  }
}

# Target group para los servicios de la API
resource "aws_lb_target_group" "api" {
  name     = "${var.project}-api-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/health"
    matcher             = "200"
  }

  tags = {
    Name        = "${var.project}-api-tg"
    Environment = var.environment
    Project     = var.project
  }
}

# Listener HTTP (redirige a HTTPS en producción)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
}

# Listener HTTPS (solo si se proporciona certificado)
resource "aws_lb_listener" "https" {
  count             = var.certificate_arn != null ? 1 : 0
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTP"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.certificate_arn

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
}

// === ARCHIVO: infra/modules/security_groups/main.tf ===
# Definición de security groups para controlar el acceso a los recursos
# Este módulo crea los grupos de seguridad necesarios para ECS, RDS y otros servicios

# Security group para los contenedores ECS
resource "aws_security_group" "ecs" {
  name        = "${var.project}-ecs-sg"
  description = "Security group para los servicios ECS"
  vpc_id      = var.vpc_id

  # Tráfico entrante desde el ALB
  ingress {
    description     = "Tráfico desde ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  # Tráfico entrante desde la VPC (para comunicaciones internas)
  ingress {
    description = "Tráfico interno VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  # Tráfico saliente a internet y servicios AWS
  egress {
    description     = "Salida a internet"
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name        = "${var.project}-ecs-sg"
    Environment = var.environment
    Project     = var.project
  }
}

# Security group para RDS (base de datos)
resource "aws_security_group" "rds" {
  name        = "${var.project}-rds-sg"
  description = "Security group para la base de datos RDS"
  vpc_id      = var.vpc_id

  # Tráfico entrante desde ECS
  ingress {
    description     = "Tráfico desde ECS"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }

  # Tráfico saliente (limitado)
  egress {
    description = "Salida mínima"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project}-rds-sg"
    Environment = var.environment
    Project     = var.project
  }
}

# Security group para ElastiCache (Redis)
resource "aws_security_group" "elasticache" {
  name        = "${var.project}-elasticache-sg"
  description = "Security group para ElastiCache Redis"
  vpc_id      = var.vpc_id

  # Tráfico entrante desde ECS
  ingress {
    description     = "Tráfico desde ECS"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
  }

  # Tráfico saliente (limitado)
  egress {
    description = "Salida mínima"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project}-elasticache-sg"
    Environment = var.environment
    Project     = var.project
  }
}

// === ARCHIVO: infra/modules/iam/main.tf ===
# =============================================================================
# Módulo IAM - Superficie de práctica
# =============================================================================
# El candidato debe implementar:
# - Roles IAM para ECS (tarea y servicio)
# - Roles IAM para Lambda
# - Políticas inline o gestionadas
# - Attach de políticas a roles
# =============================================================================

# -----------------------------------------------------------------------------
# Variables de entrada
# -----------------------------------------------------------------------------

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetado"
  type        = string
}

variable "account_id" {
  description = "ID de la cuenta de AWS"
  type        = string
}

variable "region" {
  description = "Región de AWS"
  type        = string
}

# -----------------------------------------------------------------------------
# Recursos IAM
# -----------------------------------------------------------------------------

# TODO: Implementar rol IAM para tarea ECS
# Este rol será asumido por las tareas de ECS que ejecutan los contenedores
# Recursos esperados: aws_iam_role.ecs_task_execution

# TODO: Implementar política de ejecución de tareas ECS
# Permisos necesarios: ECR, CloudWatch Logs, Secrets Manager
# Recurso esperado: aws_iam_policy.ecs_task_execution_policy

# TODO: Implementar rol IAM para servicio ECS
# Este rol permite que el servicio ECS interactúe con ALB y otros servicios
# Recurso esperado: aws_iam_role.ecs_service_role

# TODO: Implementar rol IAM para Lambda
# Rol de ejecución para funciones Lambda
# Recurso esperado: aws_iam_role.lambda_exec_role

# TODO: Implementar política de acceso a recursos para Lambda
# Permisos: logs, secrets, sqs, dynamodb
# Recurso esperado: aws_iam_policy.lambda_resource_policy

# TODO: Implementar perfil de instancia EC2 para ECS (si aplica)
# Recurso esperado: aws_iam_instance_profile.ecs_instance_profile

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "ecs_task_execution_role_arn" {
  description = "ARN del rol de ejecución de tareas ECS"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "ecs_service_role_arn" {
  description = "ARN del rol de servicio ECS"
  value       = aws_iam_role.ecs_service.arn
}

output "lambda_exec_role_arn" {
  description = "ARN del rol de ejecución de Lambda"
  value       = aws_iam_role.lambda_exec.arn
}

// === ARCHIVO: client/pubspec.yaml ===
name: order_app
description: Aplicación móvil de pedidos con arquitectura Clean y MVVM.
version: 1.0.0+1
environment:
  sdk: '>=3.6.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  dio: ^5.4.0
  flutter_bloc: ^8.1.3
  get_it: ^7.6.4
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  cupertino_icons: ^1.0.2
  provider: ^6.1.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  build_runner: ^2.4.8
  freezed: ^2.4.6
  json_serializable: ^6.7.1

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/translations/


// === ARCHIVO: client/lib/main.dart ===
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:order_app/core/network/api_client.dart';
import 'package:order_app/core/utils/constants.dart';
import 'package:order_app/data/datasources/order_remote_datasource.dart';
import 'package:order_app/data/repositories/order_repository_impl.dart';
import 'package:order_app/domain/usecases/create_order.dart';
import 'package:order_app/presentation/screens/order_list_screen.dart';
import 'package:order_app/presentation/viewmodels/order_viewmodel.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Configuración del cliente HTTP
  getIt.registerSingleton<ApiClient>(ApiClient(baseUrl: Constants.apiBaseUrl));

  // Data sources
  getIt.registerSingleton<OrderRemoteDataSource>(
    OrderRemoteDataSourceImpl(apiClient: getIt<ApiClient>()),
  );

  // Repositories
  getIt.registerSingleton<OrderRepository>(
    OrderRepositoryImpl(remoteDataSource: getIt<OrderRemoteDataSource>()),
  );

  // Use cases
  getIt.registerSingleton<CreateOrder>(
    CreateOrder(repository: getIt<OrderRepository>()),
  );

  // ViewModels
  getIt.registerFactory<OrderViewModel>(
    () => OrderViewModel(createOrder: getIt<CreateOrder>()),
  );
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const OrderApp());
}

class OrderApp extends StatelessWidget {
  const OrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => getIt<OrderViewModel>(),
        child: const OrderListScreen(),
      ),
    );
  }
}

// === ARCHIVO: client/lib/domain/entities/order.dart ===
part of 'order.dart';

class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final DateTime createdAt;
  final OrderStatus status;
  final double totalAmount;
  final String deliveryAddress;
  final String paymentMethod;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.createdAt,
    required this.status,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.paymentMethod,
  }) {
    if (id.isEmpty) throw ArgumentError('Order ID cannot be empty');
    if (userId.isEmpty) throw ArgumentError('User ID cannot be empty');
    if (items.isEmpty) throw ArgumentError('Order must contain at least one item');
    if (totalAmount <= 0) throw ArgumentError('Total amount must be positive');
    if (deliveryAddress.isEmpty) throw ArgumentError('Delivery address cannot be empty');
    if (paymentMethod.isEmpty) throw ArgumentError('Payment method cannot be empty');
  }

  Order copyWith({
    String? id,
    String? userId,
    List<OrderItem>? items,
    DateTime? createdAt,
    OrderStatus? status,
    double? totalAmount,
    String? deliveryAddress,
    String? paymentMethod,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'status': status.toString().split('.').last,
      'totalAmount': totalAmount,
      'deliveryAddress': deliveryAddress,
      'paymentMethod': paymentMethod,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      deliveryAddress: json['deliveryAddress'] as String,
      paymentMethod: json['paymentMethod'] as String,
    );
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double unitPrice;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
  }) {
    if (productId.isEmpty) throw ArgumentError('Product ID cannot be empty');
    if (productName.isEmpty) throw ArgumentError('Product name cannot be empty');
    if (quantity <= 0) throw ArgumentError('Quantity must be positive');
    if (unitPrice <= 0) throw ArgumentError('Unit price must be positive');
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      unitPrice: (json['unitPrice'] as num).toDouble(),
    );
  }
}

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
  cancelled,
}


// === ARCHIVO: client/lib/domain/repositories/order_repository.dart ===
import 'package:order_app/domain/entities/order.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders({String? userId, OrderStatus? status});
  Future<Order> getOrderById(String orderId);
  Future<Order> createOrder(Order order);
  Future<Order> updateOrderStatus(String orderId, OrderStatus newStatus);
  Future<void> deleteOrder(String orderId);

  Future<List<Order>> getOrdersByUser(String userId, {OrderStatus? status});
  Future<List<Order>> getOrdersByStatus(OrderStatus status);
}

class OrderFilter {
  final String? userId;
  final OrderStatus? status;
  final DateTime? fromDate;
  final DateTime? toDate;

  OrderFilter({
    this.userId,
    this.status,
    this.fromDate,
    this.toDate,
  });
}


// === ARCHIVO: client/lib/domain/usecases/get_orders.dart ===
import 'package:order_app/domain/entities/order.dart';
import 'package:order_app/domain/repositories/order_repository.dart';

class GetOrders {
  final OrderRepository repository;

  GetOrders({required this.repository});

  Future<List<Order>> call({OrderFilter? filter}) async {
    try {
      if (filter == null) {
        return await repository.getOrders();
      }

      if (filter.userId != null && filter.status != null) {
        return await repository.getOrdersByUser(filter.userId!, status: filter.status);
      } else if (filter.userId != null) {
        return await repository.getOrdersByUser(filter.userId!);
      } else if (filter.status != null) {
        return await repository.getOrdersByStatus(filter.status!);
      } else {
        return await repository.getOrders();
      }
    } on Exception catch (e) {
      throw Exception('Failed to fetch orders: ${e.toString()}');
    }
  }

  Future<List<Order>> getPendingOrders() async {
    try {
      return await repository.getOrders(status: OrderStatus.pending);
    } on Exception catch (e) {
      throw Exception('Failed to fetch pending orders: ${e.toString()}');
    }
  }

  Future<List<Order>> getOrdersByUserId(String userId) async {
    try {
      return await repository.getOrders(userId: userId);
    } on Exception catch (e) {
      throw Exception('Failed to fetch orders for user $userId: ${e.toString()}');
    }
  }
}

// === ARCHIVO: client/lib/domain/usecases/create_order.dart ===
import 'package:order_app/domain/entities/order.dart';
import 'package:order_app/domain/repositories/order_repository.dart';

class CreateOrder {
  final OrderRepository repository;

  CreateOrder({required this.repository});

  Future<Order> call(Order order) async {
    if (order == null) {
      throw ArgumentError('Order cannot be null');
    }
    if (order.items == null || order.items.isEmpty) {
      throw ArgumentError('Order must have at least one item');
    }
    if (order.userId == null || order.userId.isEmpty) {
      throw ArgumentError('Order must have a userId');
    }
    if (order.deliveryAddress == null || order.deliveryAddress.isEmpty) {
      throw ArgumentError('Order must have a delivery address');
    }
    if (order.paymentMethod == null || order.paymentMethod.isEmpty) {
      throw ArgumentError('Order must have a payment method');
    }

    final orderWithDefaults = _applyDefaults(order);
    return await repository.createOrder(orderWithDefaults);
  }

  Order _applyDefaults(Order order) {
    final now = DateTime.now();
    final calculatedTotal = _calculateTotal(order.items);
    
    return Order(
      id: order.id.isEmpty ? _generateOrderId() : order.id,
      userId: order.userId,
      items: order.items,
      createdAt: order.createdAt ?? now,
      status: order.status ?? OrderStatus.pending,
      totalAmount: calculatedTotal,
      deliveryAddress: order.deliveryAddress,
      paymentMethod: order.paymentMethod,
    );
  }

  double _calculateTotal(List<OrderItem> items) {
    return items.fold(0.0, (sum, item) => sum + (item.unitPrice * item.quantity));
  }

  String _generateOrderId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'ORD-${timestamp.toString().substring(5)}';
  }
}

// === ARCHIVO: client/lib/core/network/api_client.dart ===
import 'package:dio/dio.dart';
import 'package:order_app/core/utils/constants.dart';

class ApiClient {
  late final Dio _dio;
  final String baseUrl;
  final int connectTimeout;
  final int receiveTimeout;

  ApiClient({
    this.baseUrl = ApiConstants.baseUrl,
    this.connectTimeout = ApiConstants.connectTimeout,
    this.receiveTimeout = ApiConstants.receiveTimeout,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: connectTimeout),
        receiveTimeout: Duration(milliseconds: receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _getAuthToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  String? _getAuthToken() {
    return null;
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Dio get dio => _dio;
}

// === ARCHIVO: client/lib/core/utils/constants.dart ===
class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.ordersapp.com/v1';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  static const String ordersEndpoint = '/orders';
  static const String usersEndpoint = '/users';
  static const String productsEndpoint = '/products';
  static const String authEndpoint = '/auth';
  static const String paymentsEndpoint = '/payments';

  static const int maxRetries = 3;
  static const int retryDelayMs = 1000;
}

class AppConstants {
  AppConstants._();

  static const String appName = 'Order App';
  static const String appVersion = '1.0.0';

  static const int pageSize = 20;
  static const int maxPageSize = 100;

  static const int cacheExpirationMinutes = 30;
  static const int maxCacheSize = 50;
}

class StorageKeys {
  StorageKeys._();

  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String lastSyncTimestamp = 'last_sync_timestamp';
  static const String onboardingCompleted = 'onboarding_completed';
}

class ErrorCodes {
  ErrorCodes._();

  static const String networkError = 'NETWORK_ERROR';
  static const String serverError = 'SERVER_ERROR';
  static const String unauthorized = 'UNAUTHORIZED';
  static const String forbidden = 'FORBIDDEN';
  static const String notFound = 'NOT_FOUND';
  static const String validationError = 'VALIDATION_ERROR';
  static const String unknownError = 'UNKNOWN_ERROR';
}

class HttpStatusCodes {
  HttpStatusCodes._();

  static const int ok = 200;
  static const int created = 201;
  static const int accepted = 202;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int unprocessableEntity = 422;
  static const int internalServerError = 500;
  static const int serviceUnavailable = 503;
}

// === ARCHIVO: client/android/app/src/main/AndroidManifest.xml ===
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
    <application
        android:label="Order App"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:usesCleartextTraffic="true">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:taskAffinity=""
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>

// === ARCHIVO: client/lib/data/datasources/order_remote_datasource.dart ===
import 'package:dio/dio.dart';
import '../../domain/entities/order.dart';
import '../../core/network/api_client.dart';
import '../../core/utils/constants.dart';

abstract class OrderRemoteDataSource {
  Future<List<Order>> getOrders();
  Future<Order> getOrderById(String orderId);
  Future<Order> createOrder(Order order);
  Future<Order> updateOrderStatus(String orderId, OrderStatus newStatus);
  Future<void> deleteOrder(String orderId);
  Future<List<Order>> getOrdersByUser(String userId);
  Future<List<Order>> getOrdersByStatus(OrderStatus status);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiClient apiClient;
  
  static const String _ordersEndpoint = '/orders';
  static const String _usersEndpoint = '/users';
  
  OrderRemoteDataSourceImpl({required this.apiClient});
  
  Map<String, dynamic> _orderToJson(Order order) {
    return {
      'id': order.id,
      'userId': order.userId,
      'items': order.items.map((item) => {
        'productId': item.productId,
        'productName': item.productName,
        'quantity': item.quantity,
        'unitPrice': item.unitPrice,
      }).toList(),
      'createdAt': order.createdAt.toIso8601String(),
      'status': order.status.name,
      'totalAmount': order.totalAmount,
      'deliveryAddress': order.deliveryAddress,
      'paymentMethod': order.paymentMethod,
    };
  }
  
  Order _parseOrderFromJson(Map<String, dynamic> json) {
    return Order.fromJson(json);
  }
  
  List<Order> _parseOrderList(List<dynamic> jsonList) {
    return jsonList.map((json) => _parseOrderFromJson(json as Map<String, dynamic>)).toList();
  }
  
  @override
  Future<List<Order>> getOrders() async {
    try {
      final response = await apiClient.get(_ordersEndpoint);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return _parseOrderList(data);
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Error fetching orders: ${response.statusCode}',
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: _ordersEndpoint),
        message: 'Unexpected error fetching orders: $e',
      );
    }
  }
  
  @override
  Future<Order> getOrderById(String orderId) async {
    try {
      final response = await apiClient.get('$_ordersEndpoint/$orderId');
      if (response.statusCode == 200) {
        return _parseOrderFromJson(response.data as Map<String, dynamic>);
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Error fetching order $orderId: ${response.statusCode}',
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '$_ordersEndpoint/$orderId'),
        message: 'Unexpected error fetching order: $e',
      );
    }
  }
  
  @override
  Future<Order> createOrder(Order order) async {
    try {
      final response = await apiClient.post(
        _ordersEndpoint,
        data: _orderToJson(order),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return _parseOrderFromJson(response.data as Map<String, dynamic>);
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Error creating order: ${response.statusCode}',
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: _ordersEndpoint),
        message: 'Unexpected error creating order: $e',
      );
    }
  }
  
  @override
  Future<Order> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    try {
      final response = await apiClient.patch(
        '$_ordersEndpoint/$orderId',
        data: {'status': newStatus.name},
      );
      if (response.statusCode == 200) {
        return _parseOrderFromJson(response.data as Map<String, dynamic>);
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Error updating order status: ${response.statusCode}',
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '$_ordersEndpoint/$orderId'),
        message: 'Unexpected error updating order status: $e',
      );
    }
  }
  
  @override
  Future<void> deleteOrder(String orderId) async {
    try {
      final response = await apiClient.delete('$_ordersEndpoint/$orderId');
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Error deleting order: ${response.statusCode}',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '$_ordersEndpoint/$orderId'),
        message: 'Unexpected error deleting order: $e',
      );
    }
  }
  
  @override
  Future<List<Order>> getOrdersByUser(String userId) async {
    try {
      final response = await apiClient.get(
        _usersEndpoint,
        queryParameters: {'userId': userId},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return _parseOrderList(data);
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Error fetching orders by user: ${response.statusCode}',
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: _usersEndpoint),
        message: 'Unexpected error fetching orders by user: $e',
      );
    }
  }
  
  @override
  Future<List<Order>> getOrdersByStatus(OrderStatus status) async {
    try {
      final response = await apiClient.get(
        _ordersEndpoint,
        queryParameters: {'status': status.name},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return _parseOrderList(data);
      }
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Error fetching orders by status: ${response.statusCode}',
      );
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: _ordersEndpoint),
        message: 'Unexpected error fetching orders by status: $e',
      );
    }
  }
}

// === ARCHIVO: client/lib/data/repositories/order_repository_impl.dart ===
import 'package:dio/dio.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_datasource.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  
  OrderRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<List<Order>> getOrders({OrderFilter? filter}) async {
    try {
      if (filter != null) {
        if (filter.userId != null) {
          return await remoteDataSource.getOrdersByUser(filter.userId!);
        }
        if (filter.status != null) {
          return await remoteDataSource.getOrdersByStatus(filter.status!);
        }
        if (filter.fromDate != null || filter.toDate != null) {
          final allOrders = await remoteDataSource.getOrders();
          return _filterByDateRange(allOrders, filter.fromDate, filter.toDate);
        }
      }
      return await remoteDataSource.getOrders();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw OrderRepositoryException('Error fetching orders: $e');
    }
  }
  
  List<Order> _filterByDateRange(List<Order> orders, DateTime? fromDate, DateTime? toDate) {
    return orders.where((order) {
      if (fromDate != null && order.createdAt.isBefore(fromDate)) {
        return false;
      }
      if (toDate != null && order.createdAt.isAfter(toDate)) {
        return false;
      }
      return true;
    }).toList();
  }
  
  @override
  Future<Order> getOrderById(String orderId) async {
    try {
      return await remoteDataSource.getOrderById(orderId);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw OrderRepositoryException('Error fetching order by id: $e');
    }
  }
  
  @override
  Future<Order> createOrder(Order order) async {
    try {
      _validateOrder(order);
      return await remoteDataSource.createOrder(order);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw OrderRepositoryException('Error creating order: $e');
    }
  }
  
  void _validateOrder(Order order) {
    if (order.items.isEmpty) {
      throw OrderValidationException('Order must have at least one item');
    }
    if (order.userId.isEmpty) {
      throw OrderValidationException('Order must have a userId');
    }
    if (order.deliveryAddress.isEmpty) {
      throw OrderValidationException('Order must have a delivery address');
    }
    for (final item in order.items) {
      if (item.quantity <= 0) {
        throw OrderValidationException('Item quantity must be greater than zero');
      }
      if (item.unitPrice <= 0) {
        throw OrderValidationException('Item unit price must be greater than zero');
      }
    }
  }
  
  @override
  Future<Order> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    try {
      return await remoteDataSource.updateOrderStatus(orderId, newStatus);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw OrderRepositoryException('Error updating order status: $e');
    }
  }
  
  @override
  Future<void> deleteOrder(String orderId) async {
    try {
      await remoteDataSource.deleteOrder(orderId);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw OrderRepositoryException('Error deleting order: $e');
    }
  }
  
  @override
  Future<List<Order>> getOrdersByUser(String userId, {OrderFilter? filter}) async {
    try {
      var orders = await remoteDataSource.getOrdersByUser(userId);
      if (filter?.status != null) {
        orders = orders.where((o) => o.status == filter!.status).toList();
      }
      if (filter?.fromDate != null || filter?.toDate != null) {
        orders = _filterByDateRange(orders, filter?.fromDate, filter?.toDate);
      }
      return orders;
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw OrderRepositoryException('Error fetching orders by user: $e');
    }
  }
  
  @override
  Future<List<Order>> getOrdersByStatus(OrderStatus status, {OrderFilter? filter}) async {
    try {
      var orders = await remoteDataSource.getOrdersByStatus(status);
      if (filter?.fromDate != null || filter?.toDate != null) {
        orders = _filterByDateRange(orders, filter?.fromDate, filter?.toDate);
      }
      return orders;
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw OrderRepositoryException('Error fetching orders by status: $e');
    }
  }
  
  OrderRepositoryException _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return OrderRepositoryException('Connection timeout. Please check your internet connection.');
      case DioExceptionType.connectionError:
        return OrderRepositoryException('No internet connection. Please try again later.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return OrderRepositoryException('Order not found.');
        } else if (statusCode == 401) {
          return OrderRepositoryException('Unauthorized. Please log in again.');
        } else if (statusCode == 403) {
          return OrderRepositoryException('Access denied.');
        } else if (statusCode != null && statusCode >= 500) {
          return OrderRepositoryException('Server error. Please try again later.');
        }
        return OrderRepositoryException('Request failed with status: $statusCode');
      case DioExceptionType.cancel:
        return OrderRepositoryException('Request was cancelled.');
      default:
        return OrderRepositoryException('An unexpected error occurred: ${e.message}');
    }
  }
}

class OrderRepositoryException implements Exception {
  final String message;
  OrderRepositoryException(this.message);
  
  @override
  String toString() => message;
}

class OrderValidationException implements Exception {
  final String message;
  OrderValidationException(this.message);
  
  @override
  String toString() => message;
}

// === ARCHIVO: client/lib/presentation/screens/order_list_screen.dart ===
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/order.dart';
import '../viewmodels/order_viewmodel.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderViewModel>().loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Pedidos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
            tooltip: 'Filtrar pedidos',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<OrderViewModel>().loadOrders(),
            tooltip: 'Actualizar pedidos',
          ),
        ],
      ),
      body: Consumer<OrderViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.state.isLoading && viewModel.state.orders.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (viewModel.state.error != null && viewModel.state.orders.isEmpty) {
            return _buildErrorView(context, viewModel);
          }

          if (viewModel.state.orders.isEmpty) {
            return _buildEmptyView(context);
          }

          return RefreshIndicator(
            onRefresh: () async {
              await viewModel.loadOrders();
            },
            child: Column(
              children: [
                if (viewModel.state.filter != null) _buildFilterChip(context, viewModel),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: viewModel.state.orders.length,
                    itemBuilder: (context, index) {
                      final order = viewModel.state.orders[index];
                      return _OrderCard(
                        order: order,
                        onTap: () => _navigateToOrderDetail(context, order),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, OrderViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar pedidos',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              viewModel.state.error ?? 'Ha ocurrido un error desconocido',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => viewModel.loadOrders(),
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No tienes pedidos aún',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Cuandorealices un pedido, aparecerá aquí',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, OrderViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Chip(
            label: Text('Filtrado: ${viewModel.state.filter!.status?.name ?? "Todos"}'),
            deleteIcon: const Icon(Icons.close, size: 18),
            onDeleted: () => viewModel.clearFilter(),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _FilterBottomSheet(
        onFilterSelected: (status) {
          context.read<OrderViewModel>().filterByStatus(status);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _navigateToOrderDetail(BuildContext context, Order order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderDetailScreen(orderId: order.id),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;

  const _OrderCard({
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pedido #${order.id.substring(0, 8).toUpperCase()}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  _StatusBadge(status: order.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _formatDate(order.createdAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${order.items.length} ${order.items.length == 1 ? "producto" : "productos"}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    '\$${order.totalAmount.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      order.deliveryAddress,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hoy, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Ayer, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class _StatusBadge extends StatelessWidget {
  final OrderStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _getStatusColor(status).withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        _getStatusText(status),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: _getStatusColor(status),
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.preparing:
        return Colors.purple;
      case OrderStatus.shipped:
        return Colors.cyan;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pendiente';
      case OrderStatus.confirmed:
        return 'Confirmado';
      case OrderStatus.preparing:
        return 'Preparando';
      case OrderStatus.shipped:
        return 'Enviado';
      case OrderStatus.delivered:
        return 'Entregado';
      case OrderStatus.cancelled:
        return 'Cancelado';
    }
  }
}

class _FilterBottomSheet extends StatelessWidget {
  final void Function(OrderStatus?) onFilterSelected;

  const _FilterBottomSheet({required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filtrar por estado',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.all_inclusive),
              title: const Text('Todos'),
              onTap: () => onFilterSelected(null),
            ),
            ...OrderStatus.values.map(
              (status) => ListTile(
                leading: Icon(_getStatusIcon(status)),
                title: Text(_getStatusText(status)),
                onTap: () => onFilterSelected(status),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Icons.hourglass_empty;
      case OrderStatus.confirmed:
        return Icons.check_circle_outline;
      case OrderStatus.preparing:
        return Icons.inventory_2_outlined;
      case OrderStatus.shipped:
        return Icons.local_shipping_outlined;
      case OrderStatus.delivered:
        return Icons.task_alt;
      case OrderStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pendiente';
      case OrderStatus.confirmed:
        return 'Confirmado';
      case OrderStatus.preparing:
        return 'Preparando';
      case OrderStatus.shipped:
        return 'Enviado';
      case OrderStatus.delivered:
        return 'Entregado';
      case OrderStatus.cancelled:
        return 'Cancelado';
    }
  }
}

class OrderDetailScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido #${orderId.substring(0, 8).toUpperCase()}'),
      ),
      body: const Center(
        child: Text('Detalle del pedido'),
      ),
    );
  }
}

// === ARCHIVO: client/lib/presentation/viewmodels/order_viewmodel.dart ===
import 'package:flutter/foundation.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../../domain/usecases/get_orders.dart';

class OrderViewModel extends ChangeNotifier {
  final GetOrders _getOrdersUseCase;
  final OrderRepository _orderRepository;

  OrderViewModel({
    required GetOrders getOrdersUseCase,
    required OrderRepository orderRepository,
  })  : _getOrdersUseCase = getOrdersUseCase,
        _orderRepository = orderRepository;

  OrderListState _state = const OrderListState();
  OrderListState get state => _state;

  Future<void> loadOrders() async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final orders = await _getOrdersUseCase.call();
      _state = _state.copyWith(
        isLoading: false,
        orders: orders,
        error: null,
      );
    } on Exception catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: _mapExceptionToMessage(e),
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: 'Error inesperado al cargar los pedidos',
      );
    }

    notifyListeners();
  }

  Future<void> loadPendingOrders() async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final orders = await _getOrdersUseCase.getPendingOrders();
      _state = _state.copyWith(
        isLoading: false,
        orders: orders,
        error: null,
      );
    } on Exception catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: _mapExceptionToMessage(e),
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: 'Error inesperado al cargar los pedidos pendientes',
      );
    }

    notifyListeners();
  }

  Future<void> loadOrdersByUserId(String userId) async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final orders = await _getOrdersUseCase.getOrdersByUserId(userId);
      _state = _state.copyWith(
        isLoading: false,
        orders: orders,
        error: null,
      );
    } on Exception catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: _mapExceptionToMessage(e),
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: 'Error inesperado al cargar los pedidos del usuario',
      );
    }

    notifyListeners();
  }

  Future<void> filterByStatus(OrderStatus status) async {
    _state = _state.copyWith(
      isLoading: true,
      error: null,
      filter: OrderFilter(status: status),
    );
    notifyListeners();

    try {
      final orders = await _orderRepository.getOrdersByStatus(status);
      _state = _state.copyWith(
        isLoading: false,
        orders: orders,
        error: null,
      );
    } on Exception catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: _mapExceptionToMessage(e),
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: 'Error inesperado al filtrar los pedidos',
      );
    }

    notifyListeners();
  }

  Future<void> filterByUser(String userId) async {
    _state = _state.copyWith(
      isLoading: true,
      error: null,
      filter: OrderFilter(userId: userId),
    );
    notifyListeners();

    try {
      final orders = await _orderRepository.getOrdersByUser(userId);
      _state = _state.copyWith(
        isLoading: false,
        orders: orders,
        error: null,
      );
    } on Exception catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: _mapExceptionToMessage(e),
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: 'Error inesperado al filtrar los pedidos por usuario',
      );
    }

    notifyListeners();
  }

  void clearFilter() {
    _state = _state.copyWith(filter: null);
    notifyListeners();
    loadOrders();
  }

  Future<void> refreshOrders() async {
    await loadOrders();
  }

  String _mapExceptionToMessage(Exception e) {
    final errorMessage = e.toString().toLowerCase();
    
    if (errorMessage.contains('socketexception') || 
        errorMessage.contains('handshakeexception') ||
        errorMessage.contains('connection')) {
      return 'Error de conexión. Verifica tu conexión a internet.';
    }
    
    if (errorMessage.contains('timeout')) {
      return 'La solicitud ha tardado demasiado. Intenta de nuevo.';
    }
    
    if (errorMessage.contains('unauthorized') || 
        errorMessage.contains('401')) {
      return 'Sesión expirada. Inicia sesión nuevamente.';
    }
    
    if (errorMessage.contains('forbidden') || 
        errorMessage.contains('403')) {
      return 'No tienes permiso para realizar esta acción.';
    }
    
    if (errorMessage.contains('not found') || 
        errorMessage.contains('404')) {
      return 'El recurso solicitado no existe.';
    }
    
    if (errorMessage.contains('server') || 
        errorMessage.contains('500')) {
      return 'Error del servidor. Intenta más tarde.';
    }
    
    return 'Ha ocurrido un error. Por favor, intenta de nuevo.';
  }
}

class OrderListState {
  final bool isLoading;
  final List<Order> orders;
  final String? error;
  final OrderFilter? filter;

  const OrderListState({
    this.isLoading = false,
    this.orders = const [],
    this.error,
    this.filter,
  });

  OrderListState copyWith({
    bool? isLoading,
    List<Order>? orders,
    String? error,
    OrderFilter? filter,
    bool clearError = false,
    bool clearFilter = false,
  }) {
    return OrderListState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      error: clearError ? null : (error ?? this.error),
      filter: clearFilter ? null : (filter ?? this.filter),
    );
  }
}
```
