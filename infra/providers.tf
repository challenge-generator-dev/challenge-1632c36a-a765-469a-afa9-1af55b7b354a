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