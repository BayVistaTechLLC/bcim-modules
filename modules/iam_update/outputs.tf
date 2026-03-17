output "role_id" {
  description = "Updated custom role ID"
  value       = google_project_iam_custom_role.bcim_action_role.id
}

output "permissions_count" {
  description = "Number of permissions in the role"
  value       = length(var.action_role_permissions)
}
