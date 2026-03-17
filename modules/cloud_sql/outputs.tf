output "instance_name" {
  description = "Cloud SQL instance name"
  value       = google_sql_database_instance.instance.name
}

output "connection_name" {
  description = "Cloud SQL connection name"
  value       = google_sql_database_instance.instance.connection_name
}

output "public_ip" {
  description = "Public IP address (null if private-only)"
  value       = google_sql_database_instance.instance.public_ip_address
}

output "private_ip" {
  description = "Private IP address (null if public-only)"
  value       = google_sql_database_instance.instance.private_ip_address
}

output "database_names" {
  description = "Created database names"
  value       = [for db in google_sql_database.db : db.name]
}
