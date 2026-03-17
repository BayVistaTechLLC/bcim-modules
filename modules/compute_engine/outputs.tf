output "instance_name" {
  description = "Compute Engine instance name"
  value       = google_compute_instance.instance.name
}

output "instance_self_link" {
  description = "Compute Engine instance self link"
  value       = google_compute_instance.instance.self_link
}

output "internal_ip" {
  description = "Internal IP address"
  value       = google_compute_instance.instance.network_interface[0].network_ip
}
