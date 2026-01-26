module "demo-ci" {
  for_each                      = local.codebuilds
  source                        = "github.com/troynguyeen/terraform-module//codebuild"
  name                          = "${each.value.prod_name_prefix}-ci"
  description                   = each.value.description
  source_location               = each.value.source_location
  source_type                   = each.value.source_type
  enable_source_credential      = each.value.enable_source_credential
  source_credential_server_type = each.value.source_type
  source_credential_auth_type   = each.value.source_credential_auth_type
  environment_type              = each.value.environment_type
  compute_type                  = each.value.compute_type
  image                         = each.value.image
  image_pull_credentials_type   = each.value.image_pull_credentials_type
  environment_variables         = each.value.environment_variables
  artifacts                     = each.value.artifacts
  cache                         = each.value.cache
  logs_config                   = each.value.logs_config
  enable_codebuild_webhook      = each.value.enable_source_credential
  webhook_build_type            = each.value.webhook_build_type
  filter_group                  = each.value.filter_group
  scope_configuration           = each.value.scope_configuration
  service_role_arn              = local.service_role_arn
  source_credential_token       = local.source_credential_token
  vpc_config                    = local.vpc_config

  tags = {
    Name = "${each.value.prod_name_prefix}-ci"
  }
}

module "demo-cd" {
  for_each                      = local.codebuilds
  source                        = "github.com/troynguyeen/terraform-module//codebuild"
  name                          = "${each.value.prod_name_prefix}-cd"
  description                   = each.value.description
  source_location               = each.value.source_location
  source_type                   = each.value.source_type
  enable_source_credential      = each.value.enable_source_credential
  source_credential_server_type = each.value.source_type
  source_credential_auth_type   = each.value.source_credential_auth_type
  environment_type              = each.value.environment_type
  compute_type                  = each.value.compute_type
  image                         = each.value.image
  image_pull_credentials_type   = each.value.image_pull_credentials_type
  environment_variables         = each.value.environment_variables
  artifacts                     = each.value.artifacts
  cache                         = each.value.cache
  logs_config                   = each.value.logs_config
  enable_codebuild_webhook      = each.value.enable_source_credential
  webhook_build_type            = each.value.webhook_build_type
  filter_group                  = each.value.filter_group
  scope_configuration           = each.value.scope_configuration
  service_role_arn              = local.service_role_arn
  source_credential_token       = local.source_credential_token
  vpc_config                    = local.vpc_config

  tags = {
    Name = "${each.value.prod_name_prefix}-cd"
  }
}

locals {
  codebuilds = lookup(local.vars.codebuild, "organization", null) == terraform.workspace ? local.vars : {}
}