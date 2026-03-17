# Cloud SQL Instance
# Managed by BCIM — do not edit manually

resource "google_sql_database_instance" "instance" {
  name             = var.service_name
  database_version = var.database_version
  region           = var.region

  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_size         = var.disk_size_gb

    backup_configuration {
      enabled    = var.backup_enabled
      start_time = "03:00"
    }

    ip_configuration {
      ipv4_enabled    = var.private_network == "" ? true : false
      private_network = var.private_network != "" ? var.private_network : null

      dynamic "authorized_networks" {
        for_each = var.authorized_networks
        content {
          name  = "network-${authorized_networks.key + 1}"
          value = authorized_networks.value
        }
      }
    }

    user_labels = merge(var.labels, {
      managed-by  = "bcim"
      environment = var.environment
    })
  }

  deletion_protection = var.environment == "production" ? true : false
}

resource "google_sql_database" "db" {
  for_each = toset(var.databases)

  name     = each.value
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_user" "user" {
  for_each = { for u in var.users : u.name => u }

  name     = each.value.name
  instance = google_sql_database_instance.instance.name
  password = lookup(each.value, "password_secret", null) != null ? data.google_secret_manager_secret_version.db_password[each.key].secret_data : null
}

data "google_secret_manager_secret_version" "db_password" {
  for_each = { for u in var.users : u.name => u if lookup(u, "password_secret", null) != null }

  secret  = each.value.password_secret
  project = var.project
}
