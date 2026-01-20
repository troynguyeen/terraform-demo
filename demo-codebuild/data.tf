data "aws_caller_identity" "current" {}
data "aws_vpc" "demo_vpc" {
  filter {
    name   = "tag:Name"
    values = ["demo-vpc"]
  }
}

data "aws_subnets" "subnets" {
  filter {
    name   = "tag:Tier"
    values = ["Public"]
  }
}

data "aws_security_groups" "sgs" {
  filter {
    name   = "tag:Name"
    values = ["CodeBuild-SecurityGroup"]
  }
}

data "terraform_remote_state" "codeconnection" {
  backend = "s3"

  config = {
    bucket = "sympli-tf"
    key    = "env:/${terraform.workspace}/code_connections/terraform.tfstate"
    region = "ap-southeast-1"
  }
}
