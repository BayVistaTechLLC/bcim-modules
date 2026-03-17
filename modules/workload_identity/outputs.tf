output "pool_name" {
  description = "Workload Identity Pool name"
  value       = google_iam_workload_identity_pool.pool.name
}

output "provider_name" {
  description = "Workload Identity Pool Provider name"
  value       = google_iam_workload_identity_pool_provider.provider.name
}
