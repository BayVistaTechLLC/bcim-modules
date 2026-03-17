output "project_id" {
  description = "Created GCP project ID"
  value       = google_project.project.project_id
}

output "project_number" {
  description = "Created GCP project number"
  value       = google_project.project.number
}

output "action_sa_email" {
  description = "BCIM action service account email"
  value       = google_service_account.action_sa.email
}
