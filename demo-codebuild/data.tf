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
    values = ["caching-sg"]
  }
}

data "aws_caller_identity" "current" {}