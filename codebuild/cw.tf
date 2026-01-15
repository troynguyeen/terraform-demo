resource "aws_cloudwatch_log_group" "cw" {
  name_prefix = "/aws/codebuild/${local.cw_name}"
  tags = {
    Name = local.cw_name
  }
}

locals {
  cw_name = "codebuild-cw-logs"
}