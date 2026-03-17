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

variable "account_id" {
  description = "Service account ID (6-30 chars)"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.account_id))
    error_message = "Account ID must be 6-30 chars, lowercase alphanumeric with hyphens."
  }
}

variable "display_name" {
  description = "Service account display name"
  type        = string
}

variable "description" {
  description = "Service account description"
  type        = string
  default     = null
}

variable "roles" {
  description = "IAM roles to assign"
  type        = list(string)
  default     = []
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}
