module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.30.3"

  cluster_name    = local.cluster_name
  cluster_version = "1.24"
  subnet_ids      = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  eks_managed_node_groups = {
    first = {
      min_size     = var.managed_nodegroup_min_size
      max_size     = var.managed_nodegroup_max_size
      desired_size = var.managed_nodegroup_desired_size

      instance_types = var.managed_nodegroup_instance_types
    }
  }
}
