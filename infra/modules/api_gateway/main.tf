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