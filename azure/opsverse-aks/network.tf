module "aks-private-saas-vnet" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.aks-private-saas.name
  vnet_name           = "${var.prefix}-network"
  address_space       = var.address_space
  subnet_prefixes     = var.subnet_prefixes
  subnet_names        = var.subnet_names

  subnet_service_endpoints = {
    service_endpoints = ["Microsoft.Storage"]
  }
  use_for_each = true
  depends_on   = [azurerm_resource_group.aks-private-saas]
}