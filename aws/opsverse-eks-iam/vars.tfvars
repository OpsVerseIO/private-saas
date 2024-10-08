aws_profile = "default"
aws_region = "us-west-2"
cluster_name = "opsverse-eks-cluster"
cluster_version = "1.28"
s3_bucket_name = "opsverse-eks-bucket"
node_type = "m5a.xlarge"
# This is relevant if VPC and Subnets already exists and the same should be used to create ths cluster.
subnet_ids = [
    "subnet-0cb2af484cc733af3", 
    "subnet-03e125b72f74725e0"
]
vpc_id = "vpc-07f7a27bb284d892a"

# This is relevant if VPC and Subnets has to be created by the Terraform. Ignore if these are already present.
vpc_name            = "opsverse-vpc"
vpc_network_azs     = ["us-west-2a", "us-west-2b"]
vpc_cidr            = "10.242.0.0/16"
private_subnet_cidr = ["10.242.0.0/18", "10.242.64.0/18"]
public_subnet_cidr  = ["10.242.128.0/18", "10.242.192.0/18"]