gcp_project_id      = "opsverse-dev-poc"
gcp_region          = "us-east4"
cluster_name        = "opsverse-gke-cluster"
# It is recommended to ssecify the exact version (With exact Major, Minor and Patch) you want to use.
# Since `auto_upgrade` option is disbaled, specifying the general version is not recommended.
# For instance, if `1.30` version is desired, a stable version is "1.30.3-gke.1225000". This can be given specifically.
cluster_version     = "1.30"
# release_channel is set as UNSPECIFIED because the auto upgradation of nodes is disabled.
# This must be set to either `REGULAR` or `STABLE` in case if auto upgradation to be enabled.
release_channel     = "UNSPECIFIED"
auto_upgrade_nodes  = false
deletion_protection = false
network_name        = "opsverse-gke-network"
node_type           = "e2-standard-4"
node_locations      = "us-east4-a,us-east4-b,us-east4-c"

# 3 Public Subnets and 3 Private Subnets by default
# This can be changed as per requirements
subnets = [
    {
        subnet_name   = "opsverse-gke-cluster-apps-public-a"
        subnet_ip     = "10.245.0.0/19"
        subnet_region = "us-east4"
    },
    {
        subnet_name   = "opsverse-gke-cluster-apps-public-b"
        subnet_ip     = "10.245.32.0/19"
        subnet_region = "us-east4"
    },
    {
        subnet_name   = "opsverse-gke-cluster-apps-public-c"
        subnet_ip     = "10.245.64.0/19"
        subnet_region = "us-east4"
    },
    {
        subnet_name   = "opsverse-gke-cluster-apps-private-a"
        subnet_ip     = "10.245.96.0/19"
        subnet_region = "us-east4"
    },
    {
        subnet_name   = "opsverse-gke-cluster-apps-private-b"
        subnet_ip     = "10.245.128.0/19"
        subnet_region = "us-east4"
    },
    {
        subnet_name   = "opsverse-gke-cluster-apps-private-c"
        subnet_ip     = "10.245.160.0/19"
        subnet_region = "us-east4"
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
