terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.22.1"
    }
  }
  backend "s3" {
    bucket       = "demo-terraform-backend-state"
    key          = "code_artifact/terraform.tfstate"
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
      Name        = "demo-codeartifact-tf"
      Environment = "dev"
      Terraform   = true
      Modules     = true
      Purpose     = "Demo CodeArtifact by Terraform Modules"
    }
  }
}