resource "azurerm_resource_group" "aks-private-saas" {
  name     = var.resource_group_name
  location = var.location
}

module "aks-private-saas" {
  source               = "Azure/aks/azurerm"
  resource_group_name  = azurerm_resource_group.aks-private-saas.name
  kubernetes_version   = var.kubernetes_version
  orchestrator_version = var.kubernetes_version
  prefix               = "tf"
  cluster_name         = var.cluster_name
  network_plugin       = "azure"
  vnet_subnet_id       = module.aks-private-saas-vnet.vnet_subnets[0]
  os_disk_size_gb      = 128
  # currently, the AKS/module requires at least one "System" (not "User") node pool, 
  # and those can't be scaled to 0
  agents_pool_name = "opsversepool"

  # Used for "System" node pool manual autoscaling
  agents_count = 1

  # Used if autocaling enabled 
  agents_min_count          = 0
  agents_max_count          = 0
  agents_availability_zones = var.nodepool_availability_zones
  agents_type               = var.system_nodepool_type
  agents_size               = var.system_nodepool_size

  agents_tags = {
    "Agent" : "defaultnodepoolagent"
  }

  network_policy   = "azure"
  rbac_aad         = true
  rbac_aad_managed = true
  # Set to false in dev clusters for cost reasons
  log_analytics_workspace_enabled   = false
  role_based_access_control_enabled = true

  node_pools = {
    custom_node_pool = {
      name                   = "nodepool"
      vm_size                = "Standard_B4ms"
      orchestrator_version   = var.kubernetes_version
      os_disk_size_gb        = 30
      enable_auto_scaling    = false
      node_count             = 3
      min_count              = 0
      max_count              = 0
      availability_zones     = var.nodepool_availability_zones
      enable_node_public_ip  = false
      node_labels            = var.custom_node_pool_labels
      node_tags              = var.custom_node_pool_tags
      enable_host_encryption = false
      max_pods               = 50
    },
  }

  depends_on = [module.aks-private-saas-vnet]
}



##########################
# Kubeconfig
##########################
resource "local_file" "kubeconfig" {
  depends_on = [module.aks-private-saas]
  filename   = "kubeconfig"
  content    = module.aks-private-saas.kube_config_raw
}
