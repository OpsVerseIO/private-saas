# Creates a 3-node EKS cluster. You may additionally want to:
#   - add more subnets to span whichever networks you want
#   - add manage_aws_auth="true" in case you do auth maps here too 
#   - change cluster/module name to one that fits your org conventions

provider "aws" {
  region = var.aws_region
}

module "opsverse-eks-cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  # Cluster endpoint access is set to public and private.
  # In this config, the cluster endpoint is accessible from outside of the VPC. Worker node traffic to the endpoint will stay within the VPC.
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true

  // Need at least 2 AZs for EKS to create cluster
  # Uncomment this if a customer already has a VPC and Subnets
  # subnet_ids      = [
  #                   "${var.subnet_ids[0]}",
  #                   "${var.subnet_ids[1]}",
  #                   ]
  # vpc_id          = "${var.vpc_id}"
  
  # Uncomment this if a new VPC has to be created as part of the cluster creation
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  enable_irsa     = "true"
  eks_managed_node_group_defaults = {
    disk_size      = 50
  }

  eks_managed_node_groups = {
    user_group_one = {
      name = "node-group-1"
      instance_types = ["m7a.xlarge"]
      ami_type       = "AL2_x86_64"
      capacity_type  = "ON_DEMAND"
      # By default, the module creates a launch template to ensure tags are propagated to instances, etc.,
      # so we need to disable it to use the default template provided by the AWS EKS managed node group service
      # use_custom_launch_template = false
      min_size     = 2
      max_size     = 4
      desired_size = 3
      root_volume_type = "gp2"
      key_name = var.keypair_name

      # Uncomment this if a customer already has a VPC and Subnets
      # subnets = [
      #   "${var.subnet_ids[0]}",
      #   "${var.subnet_ids[1]}"
      # ]

      # Uncomment this if a new VPC has to be created as part of the cluster creation
      subnet_ids      = module.vpc.private_subnets
    }
  }
}
