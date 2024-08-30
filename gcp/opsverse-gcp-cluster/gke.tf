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

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.1"

  network_name = var.network_name
  project_id    = var.gcp_project_id

  subnets = [
    {
      subnet_name   = "public-subnet"
      subnet_ip   = var.public_subnet_cidr
      subnet_region = var.gcp_region
      role   = "ACTIVE"
    },
    {
      subnet_name   = "private-subnet"
      subnet_ip   = var.private_subnet_cidr
      subnet_region = var.gcp_region
      role   = "ACTIVE"
      subnet_private_access = true
    }
  ]
}
module "opsverse-gke-cluster" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.gcp_project_id
  name                       = var.cluster_name
  region                     = var.gcp_region
  kubernetes_version         = var.cluster_version
  network                    = module.vpc.network_name
  subnetwork                 = "public-subnet"
  ip_range_pods              = var.ip_range_pods
  ip_range_services          = var.ip_range_services
  regional                   = true

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


# resource "google_project_iam_binding" "gke_cluster_admin" {
#   project = var.gcp_project_id
#   role    = "roles/container.admin"

#   members = [
#     "user:amarthyanath@opsverse.io",
#   ]
# }