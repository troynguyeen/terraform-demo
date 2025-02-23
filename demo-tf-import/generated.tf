# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "6d327d68-d746-4948-b20b-8113fd4f5c02"
resource "aws_kms_key" "demo_eks_kms_key" {
  bypass_policy_lockout_safety_check = null
  custom_key_store_id                = null
  customer_master_key_spec           = "SYMMETRIC_DEFAULT"
  deletion_window_in_days            = null
  description                        = "education-eks-llKeClyy cluster encryption key"
  enable_key_rotation                = true
  is_enabled                         = true
  key_usage                          = "ENCRYPT_DECRYPT"
  multi_region                       = false
  policy = jsonencode({
    Statement = [{
      Action = "kms:*"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::381492178574:root"
      }
      Resource = "*"
      Sid      = "Default"
      }, {
      Action = ["kms:Update*", "kms:UntagResource", "kms:TagResource", "kms:ScheduleKeyDeletion", "kms:Revoke*", "kms:ReplicateKey", "kms:Put*", "kms:List*", "kms:ImportKeyMaterial", "kms:Get*", "kms:Enable*", "kms:Disable*", "kms:Describe*", "kms:Delete*", "kms:Create*", "kms:CancelKeyDeletion"]
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::381492178574:user/eks-admin"
      }
      Resource = "*"
      Sid      = "KeyAdministration"
      }, {
      Action = ["kms:ReEncrypt*", "kms:GenerateDataKey*", "kms:Encrypt", "kms:DescribeKey", "kms:Decrypt"]
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::381492178574:role/education-eks-llKeClyy-cluster-20250223005056361700000002"
      }
      Resource = "*"
      Sid      = "KeyUsage"
    }]
    Version = "2012-10-17"
  })
  rotation_period_in_days = 365
  tags = {
    terraform-aws-modules = "eks"
  }
  tags_all = {
    terraform-aws-modules = "eks"
  }
  xks_key_id = null
}

# __generated__ by Terraform from "education-eks-llKeClyy"
resource "aws_eks_cluster" "demo_eks" {
  bootstrap_self_managed_addons = false
  enabled_cluster_log_types     = ["api", "audit", "authenticator"]
  name                          = "education-eks-llKeClyy"
  role_arn                      = "arn:aws:iam::381492178574:role/education-eks-llKeClyy-cluster-20250223005056361700000002"
  tags = {
    terraform-aws-modules = "eks"
  }
  tags_all = {
    terraform-aws-modules = "eks"
  }
  version = "1.29"
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = "arn:aws:kms:ap-southeast-1:381492178574:key/6d327d68-d746-4948-b20b-8113fd4f5c02"
    }
  }
  kubernetes_network_config {
    ip_family         = "ipv4"
    service_ipv4_cidr = "172.20.0.0/16"
    elastic_load_balancing {
      enabled = false
    }
  }
  upgrade_policy {
    support_type = "EXTENDED"
  }
  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    security_group_ids      = ["sg-0c11885785f86015e"]
    subnet_ids              = ["subnet-016c17a76496c35ea", "subnet-0928afb060f4e1ba4", "subnet-0c9d9ba8bd72b5cb4"]
  }
}

# __generated__ by Terraform
resource "aws_eks_node_group" "demo_node_group_1" {
  ami_type               = "AL2_x86_64"
  capacity_type          = "ON_DEMAND"
  cluster_name           = "education-eks-llKeClyy"
  disk_size              = 0
  force_update_version   = null
  instance_types         = ["t3.small"]
  labels                 = {}
  node_group_name        = "node-group-1-20250223010022159300000018"
  node_role_arn          = "arn:aws:iam::381492178574:role/node-group-1-eks-node-group-20250223005056366800000003"
  release_version        = "1.29.13-20250212"
  subnet_ids             = ["subnet-016c17a76496c35ea", "subnet-0928afb060f4e1ba4", "subnet-0c9d9ba8bd72b5cb4"]
  tags = {
    Name = "node-group-1"
  }
  tags_all = {
    Name = "node-group-1"
  }
  version = "1.29"
  launch_template {
    id      = "lt-0e28e245ef2e558d3"
    version = "1"
  }
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
  update_config {
    max_unavailable_percentage = 33
  }
}

# __generated__ by Terraform
resource "aws_eks_node_group" "demo_node_group_2" {
  ami_type               = "AL2_x86_64"
  capacity_type          = "ON_DEMAND"
  cluster_name           = "education-eks-llKeClyy"
  disk_size              = 0
  force_update_version   = null
  instance_types         = ["t3.small"]
  labels                 = {}
  node_group_name        = "node-group-2-2025022301002216220000001a"
  node_role_arn          = "arn:aws:iam::381492178574:role/node-group-2-eks-node-group-20250223005056356200000001"
  release_version        = "1.29.13-20250212"
  subnet_ids             = ["subnet-016c17a76496c35ea", "subnet-0928afb060f4e1ba4", "subnet-0c9d9ba8bd72b5cb4"]
  tags = {
    Name = "node-group-2"
  }
  tags_all = {
    Name = "node-group-2"
  }
  version = "1.29"
  launch_template {
    id      = "lt-0aecad84a31e0e755"
    version = "1"
  }
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
  update_config {
    max_unavailable_percentage = 33
  }
}

# __generated__ by Terraform from "education-eks-llKeClyy:arn:aws:iam::381492178574:root"
resource "aws_eks_access_entry" "demo_eks_entry_root" {
  cluster_name      = "education-eks-llKeClyy"
  kubernetes_groups = []
  principal_arn     = "arn:aws:iam::381492178574:root"
  tags              = {}
  tags_all          = {}
  type              = "STANDARD"
  user_name         = "arn:aws:iam::381492178574:root"
}

# __generated__ by Terraform from "education-eks-llKeClyy:arn:aws:iam::381492178574:user/iamadmin"
resource "aws_eks_access_entry" "demo_eks_entry_iamadmin" {
  cluster_name      = "education-eks-llKeClyy"
  kubernetes_groups = []
  principal_arn     = "arn:aws:iam::381492178574:user/iamadmin"
  tags              = {}
  tags_all          = {}
  type              = "STANDARD"
  user_name         = "arn:aws:iam::381492178574:user/iamadmin"
}

# __generated__ by Terraform
resource "aws_vpc" "demo_vpc" {
  assign_generated_ipv6_cidr_block     = false
  cidr_block                           = "10.0.0.0/16"
  enable_dns_hostnames                 = true
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  instance_tenancy                     = "default"
  tags = {
    Name = "education-vpc"
  }
  tags_all = {
    Name = "education-vpc"
  }
}
