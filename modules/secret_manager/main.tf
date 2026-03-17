# Secret Manager Secret
# Managed by BCIM — do not edit manually

resource "google_secret_manager_secret" "secret" {
  secret_id = var.secret_id

  replication {
    dynamic "auto" {
      for_each = var.replication_type == "automatic" ? [1] : []
      content {}
    }

    dynamic "user_managed" {
      for_each = var.replication_type == "user_managed" ? [1] : []
      content {
        dynamic "replicas" {
          for_each = var.replication_locations
          content {
            location = replicas.value
          }
        }
      }
    }
  }

  dynamic "rotation" {
    for_each = var.rotation_period != null ? [1] : []
    content {
      rotation_period = var.rotation_period
    }
  }

  expire_time = var.expire_time

  labels = merge(var.labels, {
    managed-by  = "bcim"
    environment = var.environment
  })
}
