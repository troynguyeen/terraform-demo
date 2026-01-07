terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.27.0"
    }
  }
  backend "s3" {
    bucket       = "demo-terraform-backend-state"
    key          = "code_connections/terraform.tfstate"
    region       = "ap-southeast-1"
    encrypt      = false
    use_lockfile = true
  }
}

provider "aws" {
  # Configuration options
  region = var.region
  default_tags {
    tags = {
      Name        = "demo-codeconnections-tf"
      Environment = "dev"
      Terraform   = true
      Modules     = true
      Purpose     = "Demo CodeConnections by Terraform CI/CD"
    }
  }
}