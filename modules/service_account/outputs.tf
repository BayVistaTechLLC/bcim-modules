output "service_account_email" {
  description = "Service account email"
  value       = google_service_account.sa.email
}

output "service_account_id" {
  description = "Service account unique ID"
  value       = google_service_account.sa.unique_id
}

output "service_account_name" {
  description = "Service account fully qualified name"
  value       = google_service_account.sa.name
}
