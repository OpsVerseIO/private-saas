variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "prefix" {
  type        = string
  description = "The prefix used for all resources in this example"
}

variable "location" {
  type        = string
  description = "Resources location in Azure"
}

variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "address_space" {
  type        = string
  description = "Address space"
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "Subnet prefixes"
}

variable "subnet_names" {
  type        = list(string)
  description = "Subnet names"
}

variable "nodepool_availability_zones" {
  type        = list(number)
  description = "Expected availability zones for the nodes"
  default     = [1]
}

variable "system_nodepool_type" {
  type        = string
  description = "System nodepool type"
}

variable "system_nodepool_size" {
  type        = string
  description = "System nodepool vm size"
}

variable "custom_node_pool_labels" {
  type = map(string)
}

variable "custom_node_pool_tags" {
  type = map(string)
}

variable "public_access" {
  default = false
}

variable "custom_nodepool_name" {
  type        = string
  description = "Custom nodepool name"
}

variable "custom_nodepool_size" {
  type        = string
  description = "Custom nodepool vm size"
}