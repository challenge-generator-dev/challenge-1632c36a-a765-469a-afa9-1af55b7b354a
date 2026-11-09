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