# google_client_config and kubernetes provider must be explicitly specified like the following.
provider "google" {
  project     = var.gcp_project_id
  region      = var.gcp_region
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.opsverse-gke-cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.opsverse-gke-cluster.ca_certificate)
}



module "opsverse-gke-cluster" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = var.gcp_project_id
  name                       = var.cluster_name
  region                     = var.gcp_region
  kubernetes_version         = var.cluster_version
  network                    = var.network_name
  subnetwork                 = var.subnet_name
  ip_range_pods              = var.ip_range_pods
  ip_range_services          = var.ip_range_services
  regional                   = true
  master_ipv4_cidr_block     = var.master_cidr

  node_pools = [
    {
      name                        = "node-group-1"
      machine_type                = var.node_type
      node_locations              = var.node_locations
      min_count                   = 3
      max_count                   = 4
      disk_size_gb                = 30
      auto_upgrade                = true
      initial_node_count          = 3
      autoscaling                 = false 

    },
  ]


  node_pools_tags = {
    all = []

    node-group-1 = [
      "default-node-pool",
    ]
  }
}


resource "google_project_iam_binding" "gke_cluster_admin" {
  project = var.gcp_project_id
  role    = "roles/container.admin"

  members = [
    "user:amarthyanath@opsverse.io",
  ]
}