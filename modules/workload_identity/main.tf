# Workload Identity Federation
# Managed by BCIM — do not edit manually

resource "google_iam_workload_identity_pool" "pool" {
  workload_identity_pool_id = var.pool_id
  display_name              = var.pool_id
}

resource "google_iam_workload_identity_pool_provider" "provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.provider_id
  display_name                       = var.provider_id

  oidc {
    issuer_uri        = var.issuer_uri
    allowed_audiences = length(var.allowed_audiences) > 0 ? var.allowed_audiences : null
  }

  attribute_mapping   = var.attribute_mapping
  attribute_condition = var.attribute_condition != "" ? var.attribute_condition : null
}

resource "google_service_account_iam_member" "wif_binding" {
  count = var.service_account_email != null ? 1 : 0

  service_account_id = "projects/${var.project}/serviceAccounts/${var.service_account_email}"
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.pool.name}/*"
}
