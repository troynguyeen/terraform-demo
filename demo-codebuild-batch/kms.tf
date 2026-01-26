resource "aws_kms_key" "demo_kms" {
  description             = local.sharing_vars.common.codebuild_kms_description
  rotation_period_in_days = local.sharing_vars.common.rotation_period_in_days
  enable_key_rotation     = true

  tags = {
    Name = local.sharing_vars.common.codebuild_kms_name
  }
}

resource "aws_kms_alias" "alias_kms" {
  name          = "alias/${local.sharing_vars.common.codebuild_kms_name}"
  target_key_id = aws_kms_key.demo_kms.key_id
}