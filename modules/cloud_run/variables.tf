variable "service_name" {
  description = "Name of the Cloud Run service"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,61}[a-z0-9]$", var.service_name))
    error_message = "Service name must be lowercase alphanumeric with hyphens, 3-63 chars."
  }
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

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be development, staging, or production."
  }
}

variable "image" {
  description = "Container image URI"
  type        = string
}

variable "port" {
  description = "Container port"
  type        = number
  default     = 8080
}

variable "cpu" {
  description = "CPU allocation (e.g., '1', '2')"
  type        = string
  default     = "1"
}

variable "memory" {
  description = "Memory allocation (e.g., '512Mi', '1Gi')"
  type        = string
  default     = "512Mi"
}

variable "min_instances" {
  description = "Minimum number of instances"
  type        = number
  default     = 0
}

variable "max_instances" {
  description = "Maximum number of instances"
  type        = number
  default     = 10
}

variable "env_vars" {
  description = "Environment variables map"
  type        = map(string)
  default     = {}
}

variable "service_account" {
  description = "Service account email (empty string = default)"
  type        = string
  default     = ""
}

variable "vpc_connector" {
  description = "VPC connector name (empty string = no VPC access)"
  type        = string
  default     = ""
}

variable "ingress" {
  description = "Ingress setting"
  type        = string
  default     = "all"

  validation {
    condition     = contains(["all", "internal", "internal-load-balancer"], var.ingress)
    error_message = "Ingress must be all, internal, or internal-load-balancer."
  }
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}
