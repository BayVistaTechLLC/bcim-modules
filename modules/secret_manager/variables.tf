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

variable "secret_id" {
  description = "Secret Manager secret ID"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,61}[a-z0-9]$", var.secret_id))
    error_message = "Secret ID must be lowercase alphanumeric with hyphens, 3-63 chars."
  }
}

variable "replication_type" {
  description = "Replication type: automatic or user_managed"
  type        = string
  default     = "automatic"

  validation {
    condition     = contains(["automatic", "user_managed"], var.replication_type)
    error_message = "Replication type must be automatic or user_managed."
  }
}

variable "replication_locations" {
  description = "Replication locations (required when replication_type is user_managed)"
  type        = list(string)
  default     = []
}

variable "rotation_period" {
  description = "Rotation period (e.g., '2592000s' for 30 days)"
  type        = string
  default     = null
}

variable "expire_time" {
  description = "Expiration timestamp (RFC 3339)"
  type        = string
  default     = null
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}
