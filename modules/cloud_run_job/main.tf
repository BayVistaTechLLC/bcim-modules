# Cloud Run Job
# Managed by BCIM — do not edit manually

resource "google_cloud_run_v2_job" "job" {
  name     = var.service_name
  location = var.region

  template {
    parallelism = var.parallelism
    task_count  = var.task_count

    template {
      max_retries = var.max_retries
      timeout     = var.task_timeout

      service_account = var.service_account != "" ? var.service_account : null

      dynamic "vpc_access" {
        for_each = var.vpc_connector != "" ? [1] : []
        content {
          connector = var.vpc_connector
          egress    = "PRIVATE_RANGES_ONLY"
        }
      }

      containers {
        image = var.image

        resources {
          limits = {
            cpu    = var.cpu
            memory = var.memory
          }
        }

        dynamic "env" {
          for_each = var.env_vars
          content {
            name  = env.key
            value = env.value
          }
        }
      }
    }
  }

  labels = merge(var.labels, {
    managed-by  = "bcim"
    environment = var.environment
  })

  lifecycle {
    ignore_changes = [
      template[0].template[0].containers[0].image,
    ]
  }
}
