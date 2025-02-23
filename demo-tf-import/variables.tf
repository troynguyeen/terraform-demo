variable "eks_cluster_name" {
  type        = string
  description = "The name of EKS Cluster"
}

variable "eks_node_group_names" {
  type        = list(string)
  description = "List of the name of EKS Node Group"
}

variable "eks_access_entry_arns" {
  type        = list(string)
  description = "List of the ARN of EKS Access Entries"
}

variable "eks_kms_key_id" {
  type        = string
  description = "The id of EKS KMS Key"
}

variable "vpc_id" {
  type        = string
  description = "The id of VPC"
}