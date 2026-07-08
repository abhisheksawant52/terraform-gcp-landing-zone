variable "org_id" {
  description = "GCP organization ID (numeric)."
  type        = string
}

variable "folders" {
  description = "Top-level folders to create under the organization."
  type        = list(string)
}

variable "allowed_regions" {
  description = "Regions allowed by the resource-location org policy."
  type        = list(string)
}
