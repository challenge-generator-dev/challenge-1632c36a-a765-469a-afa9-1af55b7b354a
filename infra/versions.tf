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