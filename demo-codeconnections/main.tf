resource "aws_codeconnections_connection" "demo-githubconnection" {
  name          = var.name
  provider_type = var.provider
}