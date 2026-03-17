output "network_id" {
  description = "VPC network ID"
  value       = google_compute_network.network.id
}

output "network_name" {
  description = "VPC network name"
  value       = google_compute_network.network.name
}

output "network_self_link" {
  description = "VPC network self link"
  value       = google_compute_network.network.self_link
}
