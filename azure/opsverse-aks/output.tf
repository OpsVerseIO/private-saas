output "resource_group" {
  value = "${azurerm_resource_group.aks-prod-centindia.name}"  
}

output "aks-prod-centindia-vnet" {
  value = module.aks-prod-centindia-vnet.vnet_id
}

output "subnet" {
  value = module.aks-prod-centindia-vnet
}

output "kube_config" {
  value = module.aks-prod-centindia.kube_config_raw
  sensitive = true
}
