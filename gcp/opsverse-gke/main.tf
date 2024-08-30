resource "local_file" "kubeconfig-opsverse-gke-cluster" {
  content  = module.opsverse-gke-cluster-auth.kubeconfig_raw
  filename = "kubeconfig_opsverse-gke-cluster"
}

module "opsverse-gke-cluster" {
  source                   = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version                  = "32.0.4"
  kubernetes_version       = var.cluster_version
  issue_client_certificate = true
  project_id               = var.gcp_project_id
  name                     = var.cluster_name
  regional                 = true
  region                   = var.gcp_region
  network                  = module.opsverse-gke-cluster-network.network_name
  subnetwork               = module.opsverse-gke-cluster-network.subnets_names[0]
  ip_range_pods            = "ip-range-pods" 
  ip_range_services        = "ip-range-services" 
  node_pools = [
    {
      name                 = "opsverse-node-pool"
      machine_type         = var.node_type
      node_locations       = var.node_locations

      // nodes per location (this multiplied by number
      // of locations will be the current node count)
      node_count           = 1
      initial_node_count   = 3
      min_count            = 3
      max_count            = 3
      disk_size_gb         = 30
      autoscaling          = false 
      auto_upgrade         = false
    },
  ]
}

module "opsverse-gke-cluster-auth" {
  source       = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  version      = "32.0.4"
  depends_on   = [module.opsverse-gke-cluster]
  project_id   = var.gcp_project_id
  location     = module.opsverse-gke-cluster.location
  cluster_name = module.opsverse-gke-cluster.name
}