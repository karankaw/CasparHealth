variable "region" {
  type        = string
  description = "Target AWS Region"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS Cluster"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Range"
}

variable "managed_nodegroup_min_size" {
  type        = number
  description = "Minimum number of nodes in nodegroup"
}

variable "managed_nodegroup_max_size" {
  type        = number
  description = "Maximum number of nodes in nodegroup"
}

variable "managed_nodegroup_desired_size" {
  type        = number
  description = "Initial number of nodes in nodegroup"
}

variable "managed_nodegroup_instance_types" {
  type        = list(string)
  description = "Ec2 Instance Family Type for Ec2 nodes in nodegroup"
}
