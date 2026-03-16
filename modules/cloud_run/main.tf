# Cloud Run Service
# Managed by BCIM — do not edit manually

resource "google_cloud_run_v2_service" "service" {
  name     = var.service_name
  location = var.region

  template {
    scaling {
      min_instance_count = var.min_instances
      max_instance_count = var.max_instances
    }

    dynamic "vpc_access" {
      for_each = var.vpc_connector != "" ? [1] : []
      content {
        connector = var.vpc_connector
        egress    = "PRIVATE_RANGES_ONLY"
      }
    }

    service_account = var.service_account != "" ? var.service_account : null

    containers {
      image = var.image

      ports {
        container_port = var.port
      }

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

  ingress = lookup(
    {
      "all"                    = "INGRESS_TRAFFIC_ALL"
      "internal"               = "INGRESS_TRAFFIC_INTERNAL_ONLY"
      "internal-load-balancer" = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"
    },
    var.ingress,
    "INGRESS_TRAFFIC_ALL"
  )

  labels = merge(var.labels, {
    managed-by  = "bcim"
    environment = var.environment
  })

  lifecycle {
    ignore_changes = [
      template[0].containers[0].image,
    ]
  }
}
