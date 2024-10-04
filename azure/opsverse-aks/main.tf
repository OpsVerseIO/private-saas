resource "azurerm_resource_group" "aks-private-sass" {
  name     = var.resource_group_name
  location = var.location
}

# module "aks-private-sass-vnet" {
#   source              = "Azure/network/azurerm"
#   resource_group_name = azurerm_resource_group.aks-private-sass.name
#   vnet_name           = "${var.prefix}-network"
#   address_space       = var.address_space
#   subnet_prefixes     = var.subnet_prefixes
#   subnet_names        = var.subnet_names

#   subnet_service_endpoints = {
#     service_endpoints = ["Microsoft.Storage"]
#   }
#   # private_endpoint_network_policies_enabled = false
#   use_for_each = true
#   depends_on   = [azurerm_resource_group.aks-private-sass]
# }

# module "aks-private-sass" {
#   source               = "Azure/aks/azurerm"
#   resource_group_name  = azurerm_resource_group.aks-private-sass.name
#   kubernetes_version   = var.kubernetes_version
#   orchestrator_version = var.kubernetes_version
#   prefix               = "tf"
#   cluster_name         = var.cluster_name
#   network_plugin       = "azure"
#   vnet_subnet_id       = module.aks-private-sass-vnet.vnet_subnets[0]
#   os_disk_size_gb      = 128
#   # currently, the AKS/module requires at least one "System" (not "User") node pool, 
#   # and those can't be scaled to 0
#   agents_pool_name = "opsversepool"

#   # Used for "System" node pool manual autoscaling
#   agents_count = 1

#   # Used if autocaling enabled 
#   agents_min_count          = 0
#   agents_max_count          = 0
#   agents_availability_zones = var.nodepool_availability_zones
#   agents_type               = var.system_nodepool_type
#   agents_size               = var.system_nodepool_size

#   agents_tags = {
#     "Agent" : "defaultnodepoolagent"
#   }

#   network_policy   = "azure"
#   rbac_aad         = true
#   rbac_aad_managed = true
#   # Set to false in dev clusters for cost reasons
#   log_analytics_workspace_enabled   = false
#   role_based_access_control_enabled = true

#   node_pools = {
#     custom_node_pool = {
#       name                   = "nodepool"
#       vm_size                = "Standard_B4ms"
#       orchestrator_version   = var.kubernetes_version
#       os_disk_size_gb        = 30
#       enable_auto_scaling    = false
#       node_count             = 3
#       min_count              = 0
#       max_count              = 0
#       availability_zones     = var.nodepool_availability_zones
#       enable_node_public_ip  = false
#       node_labels            = var.custom_node_pool_labels
#       node_tags              = var.custom_node_pool_tags
#       enable_host_encryption = false
#       max_pods               = 50
#     },
#   }

#   depends_on = [module.aks-private-sass-vnet]
# }

# ##########################
# # Cluster backup buckets
# ##########################
# resource "azurerm_storage_account" "aks-private-sass-sa" {
#   name                     = "opsversestorageaccount"
#   resource_group_name      = azurerm_resource_group.aks-private-sass.name
#   location                 = var.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   depends_on               = [azurerm_resource_group.aks-private-sass, module.aks-private-sass-vnet, module.aks-private-sass]
# }

# resource "azurerm_storage_container" "aks-private-sass-container" {
#   name                  = "opsversestoragecontainer"
#   storage_account_name  = azurerm_storage_account.aks-private-sass-sa.name
#   container_access_type = "private"
#   depends_on            = [azurerm_resource_group.aks-private-sass, module.aks-private-sass-vnet, module.aks-private-sass, azurerm_storage_account.aks-private-sass-sa]
# }

# resource "azurerm_storage_blob" "aks-private-sass-blob" {
#   name                   = "opsverse-backups"
#   storage_account_name   = azurerm_storage_account.aks-private-sass-sa.name
#   storage_container_name = azurerm_storage_container.aks-private-sass-container.name
#   type                   = "Block"
#   depends_on             = [azurerm_resource_group.aks-private-sass, module.aks-private-sass-vnet, module.aks-private-sass, azurerm_storage_account.aks-private-sass-sa, azurerm_storage_blob.aks-private-sass-blob]
# }

# ##########################
# # Kubeconfig
# ##########################
# resource "local_file" "kubeconfig" {
#   depends_on = [module.aks-private-sass]
#   filename   = "kubeconfig"
#   content    = module.aks-private-sass.kube_config_raw
# }


# data "azurerm_user_assigned_identity" "agentpool_mi" {
#   name                = "${var.cluster_name}-agentpool"
#   resource_group_name = module.aks-private-sass.node_resource_group
#   depends_on          = [azurerm_resource_group.aks-private-sass, module.aks-private-sass-vnet, module.aks-private-sass]
# }

# resource "azurerm_role_assignment" "blob_data_owner_role" {
#   principal_id         = data.azurerm_user_assigned_identity.agentpool_mi.principal_id
#   role_definition_name = "Storage Blob Data Owner"
#   scope                = azurerm_resource_group.aks-private-sass.id
#   depends_on           = [azurerm_resource_group.aks-private-sass, module.aks-private-sass-vnet, module.aks-private-sass]
# }