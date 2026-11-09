# Configuración de VPC para la infraestructura de la app de pedidos
# Este módulo crea la red virtual donde vivirán todos los recursos

# VPC principal con CIDR block privado
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.project}-vpc"
    Environment = var.environment
    Project     = var.project
  }
}

# Subredes públicas para el ALB y servicios expuestos
resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project}-public-subnet-${count.index + 1}"
    Environment = var.environment
    Project     = var.project
    Type        = "public"
  }
}

# Subredes privadas para ECS y RDS
resource "aws_subnet" "private" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + length(var.availability_zones))
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name        = "${var.project}-private-subnet-${count.index + 1}"
    Environment = var.environment
    Project     = var.project
    Type        = "private"
  }
}

# Internet Gateway para conectividad pública
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project}-igw"
    Environment = var.environment
    Project     = var.project
  }
}

# Tabla de rutas para subredes públicas
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.project}-public-rt"
    Environment = var.environment
    Project     = var.project
  }
}

# Asociación de subredes públicas con tabla de rutas
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# NAT Gateway para conectividad saliente desde subredes privadas
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "${var.project}-nat-eip"
    Environment = var.environment
    Project     = var.project
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name        = "${var.project}-nat-gw"
    Environment = var.environment
    Project     = var.project
  }
}

# Tabla de rutas para subredes privadas (salida por NAT)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name        = "${var.project}-private-rt"
    Environment = var.environment
    Project     = var.project
  }
}

# Asociación de subredes privadas con tabla de rutas
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}