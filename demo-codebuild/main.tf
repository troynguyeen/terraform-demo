module "demo_codebuild" {
  source                      = "github.com/troynguyeen/terraform-module//codebuild"
  name                        = local.codebuild_name
  description                 = local.description
  service_role_arn            = aws_iam_role.role.arn
  build_timeout               = 5
  queued_timeout              = 5
  source_type                 = "GITHUB"
  source_location             = local.git_url
  environment_type            = "LINUX_CONTAINER"
  compute_type                = "BUILD_GENERAL1_SMALL"
  image                       = "aws/codebuild/amazonlinux-x86_64-standard:5.0"
  image_pull_credentials_type = "CODEBUILD"
  privileged_mode             = true
  environment_variables       = local.environment_variable_local
  artifacts                   = local.artifacts_local
  secondary_sources           = local.secondary_sources_local
  logs_config                 = local.logs_config_local
  vpc_config                  = local.vpc_config_local

  enable_source_credential      = true
  source_credential_server_type = "GITHUB"
  source_credential_auth_type   = "CODECONNECTIONS"
  source_credential_token       = "arn:aws:codeconnections:${var.region}:${data.aws_caller_identity.current.account_id}:connection/2b5d9d8f-f158-485a-84d3-d059c7bdccb3"

  enable_codebuild_webhook = true
  webhook_build_type       = "BUILD"
  filter_group             = local.filter_group_local

  tags = {
    Name = local.codebuild_name
  }
}

locals {
  codebuild_name = "demo-codebuild-tf"
  description    = "Demo CodeBuild by Terraform CI/CD"
  git_url        = "CODEBUILD_DEFAULT_WEBHOOK_SOURCE_LOCATION"
  environment_variable_local = [
    {
      name  = "SOME_KEY1"
      value = "SOME_VALUE1"
      type  = "PLAINTEXT"
    },
    {
      name  = "SOME_KEY2"
      value = "SOME_VALUE2"
      type  = "PARAMETER_STORE"
    }
  ]
  artifacts_local = {
    type     = "S3"
    location = aws_s3_bucket.artifacts.id
    path     = "Demo-Artifacts"
  }
  cache_local = {
    type     = "S3"
    location = "${aws_s3_bucket.artifacts.id}/Demo-Cache"
  }
  secondary_sources_local = [
    {
      source_identifier = "SecondarySource1"
      type              = "GITHUB"
      location          = "https://github.com/troynguyeen/demo-react-app.git"
    }
  ]
  logs_config_local = {
    cloudwatch_logs = {
      group_name = aws_cloudwatch_log_group.cw.name
      status     = "ENABLED"
    }
  }
  vpc_config_local = {
    vpc_id             = data.aws_vpc.demo_vpc.id
    subnets            = data.aws_subnets.subnets.ids
    security_group_ids = data.aws_security_groups.sgs.ids
  }
  filter_group_local = {
    filter = [
      {
        type    = "EVENT"
        pattern = "PUSH"
      },
      {
        type    = "EVENT"
        pattern = "WORKFLOW_JOB_QUEUED"
      },
      {
        type    = "EVENT"
        pattern = "PULL_REQUEST_CREATED"
      }
    ]
  }
}
