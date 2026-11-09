terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
  required_version = ">= 1.7.5"
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = var.owner_team
    }
  }

  skip_credentials_validation = false
  skip_requesting_account_id  = false
  skip_metadata_api_check     = true
  s3_use_path_style           = false

  endpoints {
    apigateway     = "https://apigateway.${var.aws_region}.amazonaws.com"
    ec2            = "https://ec2.${var.aws_region}.amazonaws.com"
    ecs            = "https://ecs.${var.aws_region}.amazonaws.com"
    elasticloadbalancing = "https://elasticloadbalancing.${var.aws_region}.amazonaws.com"
    rds            = "https://rds.${var.aws_region}.amazonaws.com"
    s3             = "https://s3.${var.aws_region}.amazonaws.com"
    iam            = "https://iam.${var.aws_region}.amazonaws.com"
  }

  dynamic "assume_role" {
    for_each = var.enable_cross_account_role ? [1] : []
    content {
      role_arn = "arn:aws:iam::${var.cross_account_id}:role/${var.cross_account_role_name}"
    }
  }

  ignore_tags {
    keys = ["aws:cloudformation:stack-id", "aws:cloudformation:stack-name"]
  }
}

provider "random" {
  version = "3.6.0"
}

provider "template" {
  version = "2.2.0"
}