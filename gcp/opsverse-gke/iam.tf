resource "google_storage_bucket_iam_binding" "bucket_admin" {
  bucket     = var.bucket_name
  role       = "roles/storage.objectAdmin"
  members    = [join(":", ["serviceAccount", module.opsverse-workload-identity.gcp_service_account.email])]
  depends_on = [module.bucket, module.opsverse-workload-identity]
}

module "opsverse-workload-identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  use_existing_k8s_sa = true
  name                = "loki-sa-${var.customer_stack}"
  k8s_sa_name         = "${var.customer_stack}-observe-backend-loki"
  namespace           = "${var.customer_stack}-observe"
  project_id          = var.gcp_project_id
  roles               = ["roles/iam.serviceAccountTokenCreator", "roles/viewer"]
  annotate_k8s_sa     = false
}


