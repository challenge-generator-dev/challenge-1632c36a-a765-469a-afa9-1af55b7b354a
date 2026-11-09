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