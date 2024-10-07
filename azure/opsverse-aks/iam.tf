data "azuread_client_config" "current" {}


data "azurerm_user_assigned_identity" "agentpool_mi" {
  name                = "${var.cluster_name}-agentpool"
  resource_group_name = module.aks-private-sass.node_resource_group
  depends_on          = [azurerm_resource_group.aks-private-sass, module.aks-private-sass-vnet, module.aks-private-sass]
}

# Assign the 'Storage Blob Data Owner' role for manage-identity
resource "azurerm_role_assignment" "blob_data_owner_role" {
  principal_id         = data.azurerm_user_assigned_identity.agentpool_mi.principal_id
  role_definition_name = "Storage Blob Data Owner"
  scope                = azurerm_resource_group.aks-private-sass.id
  depends_on           = [azurerm_resource_group.aks-private-sass, module.aks-private-sass-vnet, module.aks-private-sass]
}

# Create the Azure AD Application for the Service Principal
resource "azuread_application" "aks_sp" {
  display_name = "${var.cluster_name}-sp"
  owners       = [data.azuread_client_config.current.object_id]
  password {
    display_name = "secret"
    end_date     = timeadd(timestamp(), "17520h")
  }
}
resource "local_file" "sp_secret_file" {
  content  = tolist(azuread_application.aks_sp.password).0.value
  filename = "${path.module}/sp_secret.txt"
}

# Create the Service Principal
resource "azuread_service_principal" "aks_sp" {
  client_id  = azuread_application.aks_sp.client_id
  depends_on = [azurerm_resource_group.aks-private-sass]
  owners     = [data.azuread_client_config.current.object_id]
}

# Assign the 'Storage Blob Data Contributor' role
resource "azurerm_role_assignment" "storage_blob_data_contributor" {
  principal_id         = azuread_service_principal.aks_sp.object_id
  role_definition_name = "Storage Blob Data Contributor"
  scope                = azurerm_resource_group.aks-private-sass.id
}

# Assign the 'Storage Blob Data Owner' role
resource "azurerm_role_assignment" "storage_blob_data_owner" {
  principal_id         = azuread_service_principal.aks_sp.object_id
  role_definition_name = "Storage Blob Data Owner"
  scope                = azurerm_resource_group.aks-private-sass.id
}

# Assign the 'Storage Account Contributor' role
resource "azurerm_role_assignment" "storage_account_contributor" {
  principal_id         = azuread_service_principal.aks_sp.object_id
  role_definition_name = "Storage Account Contributor"
  scope                = azurerm_resource_group.aks-private-sass.id
}

# Assign the 'Storage Queue Data Contributor' role
resource "azurerm_role_assignment" "storage_queue_data_contributor" {
  principal_id         = azuread_service_principal.aks_sp.object_id
  role_definition_name = "Storage Queue Data Contributor"
  scope                = azurerm_resource_group.aks-private-sass.id
}


