# Artifact Registry Repository
# Managed by BCIM — do not edit manually

resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = var.repository_id
  format        = var.format
  mode          = var.mode

  cleanup_policy_dry_run = var.cleanup_policy_dry_run

  dynamic "docker_config" {
    for_each = var.format == "DOCKER" ? [1] : []
    content {
      immutable_tags = var.immutable_tags
    }
  }

  labels = merge(var.labels, {
    managed-by  = "bcim"
    environment = var.environment
  })
}
