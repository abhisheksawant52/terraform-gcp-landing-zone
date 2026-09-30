terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 8.4"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.30"
    }
  }

  # Remote state backend. Configure per environment with a partial backend:
  #   terraform init -backend-config=environments/dev/backend.hcl
  #
  # backend "gcs" {
  #   bucket = "acme-landing-zone-tfstate"
  #   prefix = "landing-zone"
  # }
}
