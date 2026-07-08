variable "org_id" {
  description = "GCP organization ID (numeric)."
  type        = string
}

variable "billing_account" {
  description = "Billing account ID to associate with created projects."
  type        = string
}

variable "region" {
  description = "Primary GCP region."
  type        = string
  default     = "europe-west1"
}

variable "environment" {
  description = "Environment name (dev, prod)."
  type        = string
  default     = "dev"
}

variable "org_prefix" {
  description = "Short organization prefix for naming."
  type        = string
  default     = "acme"
}

variable "folders" {
  description = "Top-level folders to create under the organization."
  type        = list(string)
  default     = ["Common", "Production", "NonProduction", "Sandbox"]
}

variable "allowed_regions" {
  description = "Regions allowed by the resource-location org policy."
  type        = list(string)
  default     = ["europe-west1", "europe-west4"]
}

variable "host_project_id" {
  description = "Project ID for the Shared VPC host project."
  type        = string
  default     = "acme-shared-vpc-host"
}

variable "subnets" {
  description = "Shared VPC subnets keyed by name."
  type = map(object({
    cidr   = string
    region = string
  }))
  default = {
    shared-euw1 = {
      cidr   = "10.10.0.0/20"
      region = "europe-west1"
    }
    workload-euw1 = {
      cidr   = "10.20.0.0/20"
      region = "europe-west1"
    }
  }
}

variable "log_retention_days" {
  description = "Retention, in days, for the log bucket."
  type        = number
  default     = 365
}

variable "org_admins" {
  description = "Members granted organization admin bindings (e.g. group:...)."
  type        = list(string)
  default     = []
}
