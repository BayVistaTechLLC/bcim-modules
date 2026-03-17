variable "service_name" {
  description = "Service name (for BCIM tracking)"
  type        = string
}

variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}

variable "job_name" {
  description = "Scheduler job name"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,61}[a-z0-9]$", var.job_name))
    error_message = "Job name must be lowercase alphanumeric with hyphens, 3-63 chars."
  }
}

variable "schedule" {
  description = "Cron expression"
  type        = string
}

variable "time_zone" {
  description = "Time zone"
  type        = string
  default     = "UTC"
}

variable "target_type" {
  description = "Target type: http or pubsub"
  type        = string
  default     = "http"
}

variable "target_uri" {
  description = "Target URI (for http target type)"
  type        = string
  default     = ""
}

variable "target_cloud_run_service" {
  description = "Cloud Run service name to target (uses data source for URI)"
  type        = string
  default     = ""
}

variable "target_uri_path" {
  description = "Path to append to Cloud Run service URI"
  type        = string
  default     = ""
}

variable "http_method" {
  description = "HTTP method"
  type        = string
  default     = "POST"
}

variable "body" {
  description = "HTTP request body (JSON string)"
  type        = string
  default     = ""
}

variable "retry_count" {
  description = "Number of retries"
  type        = number
  default     = 1
}

variable "attempt_deadline" {
  description = "Attempt deadline"
  type        = string
  default     = "320s"
}

variable "service_account" {
  description = "Service account for OIDC token"
  type        = string
  default     = ""
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}
