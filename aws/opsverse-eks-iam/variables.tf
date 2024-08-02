## Fill in with your network configs
variable "cluster_name" {}
variable "cluster_version" {}
variable "aws_region" {}
# variable "keypair_name" {}
variable "s3_bucket_name" {}
variable "subnet_ids" { type = list }
variable "vpc_id" {}
variable "aws_profile" {}
variable "vpc_name" {}
variable "vpc_cidr" {}
variable "vpc_network_azs" { type = list }
variable "private_subnet_cidr" { type = list }
variable "public_subnet_cidr" { type = list }
variable "node_type" { type = string }