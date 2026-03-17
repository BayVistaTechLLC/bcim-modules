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

variable "connector_name" {
  description = "VPC connector name"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,61}[a-z0-9]$", var.connector_name))
    error_message = "Connector name must be lowercase alphanumeric with hyphens, 3-63 chars."
  }
}

variable "network" {
  description = "VPC network name"
  type        = string
  default     = "default"
}

variable "ip_cidr_range" {
  description = "IP CIDR range for connector"
  type        = string
}

variable "min_throughput" {
  description = "Minimum throughput (Mbps)"
  type        = number
  default     = 200
}

variable "max_throughput" {
  description = "Maximum throughput (Mbps)"
  type        = number
  default     = 300
}

variable "machine_type" {
  description = "Machine type for connector instances"
  type        = string
  default     = "e2-micro"
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}
