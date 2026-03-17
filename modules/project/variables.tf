variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "display_name" {
  description = "Project display name"
  type        = string
}

variable "org_id" {
  description = "GCP organization ID (mutually exclusive with folder_id)"
  type        = string
  default     = ""
}

variable "folder_id" {
  description = "GCP folder ID (mutually exclusive with org_id)"
  type        = string
  default     = ""
}

variable "billing_account" {
  description = "Billing account ID"
  type        = string
}

variable "labels" {
  description = "Project labels"
  type        = map(string)
  default     = {}
}

variable "action_role_permissions" {
  description = "IAM permissions for the BCIM action custom role"
  type        = list(string)
}

variable "minter_sa_email" {
  description = "Minter service account email (for tokenCreator)"
  type        = string
}

variable "admin_group" {
  description = "Admin group email for owner access"
  type        = string
  default     = ""
}

variable "requesting_user" {
  description = "Requesting user email for owner access"
  type        = string
  default     = ""
}

variable "reader_sa_email" {
  description = "Reader service account email (for tokenCreator chain)"
  type        = string
  default     = ""
}

variable "state_bucket" {
  description = "Terraform state bucket name (for action SA access)"
  type        = string
  default     = ""
}

variable "service_apis" {
  description = "GCP APIs to enable"
  type        = list(string)
  default     = []
}

variable "budget_amount" {
  description = "Monthly budget amount in USD"
  type        = number
  default     = 100
}
