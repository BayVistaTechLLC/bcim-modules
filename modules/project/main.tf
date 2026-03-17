# GCP Project Provisioning
# Managed by BCIM — do not edit manually

resource "google_project" "project" {
  name                = var.display_name
  project_id          = var.project_id
  org_id              = var.org_id != "" ? var.org_id : null
  folder_id           = var.folder_id != "" ? var.folder_id : null
  billing_account     = var.billing_account
  auto_create_network = false

  labels = merge(var.labels, {
    managed-by = "bcim"
  })
}

# Bootstrap APIs
resource "google_project_service" "api" {
  for_each = toset(var.service_apis)

  project = google_project.project.project_id
  service = each.value

  disable_dependent_services = false
  disable_on_destroy         = false

  depends_on = [google_project.project]
}

# BCIM action service account
resource "google_service_account" "action_sa" {
  project      = google_project.project.project_id
  account_id   = "bcim-action-sa"
  display_name = "BCIM Action Service Account"
  description  = "Service account for BCIM infrastructure actions"

  depends_on = [google_project_service.api]
}

# Custom IAM role for BCIM actions
resource "google_project_iam_custom_role" "bcim_action_role" {
  project     = google_project.project.project_id
  role_id     = "bcimActionRole"
  title       = "BCIM Action Role"
  description = "Custom role for BCIM infrastructure actions"
  permissions = var.action_role_permissions

  depends_on = [google_project_service.api]
}

resource "google_project_iam_member" "action_sa_role" {
  project = google_project.project.project_id
  role    = google_project_iam_custom_role.bcim_action_role.id
  member  = "serviceAccount:${google_service_account.action_sa.email}"
}

# Minter SA tokenCreator on action SA
resource "google_service_account_iam_member" "minter_token_creator" {
  service_account_id = google_service_account.action_sa.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${var.minter_sa_email}"
}

# Reader SA tokenCreator on action SA (for credential minting chain)
resource "google_service_account_iam_member" "reader_token_creator" {
  count = var.reader_sa_email != "" ? 1 : 0

  service_account_id = google_service_account.action_sa.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "serviceAccount:${var.reader_sa_email}"
}

# Admin group owner access
resource "google_project_iam_member" "admin_group_owner" {
  count = var.admin_group != "" ? 1 : 0

  project = google_project.project.project_id
  role    = "roles/owner"
  member  = "group:${var.admin_group}"
}

# Requesting user owner access
resource "google_project_iam_member" "requesting_user_owner" {
  count = var.requesting_user != "" ? 1 : 0

  project = google_project.project.project_id
  role    = "roles/owner"
  member  = "user:${var.requesting_user}"
}

# Action SA access to Terraform state bucket
resource "google_storage_bucket_iam_member" "action_sa_state_access" {
  count = var.state_bucket != "" ? 1 : 0

  bucket = var.state_bucket
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.action_sa.email}"
}

# Budget alert
resource "google_billing_budget" "project_budget" {
  billing_account = var.billing_account
  display_name    = "${var.project_id} monthly budget"

  budget_filter {
    projects = ["projects/${google_project.project.number}"]
  }

  amount {
    specified_amount {
      currency_code = "USD"
      units         = var.budget_amount
    }
  }

  threshold_rules {
    threshold_percent = 0.5
    spend_basis       = "CURRENT_SPEND"
  }

  threshold_rules {
    threshold_percent = 0.8
    spend_basis       = "CURRENT_SPEND"
  }

  threshold_rules {
    threshold_percent = 1.0
    spend_basis       = "CURRENT_SPEND"
  }

  depends_on = [google_project.project]
}
