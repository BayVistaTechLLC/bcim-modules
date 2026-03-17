variable "service_name" {
  description = "Cloud SQL instance name"
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

variable "database_version" {
  description = "Database version (e.g., POSTGRES_15, MYSQL_8_0)"
  type        = string
}

variable "tier" {
  description = "Machine tier (e.g., db-f1-micro, db-custom-1-3840)"
  type        = string
  default     = "db-f1-micro"
}

variable "disk_size_gb" {
  description = "Disk size in GB"
  type        = number
  default     = 10
}

variable "availability_type" {
  description = "Availability type: ZONAL or REGIONAL"
  type        = string
  default     = "ZONAL"

  validation {
    condition     = contains(["ZONAL", "REGIONAL"], var.availability_type)
    error_message = "Availability type must be ZONAL or REGIONAL."
  }
}

variable "backup_enabled" {
  description = "Enable automated backups"
  type        = bool
  default     = true
}

variable "private_network" {
  description = "VPC network self-link for private IP (empty = public IP)"
  type        = string
  default     = ""
}

variable "authorized_networks" {
  description = "Authorized network CIDRs (for public IP)"
  type        = list(string)
  default     = []
}

variable "databases" {
  description = "List of database names to create"
  type        = list(string)
  default     = []
}

variable "users" {
  description = "List of database users"
  type = list(object({
    name            = string
    password_secret = optional(string)
  }))
  default = []
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}
