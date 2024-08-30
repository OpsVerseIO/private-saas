output network_name {
  value = module.opsverse-gke-cluster-network.network_name
}

output subnets_names {
  value = module.opsverse-gke-cluster-network.subnets_names[*]
}