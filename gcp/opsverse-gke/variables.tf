variable "gcp_project_id" {
  type = string
}

variable "gcp_region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "node_type" {
  type = string
}

variable "node_locations" {
  type = string
}

variable "network_name" {
  type = string
}

variable "release_channel" {
  type = string
}

variable "deletion_protection" {
  type = bool
}

variable "auto_upgrade_nodes" {
  type = bool
}

variable "subnets" {
  description = "List of subnets for the GKE cluster"
  type = list(object({
    subnet_name   = string
    subnet_ip     = string
    subnet_region = string
  }))
}

variable "secondary_ranges" {
  description = "Map of secondary ranges for each subnet"
  type = map(list(object({
    range_name    = string
    ip_cidr_range = string
  })))
}

variable "bucket_name" {
  type = string
}


variable "customer_stack" {
  type = string
}