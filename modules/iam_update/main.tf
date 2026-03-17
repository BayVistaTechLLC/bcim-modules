# IAM Custom Role Update
# Managed by BCIM — do not edit manually

resource "google_project_iam_custom_role" "bcim_action_role" {
  project     = var.project_id
  role_id     = "bcimActionRole"
  title       = "BCIM Action Role"
  description = "Custom role for BCIM infrastructure actions"
  permissions = var.action_role_permissions
}
