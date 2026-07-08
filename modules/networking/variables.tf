variable "host_project_id" {
  description = "Project ID for the Shared VPC host project."
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

variable "subnets" {
  description = "Shared VPC subnets keyed by name."
  type = map(object({
    cidr   = string
    region = string
  }))
}
