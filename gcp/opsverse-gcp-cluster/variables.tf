variable "gcp_project_id" {
  type        = string
}

variable "gcp_region" {
  type        = string
}

variable "cluster_name" {
  type        = string
}

variable "cluster_version" {
  type        = string
}

variable "network_name" {
  type        = string
}

# variable "subnet_name" {
#   type        = string
# }

variable "ip_range_pods" {
  type        = string
}

variable "ip_range_services" {
  type        = string
}

variable "node_type" {
  type        = string
}

variable "node_locations" {
  type        = string
}
variable "private_subnet_cidr" { 
  type = string
}
variable "public_subnet_cidr" { 
  type = string 
}