variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "action_role_permissions" {
  description = "List of IAM permissions for the custom role"
  type        = list(string)
}
