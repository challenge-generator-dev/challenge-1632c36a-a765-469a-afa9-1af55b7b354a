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