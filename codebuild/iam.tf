data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = local.codebuild_role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy" "inline" {
  for_each = local.inline_policy_statements
  name     = each.key
  role     = aws_iam_role.role.id
  policy   = data.aws_iam_policy_document.inline.json
}

data "aws_iam_policy_document" "inline" {
  for_each = local.inline_policy_statements
  dynamic "statement" {
    for_each = each.value
    content {
      sid       = statement.value.sid
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources
      dynamic "condition" {
        for_each = lookup(statement.value, "condition", [])
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

locals {
  codebuild_role_name = "demo-codebuild-role"
  inline_policy_statements = {
    Networking = [
      {
        sid    = "AllowNetworkingAccess"
        effect = "Allow"
        actions = [
          "ec2:DescribeNetworkInterfaces",
          "ec2:CreateNetworkInterface",
          "ec2:CreateNetworkInterfacePermission",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeVpcs",
        ]
        resources = ["*"]
      }
    ]
    S3StateFile = [
      {
        sid    = "AllowS3StateFileAccess"
        effect = "Allow"
        actions = [
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        resources = [
          "arn:aws:s3:::demo-terraform-backend-state/*.tflock",
        ]
      }
    ]
    S3Artifacts = [
      {
        sid    = "AllowS3ArtifactsAccess"
        effect = "Allow"
        actions = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
        ]
        resources = [
          aws_s3_bucket.artifacts.arn,
          "${aws_s3_bucket.artifacts.arn}/*"
        ]
      }
    ]
    Logs = [
      {
        sid    = "AllowLogsAccess"
        effect = "Allow"
        actions = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ]
        resources = [
          "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/*"
        ]
      }
    ]
    ECR = [
      {
        sid    = "AllowECRAccess"
        effect = "Allow"
        actions = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
        ]
        resources = ["*"]
      }
    ]
    CodeArtifact = [
      {
        sid    = "AllowCodeArtifactAccess"
        effect = "Allow"
        actions = [
          "codeartifact:GetAuthorizationToken",
          "codeartifact:GetRepositoryEndpoint",
          "codeartifact:ReadFromRepository",
        ]
        resources = ["*"]
      },
      {
        effect = "Allow"
        actions = [
          "sts:GetServiceBearerToken",
        ]
        resources = ["*"]
        condition = {
          test     = "StringEquals"
          variable = "sts:AWSServiceName"
          values   = ["codeartifact.amazonaws.com"]
        }
      }
    ]
    # CodeConnections = [
    #   {
    #     sid    = "AllowCodeConnectionsAccess"
    #     effect = "Allow"
    #     actions = [
    #       "codeconnections:GetConnectionToken",
    #       "codeconnections:GetConnection"
    #     ]
    #     resources = [
    #         "arn:aws:codeconnections:${var.region}:${data.aws_caller_identity.current.account_id}:connection/*"
    #     ]
    #   }
    # ]
    KMS = [
      {
        sid    = "AllowKMSAccess"
        effect = "Allow"
        actions = [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:GenerateDataKey",
        ]
        resources = ["*"]
      }
    ]
    Secrets = [
      {
        sid    = "AllowSecretsManagerAccess"
        effect = "Allow"
        actions = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
        ]
        resources = ["*"]
      },
      {
        sid    = "AllowSSMParameterStoreAccess"
        effect = "Allow"
        actions = [
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:DescribeParameters",
          "ssm:GetParametersByPath"
        ]
        resources = ["*"]
      }
    ]
    CICD = [
      {
        sid    = "AllowCICDAccess"
        effect = "Allow"
        actions = [
          "codebuild:CreateReportGroup",
          "codebuild:CreateReport",
          "codebuild:UpdateReport",
          "codebuild:BatchPutTestCases"
        ]
        resources = [
          "arn:aws:codebuild:${var.region}:${data.aws_caller_identity.current.account_id}:report-group/*"
        ]
      }
    ]
  }
}