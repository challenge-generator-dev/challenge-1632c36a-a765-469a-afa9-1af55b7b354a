# Módulo de Infraestructura - App de Pedidos

## Descripción General

Este módulo de Terraform aprovisiona la infraestructura completa necesaria para desplegar la API de la aplicación móvil de pedidos en AWS. La arquitectura utiliza servicios gestionados de AWS para garantizar alta disponibilidad, escalabilidad y seguridad.

## Arquitectura Desplegada

La infraestructura incluye los siguientes componentes:

- **VPC**: Red virtual privada con subredes públicas y privadas en múltiples zonas de disponibilidad.
- **Application Load Balancer**: Balanceador de carga que distribuye tráfico HTTP/HTTPS a los servicios.
- **ECS Fargate**: Servicio de contenedores serverless para ejecutar la API.
- **RDS PostgreSQL**: Base de datos relacional gestionada para persistencia de pedidos.
- **API Gateway**: Puerta de enlace API REST para exposición de endpoints.
- **Security Groups**: Grupos de seguridad para controlar el tráfico entre componentes.
- **IAM Roles**: Roles y políticas para permisos de servicios.

## Endpoints de la API

La API expone los siguientes endpoints para la aplicación móvil:

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | /orders | Lista todos los pedidos del usuario |
| POST | /orders | Crea un nuevo pedido |
| GET | /orders/{id} | Obtiene un pedido específico |
| PUT | /orders/{id} | Actualiza un pedido existente |
| DELETE | /orders/{id} | Cancela un pedido |

La URL base de la API se configura mediante la variable `api_gateway_endpoint` y sigue el formato:
```
https://{api_gateway_id}.execute-api.{region}.amazonaws.com/{stage}
```

## Uso del Módulo

### Configuración Básica

```hcl
module "infra" {
  source = "./infra"

  aws_region   = "us-east-1"
  project_name = "pedidos-app"
  environment  = "prod"

  vpc_cidr               = "10.0.0.0/16"
  availability_zones     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  ecs_desired_count      = 3
  db_instance_class      = "db.t3.small"
  db_allocated_storage   = 30

  common_tags = {
    Owner     = "team-platform"
    CostCenter = "pedidos-app-prod"
  }
}
```

### Validación Local

Para validar la configuración antes de aplicar los cambios:

```bash
cd infra
terraform init
terraform validate
terraform plan -out=tfplan
```

Para aplicar los cambios:

```bash
terraform apply tfplan
```

### Limpieza de Recursos

Para destruir todos los recursos aprovisionados:

```bash
terraform destroy
```

**Advertencia**: Esta operación elimina todos los recursos creados. Asegúrate de tener backups de la base de datos si es necesario.

## Variables Principales

| Variable | Tipo | Default | Descripción |
|----------|------|---------|-------------|
| aws_region | string | us-east-1 | Región de AWS |
| project_name | string | pedidos-app | Nombre del proyecto |
| environment | string | dev | Entorno (dev/staging/prod) |
| vpc_cidr | string | 10.0.0.0/16 | CIDR de la VPC |
| ecs_desired_count | number | 2 | Número de tareas ECS |
| db_instance_class | string | db.t3.micro | Clase de RDS |

## Outputs del Módulo

Los outputs disponibles permiten integrar con otros módulos o pipelines:

- `api_gateway_endpoint`: URL base del API Gateway
- `ecs_cluster_name`: Nombre del cluster ECS
- `rds_endpoint`: Endpoint de la base de datos RDS
- `vpc_id`: ID de la VPC creada
- `alb_dns_name`: DNS del Application Load Balancer

## Consideraciones de Seguridad

- Los grupos de seguridad restringen el tráfico entre componentes
- Las credenciales de base de datos se almacenan en AWS Secrets Manager
- El acceso a la API se controla mediante API Gateway y IAM
- Los logs se almacenan en CloudWatch para auditoría
- Las comunicaciones entre servicios usan TLS

## Costos Estimados

El costo mensual aproximado para un entorno de producción con la configuración por defecto es:

- VPC: $0
- ALB: $25/mes
- ECS Fargate: $50-150/mes según uso
- RDS PostgreSQL: $50-100/mes
- API Gateway: $3.50 por millón de requests
- Data Transfer: $10-30/mes

## Mantenimiento

- Actualizar versiones de providers en `versions.tf`
- Revisar logs en CloudWatch periódicamente
- Monitorear costos en AWS Cost Explorer
- Realizar backups automáticos de RDS configurados