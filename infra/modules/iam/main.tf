# =============================================================================
# Módulo IAM - Superficie de práctica
# =============================================================================
# El candidato debe implementar:
# - Roles IAM para ECS (tarea y servicio)
# - Roles IAM para Lambda
# - Políticas inline o gestionadas
# - Attach de políticas a roles
# =============================================================================

# -----------------------------------------------------------------------------
# Variables de entrada
# -----------------------------------------------------------------------------

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetado"
  type        = string
}

variable "account_id" {
  description = "ID de la cuenta de AWS"
  type        = string
}

variable "region" {
  description = "Región de AWS"
  type        = string
}

# -----------------------------------------------------------------------------
# Recursos IAM
# -----------------------------------------------------------------------------

# TODO: Implementar rol IAM para tarea ECS
# Este rol será asumido por las tareas de ECS que ejecutan los contenedores
# Recursos esperados: aws_iam_role.ecs_task_execution

# TODO: Implementar política de ejecución de tareas ECS
# Permisos necesarios: ECR, CloudWatch Logs, Secrets Manager
# Recurso esperado: aws_iam_policy.ecs_task_execution_policy

# TODO: Implementar rol IAM para servicio ECS
# Este rol permite que el servicio ECS interactúe con ALB y otros servicios
# Recurso esperado: aws_iam_role.ecs_service_role

# TODO: Implementar rol IAM para Lambda
# Rol de ejecución para funciones Lambda
# Recurso esperado: aws_iam_role.lambda_exec_role

# TODO: Implementar política de acceso a recursos para Lambda
# Permisos: logs, secrets, sqs, dynamodb
# Recurso esperado: aws_iam_policy.lambda_resource_policy

# TODO: Implementar perfil de instancia EC2 para ECS (si aplica)
# Recurso esperado: aws_iam_instance_profile.ecs_instance_profile

# -----------------------------------------------------------------------------
# Outputs
# -----------------------------------------------------------------------------

output "ecs_task_execution_role_arn" {
  description = "ARN del rol de ejecución de tareas ECS"
  value       = aws_iam_role.ecs_task_execution.arn
}

output "ecs_service_role_arn" {
  description = "ARN del rol de servicio ECS"
  value       = aws_iam_role.ecs_service.arn
}

output "lambda_exec_role_arn" {
  description = "ARN del rol de ejecución de Lambda"
  value       = aws_iam_role.lambda_exec.arn
}