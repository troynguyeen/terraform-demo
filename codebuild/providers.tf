terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.27.0"
    }
  }
  backend "s3" {
    bucket       = "demo-terraform-backend-state"
    key          = "code_build/terraform.tfstate"
    region       = "ap-southeast-1"
    encrypt      = false
    use_lockfile = true
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = terraform.workspace
      Region      = var.region
      ManagedBy   = "Terraform"
      Purpose     = local.description
    }
  }
}