locals {
  vars                    = { for var_file in fileset(terraform.workspace, "*.tf.json") : trimsuffix(var_file, ".tf.json") => jsondecode(file("${terraform.workspace}/${var_file}")) }
  sharing_vars            = { for var_file in fileset("sharing", "*.tf.json") : trimsuffix(var_file, ".tf.json") => jsondecode(file("sharing/${var_file}")) }
  source_credential_token = data.terraform_remote_state.codeconnection.outputs.arn
  service_role_arn        = aws_iam_role.role.arn
  vpc_config_local = {
    vpc_id             = data.aws_vpc.demo_vpc.id
    subnets            = data.aws_subnets.subnets.ids
    security_group_ids = data.aws_security_groups.sgs.ids
  }
}