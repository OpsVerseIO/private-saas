resource_group_name         = "opsverse-aks-rg"      #resource group for vpc and cluster
prefix                      = "opsverse-aks"         #for network
cluster_name                = "opsverse-aks-cluster" #Cluster name
location                    = "centralindia"         #region for all resources
kubernetes_version          = "1.30"
address_space               = "10.241.0.0/16"
subnet_names                = ["opsverse-aks-cluster-public-a", "opsverse-aks-cluster-public-b", "opsverse-aks-cluster-private-a", "opsverse-aks-cluster-private-b"]
subnet_prefixes             = ["10.241.0.0/18", "10.241.64.0/18", "10.241.128.0/18", "10.241.192.0/18"]
nodepool_availability_zones = [1]
system_nodepool_type        = "VirtualMachineScaleSets"
system_nodepool_size        = "Standard_D2as_v4"
custom_nodepool_name        = "nodepool"
custom_nodepool_size        = "Standard_B4ms"
custom_node_pool_labels = {
  "cluster" = "opsverse"
  "env"     = "prod"
}
custom_node_pool_tags = {
  "cluster" = "opsverse"
  "env"     = "prod"
}