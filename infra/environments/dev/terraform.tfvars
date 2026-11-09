# =============================================================================
# Variables de configuración para el entorno de desarrollo
# =============================================================================
# Este archivo define los valores específicos del ambiente dev
# que Terraform utilizará al ejecutar plan y apply

# -----------------------------------------------------------------------------
# Configuración de AWS
# -----------------------------------------------------------------------------
aws_region = "us-east-1"

# -----------------------------------------------------------------------------
# Configuración de red (VPC y subnets)
# -----------------------------------------------------------------------------
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]

# -----------------------------------------------------------------------------
# Configuración de base de datos RDS PostgreSQL
# -----------------------------------------------------------------------------
db_instance_class    = "db.t3.micro"
db_allocated_storage = 20
db_engine_version    = "15.4"
db_name              = "pedidos_db"
db_username          = "dbadmin"
# NOTA: En producción, usar AWS Secrets Manager para la contraseña
db_password          = "DevPassword2024!"
db_multi_az          = false

# -----------------------------------------------------------------------------
# Configuración de ECS Cluster
# -----------------------------------------------------------------------------
ecs_cluster_name           = "pedidos-app-cluster"
ecs_cluster_instance_type  = "t3.medium"
ecs_cluster_desired_capacity = 2
ecs_cluster_min_size        = 1
ecs_cluster_max_size        = 4

# -----------------------------------------------------------------------------
# Configuración de API Gateway
# -----------------------------------------------------------------------------
api_gateway_stage_name = "dev"
api_gateway_rest_api_name = "pedidos-api"

# -----------------------------------------------------------------------------
# Configuración de Application Load Balancer
# -----------------------------------------------------------------------------
alb_name               = "pedidos-alb"
alb_internal          = false
alb_enable_deletion_protection = false

# -----------------------------------------------------------------------------
# Configuración de servicios y puertos
# -----------------------------------------------------------------------------
app_port           = 8080
db_port            = 5432
alb_listener_port = 80

# -----------------------------------------------------------------------------
# Configuración de seguridad
# -----------------------------------------------------------------------------
allowed_cidr_blocks = ["0.0.0.0/0"]
# En producción, restringir a los rangos de IP de la VPC o CloudFront

# -----------------------------------------------------------------------------
# Etiquetas obligatorias para todas las recursos
# -----------------------------------------------------------------------------
environment = "dev"
project     = "pedidos-app"
owner       = "devops-team"

# -----------------------------------------------------------------------------
# Configuración de Terraform Cloud (opcional)
# -----------------------------------------------------------------------------
# Descomentar si se usa Terraform Cloud en lugar de S3
# terraform_cloud_organization = "mi-organizacion"
# terraform_cloud_workspace    = "pedidos-app-dev"

# -----------------------------------------------------------------------------
# Configuración de logs
# -----------------------------------------------------------------------------
enable_cloudwatch_logs     = true
log_retention_days         = 7

# -----------------------------------------------------------------------------
# Configuración de backup de base de datos
# -----------------------------------------------------------------------------
db_backup_retention_days = 1
db_skip_final_snapshot   = true

# -----------------------------------------------------------------------------
# Configuración de auto-scaling
# -----------------------------------------------------------------------------
autoscaling_enabled           = true
autoscaling_target_cpu_utilization = 70
autoscaling_target_memory_utilization = 80

# -----------------------------------------------------------------------------
# URLs y endpoints (referencias para otras configuraciones)
# -----------------------------------------------------------------------------
# Estos valores se completan automáticamente con los outputs de los módulos
# api_gateway_endpoint = "https://{api_gateway_id}.execute-api.us-east-1.amazonaws.com/dev"
# ecs_cluster_arn      = "arn:aws:ecs:us-east-1:{account}:cluster/pedidos-app-cluster"
# rds_endpoint        = "pedidos-db.xxxxx.us-east-1.rds.amazonaws.com:5432"