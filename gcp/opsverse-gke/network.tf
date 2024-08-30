module "opsverse-gke-cluster-network" {
  source       = "terraform-google-modules/network/google"
  version      = "9.1.0"
  project_id   = var.gcp_project_id
  network_name = "opsverse-gke-cluster-apps-new"
  subnets = [
    {
      subnet_name   = "opsverse-gke-cluster-apps-public-a"
      subnet_ip     = "10.245.0.0/19"
      subnet_region = var.gcp_region
    },
    {
      subnet_name   = "opsverse-gke-cluster-apps-public-b"
      subnet_ip     = "10.245.32.0/19"
      subnet_region = var.gcp_region
    },
    {
      subnet_name   = "opsverse-gke-cluster-apps-public-c"
      subnet_ip     = "10.245.64.0/19"
      subnet_region = var.gcp_region
    },
    {
      subnet_name   = "opsverse-gke-cluster-apps-private-a"
      subnet_ip     = "10.245.96.0/19"
      subnet_region = var.gcp_region
    },
    {
      subnet_name   = "opsverse-gke-cluster-apps-private-b"
      subnet_ip     = "10.245.128.0/19"
      subnet_region = var.gcp_region
    },
    {
      subnet_name   = "opsverse-gke-cluster-apps-private-c"
      subnet_ip     = "10.245.160.0/19"
      subnet_region = var.gcp_region
    },
  ]
  secondary_ranges = {
    "opsverse-gke-cluster-apps-public-a" = [
      {
        range_name    = "ip-range-pods" 
        ip_cidr_range = "172.18.128.0/19"
      },
      {
        range_name    = "ip-range-services" 
        ip_cidr_range = "172.18.160.0/19"
      },
    ],
    "opsverse-gke-cluster-apps-public-b" = [
      {
        range_name    = "ip-range-pods" 
        ip_cidr_range = "172.18.192.0/19"
      },
      {
        range_name    = "ip-range-services" 
        ip_cidr_range = "172.18.224.0/19"
      },
    ],
    "opsverse-gke-cluster-apps-public-c" = [
      {
        range_name    = "ip-range-pods" 
        ip_cidr_range = "172.19.0.0/19"
      },
      {
        range_name    = "ip-range-services" 
        ip_cidr_range = "172.19.32.0/19"
      },
    ],
    "opsverse-gke-cluster-apps-private-a" = [
      {
        range_name    = "ip-range-pods" 
        ip_cidr_range = "172.19.64.0/19"
      },
      {
        range_name    = "ip-range-services" 
        ip_cidr_range = "172.19.96.0/19"
      },
    ],
    "opsverse-gke-cluster-apps-private-b" = [
      {
        range_name    = "ip-range-pods" 
        ip_cidr_range = "172.19.128.0/19"
      },
      {
        range_name    = "ip-range-services" 
        ip_cidr_range = "172.19.160.0/19"
      },
    ],
    "opsverse-gke-cluster-apps-private-c" = [
      {
        range_name    = "ip-range-pods" 
        ip_cidr_range = "172.19.192.0/19"
      },
      {
        range_name    = "ip-range-services" 
        ip_cidr_range = "172.19.224.0/19"
      },
    ]
  }
}
