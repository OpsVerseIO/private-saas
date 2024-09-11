module "bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 6.1"

  name       = var.bucket_name
  project_id = var.gcp_project_id
  location   = var.gcp_region
  iam_members = [{
    role   = "roles/storage.admin"
    member = "user:amarthyanath@opsverse.io"
  }]
}


