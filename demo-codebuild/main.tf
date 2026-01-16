resource "aws_codebuild_project" "demo-codebuild" {
  name           = local.codebuild_name
  description    = local.description
  build_timeout  = 5
  queued_timeout = 5

  service_role = aws_iam_role.role.arn

  artifacts {
    type     = "S3"
    location = aws_s3_bucket.artifacts.id
    path     = "Demo-Artifacts"
  }

  cache {
    type     = "S3"
    location = "${aws_s3_bucket.artifacts.id}/Demo-Cache"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
    }

    environment_variable {
      name  = "SOME_KEY2"
      value = "SOME_VALUE2"
      type  = "PARAMETER_STORE"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.cw.name
      status     = "ENABLED"
    }
  }

  source {
    type                = "GITHUB"
    location            = local.git_url
    report_build_status = true
    auth {
      type     = "CODECONNECTIONS"
      resource = "arn:aws:codeconnections:${var.region}:${data.aws_caller_identity.current.account_id}:connection/2b5d9d8f-f158-485a-84d3-d059c7bdccb3"
    }
  }

  vpc_config {
    vpc_id             = data.aws_vpc.demo_vpc.id
    subnets            = data.aws_subnets.subnets.ids
    security_group_ids = data.aws_security_groups.sgs.ids
  }

  depends_on = [aws_iam_role.role]

  tags = {
    Name = local.codebuild_name
  }
}

locals {
  codebuild_name = "demo-codebuild-tf"
  description    = "Demo CodeBuild by Terraform CI/CD"
  git_url        = "https://github.com/troynguyeen/terraform-demo.git"
}