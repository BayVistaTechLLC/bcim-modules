variable "service_name" {
  description = "Service name (for BCIM tracking and resource naming)"
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

variable "network_name" {
  description = "VPC network name"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,61}[a-z0-9]$", var.network_name))
    error_message = "Network name must be lowercase alphanumeric with hyphens, 3-63 chars."
  }
}

variable "auto_create_subnetworks" {
  description = "Auto-create subnetworks"
  type        = bool
  default     = false
}

variable "routing_mode" {
  description = "Routing mode: REGIONAL or GLOBAL"
  type        = string
  default     = "REGIONAL"

  validation {
    condition     = contains(["REGIONAL", "GLOBAL"], var.routing_mode)
    error_message = "Routing mode must be REGIONAL or GLOBAL."
  }
}

variable "subnets" {
  description = "Subnet configurations"
  type = list(object({
    name                  = string
    cidr                  = optional(string)
    ip_cidr_range         = optional(string)
    region                = optional(string)
    private_google_access = optional(bool, false)
  }))
  default = []
}

variable "firewall_rules" {
  description = "Firewall rule configurations"
  type        = any
  default     = []
}

variable "private_service_connection" {
  description = "Private service connection config"
  type = object({
    address       = string
    prefix_length = number
  })
  default = null
}

variable "nat" {
  description = "Cloud NAT config"
  type        = any
  default     = null
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}
