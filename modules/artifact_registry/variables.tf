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

variable "repository_id" {
  description = "Repository ID"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,61}[a-z0-9]$", var.repository_id))
    error_message = "Repository ID must be lowercase alphanumeric with hyphens, 3-63 chars."
  }
}

variable "format" {
  description = "Repository format"
  type        = string
  default     = "DOCKER"

  validation {
    condition     = contains(["DOCKER", "MAVEN", "NPM", "PYTHON", "APT", "YUM", "GO", "KFP"], var.format)
    error_message = "Format must be one of: APT, DOCKER, GO, KFP, MAVEN, NPM, PYTHON, YUM."
  }
}

variable "mode" {
  description = "Repository mode"
  type        = string
  default     = "STANDARD_REPOSITORY"

  validation {
    condition     = contains(["STANDARD_REPOSITORY", "REMOTE_REPOSITORY", "VIRTUAL_REPOSITORY"], var.mode)
    error_message = "Mode must be STANDARD_REPOSITORY, REMOTE_REPOSITORY, or VIRTUAL_REPOSITORY."
  }
}

variable "cleanup_policy_dry_run" {
  description = "Cleanup policy dry run mode"
  type        = bool
  default     = true
}

variable "immutable_tags" {
  description = "Enable immutable tags (Docker format only)"
  type        = bool
  default     = false
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}
