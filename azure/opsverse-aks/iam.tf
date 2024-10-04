# Create the Service Principal
resource "azuread_service_principal" "aks_sp" {
  client_id  = azuread_application.aks_sp.client_id
  depends_on = [azurerm_resource_group.aks-private-sass]
}

# Create the Azure AD Application for the Service Principal
resource "azuread_application" "aks_sp" {
  display_name = "${var.cluster_name}-sp"
}

# Create the Service Principal Password (Client Secret)
resource "azuread_service_principal_password" "aks_sp_secret" {
  service_principal_id = azuread_service_principal.aks_sp.id
  end_date             = timeadd(timestamp(), "17520h") # Set lifespan of 2 years
}


# Assign the 'Storage Blob Data Contributor' role
resource "azurerm_role_assignment" "storage_blob_data_contributor" {
  principal_id         = azuread_service_principal.aks_sp.id
  role_definition_name = "Storage Blob Data Contributor"
  scope                = azurerm_resource_group.aks-private-sass.id
}

# Assign the 'Storage Blob Data Owner' role
resource "azurerm_role_assignment" "storage_blob_data_owner" {
  principal_id         = azuread_service_principal.aks_sp.id
  role_definition_name = "Storage Blob Data Owner"
  scope                = azurerm_resource_group.aks-private-sass.id
}

# Assign the 'Storage Account Contributor' role
resource "azurerm_role_assignment" "storage_account_contributor" {
  principal_id         = azuread_service_principal.aks_sp.id
  role_definition_name = "Storage Account Contributor"
  scope                = azurerm_resource_group.aks-private-sass.id
}

# Assign the 'Storage Queue Data Contributor' role
resource "azurerm_role_assignment" "storage_queue_data_contributor" {
  principal_id         = azuread_service_principal.aks_sp.id
  role_definition_name = "Storage Queue Data Contributor"
  scope                = azurerm_resource_group.aks-private-sass.id
}
