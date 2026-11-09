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