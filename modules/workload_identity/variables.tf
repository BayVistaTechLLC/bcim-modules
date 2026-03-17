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

variable "pool_id" {
  description = "Workload identity pool ID"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,61}[a-z0-9]$", var.pool_id))
    error_message = "Pool ID must be lowercase alphanumeric with hyphens, 3-63 chars."
  }
}

variable "provider_id" {
  description = "Workload identity provider ID"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,61}[a-z0-9]$", var.provider_id))
    error_message = "Provider ID must be lowercase alphanumeric with hyphens, 3-63 chars."
  }
}

variable "issuer_uri" {
  description = "OIDC issuer URI"
  type        = string
}

variable "allowed_audiences" {
  description = "Allowed audiences"
  type        = list(string)
  default     = []
}

variable "attribute_mapping" {
  description = "Attribute mapping"
  type        = map(string)
  default     = { "google.subject" = "assertion.sub" }
}

variable "service_account_email" {
  description = "Service account email for WIF binding"
  type        = string
  default     = null
}

variable "attribute_condition" {
  description = "CEL expression for attribute condition"
  type        = string
  default     = ""
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}
