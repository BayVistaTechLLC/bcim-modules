variable "service_name" {
  description = "Job name"
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

variable "image" {
  description = "Container image URI"
  type        = string
}

variable "cpu" {
  description = "CPU allocation"
  type        = string
  default     = "1"
}

variable "memory" {
  description = "Memory allocation"
  type        = string
  default     = "512Mi"
}

variable "max_retries" {
  description = "Maximum retries per task"
  type        = number
  default     = 3
}

variable "task_timeout" {
  description = "Task timeout"
  type        = string
  default     = "600s"
}

variable "parallelism" {
  description = "Number of tasks to run in parallel"
  type        = number
  default     = 1
}

variable "task_count" {
  description = "Total number of tasks"
  type        = number
  default     = 1
}

variable "env_vars" {
  description = "Environment variables map"
  type        = map(string)
  default     = {}
}

variable "service_account" {
  description = "Service account email"
  type        = string
  default     = ""
}

variable "vpc_connector" {
  description = "VPC connector name"
  type        = string
  default     = ""
}

variable "labels" {
  description = "Additional labels"
  type        = map(string)
  default     = {}
}
