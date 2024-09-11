module "opsverse-gke-cluster-network" {
  source           = "terraform-google-modules/network/google"
  version          = "9.1.0"
  project_id       = var.gcp_project_id
  network_name     = var.network_name
  subnets          = var.subnets
  secondary_ranges = var.secondary_ranges
}
