# provider "azurerm" {
#   features {}
# }


# resource "azurerm_resource_group" "aks-rg" {
#   name     = "aks-test"
#   location = "Central India"
# }



# resource "azurerm_role_assignment" "blob_data_contributor" {
#   principal_id   = azuread_service_principal.aks_prod_centralindia_sp.application_id
#   role_definition_name = "Storage Blob Data Contributor"
#   scope          = azurerm_resource_group.aks-rg.id
# }

# resource "azurerm_role_assignment" "blob_data_owner" {
#   principal_id   = azuread_service_principal.aks_prod_centralindia_sp.application_id
#   role_definition_name = "Storage Blob Data Owner"
#   scope          = azurerm_resource_group.aks-rg.id
# }

# resource "azurerm_role_assignment" "storage_account_contributor" {
#   principal_id   = azuread_service_principal.aks_prod_centralindia_sp.application_id
#   role_definition_name = "Storage Account Contributor"
#   scope          = azurerm_resource_group.aks-rg.id
# }

# resource "azurerm_role_assignment" "queue_data_contributor" {
#   principal_id   = azuread_service_principal.aks_prod_centralindia_sp.application_id
#   role_definition_name = "Storage Queue Data Contributor"
#   scope          = azurerm_resource_group.aks-rg.id
# }

# resource "azuread_application" "aks-prod-centralindia-sp" {
#   display_name = "aks-prod-centralindia-sp"

# }

# resource "azuread_service_principal" "aks_prod_centralindia_sp" {
#   client_id                    = azuread_application.aks-prod-centralindia-sp.client_id
#   app_role_assignment_required = false
# }




# output "client_id" {
#   value = azuread_service_principal.aks_prod_centralindia_sp.application_id
# }

# output "client_secret" {
#   value = azuread_service_principal_password.aks_prod_centralindia_sp.value
# }

# resource "azuread_service_principal_password" "aks_prod_centralindia_sp" {
#   service_principal_id = azuread_service_principal.aks_prod_centralindia_sp.id
#   value                = random_password.sp_password.result
#   end_date             = "2099-12-31T23:59:59Z"
# }

# resource "random_password" "sp_password" {
#   length  = 16
#   special = true
# }
