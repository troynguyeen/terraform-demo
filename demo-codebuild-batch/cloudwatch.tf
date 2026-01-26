resource "aws_cloudwatch_log_group" "demo-ci-log" {
  for_each                    = local.logs
  name                        = "/aws/codebuild/${each.value.prod_name_prefix}-ci"
  retention_in_days           = each.value.logs_config.cloudwatch_logs.retention_in_days
  deletion_protection_enabled = true
  kms_key_id                  = aws_kms_key.demo_kms.id

  tags = {
    Name = "/aws/codebuild/${each.value.prod_name_prefix}-ci"
  }
}

resource "aws_cloudwatch_log_group" "demo-cd-log" {
  for_each                    = local.logs
  name                        = "/aws/codebuild/${each.value.prod_name_prefix}-cd"
  retention_in_days           = each.value.logs_config.cloudwatch_logs.retention_in_days
  deletion_protection_enabled = true
  kms_key_id                  = aws_kms_key.demo_kms.id

  tags = {
    Name = "/aws/codebuild/${each.value.prod_name_prefix}-cd"
  }
}

locals {
  logs = lookup(local.vars.codebuild, "organization", "") == terraform.workspace ? local.vars : {}
}