import {
  to = aws_eks_cluster.demo_eks
  id = var.eks_cluster_name
}

import {
  to = aws_eks_node_group.demo_node_group_1
  id = "${var.eks_cluster_name}:${var.eks_node_group_names[0]}"
}

import {
  to = aws_eks_node_group.demo_node_group_2
  id = "${var.eks_cluster_name}:${var.eks_node_group_names[1]}"
}

import {
  to = aws_eks_access_entry.demo_eks_entry_root
  id = "${var.eks_cluster_name}:${var.eks_access_entry_arns[0]}"
}

import {
  to = aws_eks_access_entry.demo_eks_entry_iamadmin
  id = "${var.eks_cluster_name}:${var.eks_access_entry_arns[1]}"
}

import {
  to = aws_vpc.demo_vpc
  id = var.vpc_id
}

import {
  to = aws_kms_key.demo_eks_kms_key
  id = var.eks_kms_key_id
}