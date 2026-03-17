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

variable "keyring_name" {
  description = "Key ring name"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,61}[a-z0-9]$", var.keyring_name))
    error_message = "Keyring name must be lowercase alphanumeric with hyphens, 3-63 chars."
  }
}

variable "crypto_key_name" {
  description = "Crypto key name (defaults to {keyring_name}-key)"
  type        = string
  default     = ""
}

variable "purpose" {
  description = "Key purpose"
  type        = string
  default     = "ENCRYPT_DECRYPT"

  validation {
    condition     = contains(["ENCRYPT_DECRYPT", "ASYMMETRIC_SIGN", "ASYMMETRIC_DECRYPT"], var.purpose)
    error_message = "Purpose must be ENCRYPT_DECRYPT, ASYMMETRIC_SIGN, or ASYMMETRIC_DECRYPT."
  }
}

variable "rotation_period" {
  description = "Key rotation period (e.g., '7776000s' for 90 days)"
  type        = string
  default     = null
}

variable "protection_level" {
  description = "Protection level"
  type        = string
  default     = "SOFTWARE"

  validation {
    condition     = contains(["SOFTWARE", "HSM"], var.protection_level)
    error_message = "Protection level must be SOFTWARE or HSM."
  }
}

variable "destroy_scheduled_duration" {
  description = "Duration before scheduled destruction"
  type        = string
  default     = "86400s"
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}
