resource "azurerm_storage_account" "aks-private-saas-sa" {
  name                     = "opsversestorageaccount"
  resource_group_name      = azurerm_resource_group.aks-private-saas.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on               = [azurerm_resource_group.aks-private-saas, module.aks-private-saas-vnet, module.aks-private-saas]
}

resource "azurerm_storage_container" "aks-private-saas-container" {
  name                  = "opsversestoragecontainer"
  storage_account_name  = azurerm_storage_account.aks-private-saas-sa.name
  container_access_type = "private"
  depends_on            = [azurerm_resource_group.aks-private-saas, module.aks-private-saas-vnet, module.aks-private-saas, azurerm_storage_account.aks-private-saas-sa]
}

resource "azurerm_storage_blob" "aks-private-saas-blob" {
  name                   = "opsverse-backups"
  storage_account_name   = azurerm_storage_account.aks-private-saas-sa.name
  storage_container_name = azurerm_storage_container.aks-private-saas-container.name
  type                   = "Block"
  depends_on             = [azurerm_resource_group.aks-private-saas, module.aks-private-saas-vnet, module.aks-private-saas, azurerm_storage_account.aks-private-saas-sa, azurerm_storage_container.aks-private-saas-container]
}