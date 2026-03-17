# Service Account
# Managed by BCIM — do not edit manually

resource "google_service_account" "sa" {
  account_id   = var.account_id
  display_name = var.display_name
  description  = var.description
}

resource "google_project_iam_member" "sa_role" {
  for_each = toset(var.roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.sa.email}"
}
