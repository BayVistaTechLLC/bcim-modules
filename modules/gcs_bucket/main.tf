# GCS Bucket
# Managed by BCIM — do not edit manually

resource "google_storage_bucket" "bucket" {
  name     = var.bucket_name
  location = var.region

  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access

  versioning {
    enabled = var.versioning
  }

  dynamic "retention_policy" {
    for_each = var.retention_period_days != null ? [1] : []
    content {
      retention_period = var.retention_period_days * 86400
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type          = lookup(lifecycle_rule.value.action, "type", "Delete")
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                = lookup(lookup(lifecycle_rule.value, "condition", {}), "age", null)
        num_newer_versions = lookup(lookup(lifecycle_rule.value, "condition", {}), "num_newer_versions", null)
      }
    }
  }

  dynamic "cors" {
    for_each = var.cors
    content {
      origin          = lookup(cors.value, "origin", null)
      method          = lookup(cors.value, "method", null)
      response_header = lookup(cors.value, "response_header", null)
      max_age_seconds = lookup(cors.value, "max_age_seconds", null)
    }
  }

  labels = merge(var.labels, {
    managed-by  = "bcim"
    environment = var.environment
  })
}
