locals {
  org_parent = "organizations/${var.org_id}"
}

module "folders" {
  source = "./modules/folders"

  org_id          = var.org_id
  folders         = var.folders
  allowed_regions = var.allowed_regions
}

module "networking" {
  source = "./modules/networking"

  host_project_id = var.host_project_id
  org_prefix      = var.org_prefix
  environment     = var.environment
  subnets         = var.subnets
}

module "security" {
  source = "./modules/security"

  org_id             = var.org_id
  org_prefix         = var.org_prefix
  environment        = var.environment
  billing_account    = var.billing_account
  log_retention_days = var.log_retention_days
  org_admins         = var.org_admins
}
