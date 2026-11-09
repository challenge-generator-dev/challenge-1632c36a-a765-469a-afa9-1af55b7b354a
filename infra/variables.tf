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