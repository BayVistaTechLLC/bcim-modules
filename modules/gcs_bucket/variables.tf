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

variable "bucket_name" {
  description = "GCS bucket name"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "Bucket name must be lowercase alphanumeric with hyphens, 3-63 chars."
  }
}

variable "storage_class" {
  description = "Storage class"
  type        = string
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class)
    error_message = "Storage class must be STANDARD, NEARLINE, COLDLINE, or ARCHIVE."
  }
}

variable "uniform_bucket_level_access" {
  description = "Enable uniform bucket-level access"
  type        = bool
  default     = true
}

variable "versioning" {
  description = "Enable object versioning"
  type        = bool
  default     = false
}

variable "retention_period_days" {
  description = "Retention period in days (null = no retention)"
  type        = number
  default     = null
}

variable "lifecycle_rules" {
  description = "Lifecycle management rules"
  type = list(object({
    action = object({
      type          = string
      storage_class = optional(string)
    })
    condition = optional(object({
      age                = optional(number)
      num_newer_versions = optional(number)
    }), {})
  }))
  default = []
}

variable "cors" {
  description = "CORS configuration"
  type = list(object({
    origin          = optional(list(string))
    method          = optional(list(string))
    response_header = optional(list(string))
    max_age_seconds = optional(number)
  }))
  default = []
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}
