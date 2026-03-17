# Cloud Scheduler
# Managed by BCIM — do not edit manually

data "google_cloud_run_v2_service" "target" {
  count    = var.target_cloud_run_service != "" ? 1 : 0
  name     = var.target_cloud_run_service
  location = var.region
}

locals {
  target_cloud_run_uri = var.target_cloud_run_service != "" ? data.google_cloud_run_v2_service.target[0].uri : ""
  resolved_uri = var.target_cloud_run_service != "" ? "${local.target_cloud_run_uri}${var.target_uri_path}" : var.target_uri
  sa_email     = length(regexall("@", var.service_account)) > 0 ? var.service_account : "${var.service_account}@${var.project}.iam.gserviceaccount.com"
}

resource "google_cloud_scheduler_job" "job" {
  name      = var.job_name
  region    = var.region
  schedule  = var.schedule
  time_zone = var.time_zone

  retry_config {
    retry_count = var.retry_count
  }

  attempt_deadline = var.attempt_deadline

  dynamic "http_target" {
    for_each = local.resolved_uri != "" ? [1] : []
    content {
      uri         = local.resolved_uri
      http_method = var.http_method

      body    = var.body != "" ? base64encode(var.body) : null
      headers = var.body != "" ? { "Content-Type" = "application/json" } : null

      dynamic "oidc_token" {
        for_each = var.service_account != "" ? [1] : []
        content {
          service_account_email = local.sa_email
        }
      }
    }
  }
}
