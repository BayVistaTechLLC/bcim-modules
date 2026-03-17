variable "service_name" {
  description = "Instance name"
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

variable "machine_type" {
  description = "Machine type"
  type        = string
  default     = "e2-medium"
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  type        = number
  default     = 20
}

variable "image_family" {
  description = "Image family"
  type        = string
  default     = "debian-12"
}

variable "image_project" {
  description = "Image project"
  type        = string
  default     = "debian-cloud"
}

variable "network" {
  description = "VPC network"
  type        = string
  default     = "default"
}

variable "subnet" {
  description = "Subnetwork (empty = auto)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Network tags"
  type        = list(string)
  default     = []
}

variable "startup_script" {
  description = "Startup script content"
  type        = string
  default     = ""
}

variable "service_account" {
  description = "Service account email"
  type        = string
  default     = ""
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}
