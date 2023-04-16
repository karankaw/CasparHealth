region       = "eu-central-1"
cluster_name = "casparhealth-eks"
vpc_cidr     = "172.16.0.0/16"

managed_nodegroup_min_size     = 2
managed_nodegroup_max_size     = 5
managed_nodegroup_desired_size = 2

managed_nodegroup_instance_types = ["t2.micro"]
