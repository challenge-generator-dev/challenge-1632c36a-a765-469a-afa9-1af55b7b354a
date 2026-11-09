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