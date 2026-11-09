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