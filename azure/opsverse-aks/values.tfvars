resource_group_name         = "opsverse-aks-rg" #resource group for vpc and cluster
prefix                      = "opsverse-gke"
cluster_name                = "opsverse-gke-cluster" #Cluster name
location                    = "centralindia" #region for all resources
kubernetes_version          = "1.30"
address_space               = "10.241.0.0/16"
subnet_names                = ["opsverse-aks-cluster-public-a", "opsverse-aks-cluster-public-b", "opsverse-aks-cluster-private-a", "opsverse-aks-cluster-private-b"]
subnet_prefixes             = ["10.241.0.0/18", "10.241.64.0/18", "10.241.128.0/18", "10.241.192.0/18"]
nodepool_availability_zones = [1]
system_nodepool_type        = "VirtualMachineScaleSets"
system_nodepool_size        = "Standard_D2as_v4"

custom_node_pool_labels = {
    "rg"             = "opsverse-gke-sass"
    "cluster"        = "opsverse-gke-sass"
    "env"            = "prod"
}
custom_node_pool_tags = {
    "rg"             = "opsverse-gke-sass"
    "cluster"        = "opsverse-gke-sass"
    "env"            = "prod"
}