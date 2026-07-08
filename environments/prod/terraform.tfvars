org_id          = "123456789012"
billing_account = "0123AB-4567CD-89EF01"
region          = "europe-west1"
environment     = "prod"
org_prefix      = "acme"

folders         = ["Common", "Production", "NonProduction", "Sandbox"]
allowed_regions = ["europe-west1", "europe-west4"]

host_project_id = "acme-prod-shared-vpc-host"
subnets = {
  shared-euw1 = {
    cidr   = "10.30.0.0/20"
    region = "europe-west1"
  }
  workload-euw1 = {
    cidr   = "10.40.0.0/20"
    region = "europe-west1"
  }
  workload-euw4 = {
    cidr   = "10.50.0.0/20"
    region = "europe-west4"
  }
}

log_retention_days = 730
org_admins         = ["group:gcp-security-admins@example.com"]
