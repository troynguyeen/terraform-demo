resource "aws_kms_key" "demo_kms" {
  description             = local.sharing_vars.common.codebuild_kms_description
  rotation_period_in_days = local.sharing_vars.common.rotation_period_in_days
  enable_key_rotation     = true

  tags = {
    Name = local.sharing_vars.common.codebuild_kms_name
  }
}

resource "aws_kms_key_policy" "demo_kms" {
  key_id = aws_kms_key.demo_kms.key_id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "demo-kms-policy"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
      {
        Sid    = "Allow use of the key"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        },
        Action = [
          "kms:DescribeKey",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyWithoutPlaintext"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_kms_alias" "alias_kms" {
  name          = "alias/${local.sharing_vars.common.codebuild_kms_name}"
  target_key_id = aws_kms_key.demo_kms.key_id
}
