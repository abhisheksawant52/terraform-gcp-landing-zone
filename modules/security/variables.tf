variable "org_id" {
  description = "GCP organization ID (numeric)."
  type        = string
}

variable "org_prefix" {
  description = "Short organization prefix for naming."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "billing_account" {
  description = "Billing account ID for the logging project."
  type        = string
}

variable "log_retention_days" {
  description = "Retention, in days, for the log bucket."
  type        = number
  default     = 365
}

variable "org_admins" {
  description = "Members granted organization security-reviewer role."
  type        = list(string)
  default     = []
}
