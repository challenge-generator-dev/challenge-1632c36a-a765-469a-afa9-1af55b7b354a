# ===========================================
# Configuración General del Proyecto
# ===========================================
project_name   = "pedidos-app"
environment    = "dev"
aws_region     = "us-east-1"
owner_team     = "plataforma"

# ===========================================
# Configuración de Red (VPC)
# ===========================================
vpc_cidr_block           = "10.0.0.0/16"
availability_zones       = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs     = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]
database_subnet_cidrs    = ["10.0.20.0/24", "10.0.21.0/24", "10.0.22.0/24"]
enable_nat_gateway       = true
single_nat_gateway       = false
enable_vpn_gateway       = false
enable_dns_hostnames     = true
enable_dns_support       = true

# ===========================================
# Configuración de RDS (PostgreSQL)
# ===========================================
rds_instance_class       = "db.t3.micro"
rds_allocated_storage    = 20
rds_storage_type         = "gp3"
rds_engine_version       = "15.4"
rds_database_name        = "pedidos_db"
rds_username             = "dbadmin"
multi_az                 = false
backup_retention_days    = 7
deletion_protection      = false
skip_final_snapshot      = true

# ===========================================
# Configuración de ECS
# ===========================================
ecs_cluster_name          = "pedidos-cluster"
ecs_cluster_capacity_providers = ["FARGATE", "FARGATE_SPOT"]
ecs_default_capacity_provider_strategy = {
  weight = 100
  base   = 1
}
container_image          = "pedidos-api:latest"
container_port           = 8080
container_cpu            = 256
container_memory         = 512
autoscaling_min_capacity = 1
autoscaling_max_capacity = 4
autoscaling_target_cpu   = 70
health_check_grace_period = 60

# ===========================================
# Configuración de API Gateway
# ===========================================
api_gateway_name         = "pedidos-api-gateway"
api_gateway_stage        = "prod"
api_gateway_description  = "API Gateway para la API de pedidos de la app móvil"
enable_api_gateway_logs  = true
api_gateway_throttling_rate_limit  = 100
api_gateway_throttling_burst_limit = 200
cache_enabled            = false

# ===========================================
# Configuración de Application Load Balancer
# ===========================================
alb_name                 = "pedidos-alb"
alb_type                 = "application"
alb_internal             = false
alb_idle_timeout         = 60
enable_deletion_protection = false
access_logs_bucket       = ""
alb_ssl_certificate_arn  = ""
alb_ssl_policy           = "ELBSecurityPolicy-2016-08"

# ===========================================
# Configuración de Security Groups
# ===========================================
allowed_cidr_blocks      = ["0.0.0.0/0"]
allowed_ips_dev          = ["10.0.0.0/8"]
alb_port                 = 443
ecs_task_port            = 8080
rds_port                 = 5432
rds_allowed_cidr         = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]

# ===========================================
# Configuración de IAM
# ===========================================
iam_role_path            = "/pedidos-app/"
iam_force_detach_policy  = true
permissions_boundary     = ""

# ===========================================
# Configuración de S3 para Terraform State
# ===========================================
terraform_state_bucket   = "pedidos-terraform-state"
enable_versioning        = true
enable_server_side_encryption = true
dynamodb_table           = "terraform-locks"

# ===========================================
# Configuración de Tags
# ===========================================
common_tags = {
  Project     = "pedidos-app"
  Environment = "dev"
  ManagedBy   = "Terraform"
  Owner       = "plataforma"
  CostCenter  = "engineering"
  Compliance  = "standard"
}

# ===========================================
# Configuración de Cross-Account (opcional)
# ===========================================
enable_cross_account_role = false
cross_account_id          = ""
cross_account_role_name  = ""

# ===========================================
# Configuración de Monitoreo
# ===========================================
enable_cloudwatch_logs   = true
log_retention_days       = 30
enable_cloudwatch_alarms = true
alarm_email              = "alerts@empresa.com"

# ===========================================
# Configuración de DNS (Route53)
# ===========================================
enable_route53           = false
route53_zone_name        = "pedidos.empresa.com"
route53_record_name      = "api"

# ===========================================
# Configuración de WAF (Web Application Firewall)
# ===========================================
enable_waf               = false
waf_rules = {
  sqli_protection    = true
  xss_protection    = true
  rate_limiting      = true
  rate_limit         = 2000
  geo_restriction    = false
  allowed_countries  = []
}