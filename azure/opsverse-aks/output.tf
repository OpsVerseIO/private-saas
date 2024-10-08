output "resource_group" {
  value = azurerm_resource_group.aks-private-saas.name
}

output "aks-private-saas-vnet" {
  value = module.aks-private-saas-vnet.vnet_id
}

output "subnet" {
  value = module.aks-private-saas-vnet
}

output "kube_config" {
  value     = module.aks-private-saas.kube_config_raw
  sensitive = true
}

output "client_secret" {
  sensitive = true
  value     = tolist(azuread_application.aks_sp.password).0.value
}


output "client_id" {
  value = azuread_service_principal.aks_sp.client_id
}

output "tenant_id" {
  value = azuread_service_principal.aks_sp.application_tenant_id
}