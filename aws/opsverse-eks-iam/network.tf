# Creates one VPC in atleast 2 availability zones with multiple subnets per availability zone (Atleast 1 public subnet and 'n' private subnets)

module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  version              = "5.5.1"

  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = var.vpc_network_azs
  private_subnets      = var.private_subnet_cidr
  public_subnets       = var.public_subnet_cidr

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  nat_gateway_tags = {
    Name = "${var.vpc_name}-nat-gw"
  }

  igw_tags = {
    Name = "${var.vpc_name}-igw"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = {
    Terraform = "true"
    Environment = "opsverse-cluster"
    GeneratedBy = "OpsVerse"
  }
}
