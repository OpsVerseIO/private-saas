resource "azurerm_storage_account" "aks-private-sass-sa" {
  name                     = "opsversestorageaccount"
  resource_group_name      = azurerm_resource_group.aks-private-sass.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on               = [azurerm_resource_group.aks-private-sass, module.aks-private-sass-vnet, module.aks-private-sass]
}

resource "azurerm_storage_container" "aks-private-sass-container" {
  name                  = "opsversestoragecontainer"
  storage_account_name  = azurerm_storage_account.aks-private-sass-sa.name
  container_access_type = "private"
  depends_on            = [azurerm_resource_group.aks-private-sass, module.aks-private-sass-vnet, module.aks-private-sass, azurerm_storage_account.aks-private-sass-sa]
}

resource "azurerm_storage_blob" "aks-private-sass-blob" {
  name                   = "opsverse-backups"
  storage_account_name   = azurerm_storage_account.aks-private-sass-sa.name
  storage_container_name = azurerm_storage_container.aks-private-sass-container.name
  type                   = "Block"
  depends_on             = [azurerm_resource_group.aks-private-sass, module.aks-private-sass-vnet, module.aks-private-sass, azurerm_storage_account.aks-private-sass-sa, azurerm_storage_blob.aks-private-sass-blob]
}