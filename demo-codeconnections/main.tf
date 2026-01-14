resource "aws_codeconnections_connection" "demo-githubconnection" {
  name          = var.name
  provider_type = var.provider_type
  tags = {
      Name = "Custom tag name"
  }
}
