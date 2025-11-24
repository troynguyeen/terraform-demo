module "codeartifact" {
  source = "github.com/catalystcommunity/terraform-aws-codeartifact"

  enable_codeartifact_domain_kms_key = true
  codeartifact_domain_name           = "domain-tf"
  codeartifact_repositories          = var.my_repos
}