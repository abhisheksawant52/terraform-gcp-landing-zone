resource "google_project" "logging" {
  name            = "${var.org_prefix}-${var.environment}-logging"
  project_id      = "${var.org_prefix}-${var.environment}-logging"
  org_id          = var.org_id
  billing_account = var.billing_account
}

resource "google_storage_bucket" "logs" {
  name                        = "${var.org_prefix}-${var.environment}-org-logs"
  project                     = google_project.logging.project_id
  location                    = "EU"
  uniform_bucket_level_access = true
  force_destroy               = false

  lifecycle_rule {
    condition {
      age = var.log_retention_days
    }
    action {
      type = "Delete"
    }
  }

  versioning {
    enabled = true
  }
}

# Organization-wide aggregated log sink to the central bucket.
resource "google_logging_organization_sink" "audit" {
  name             = "${var.org_prefix}-org-audit-sink"
  org_id           = var.org_id
  destination      = "storage.googleapis.com/${google_storage_bucket.logs.name}"
  include_children = true

  filter = "logName:\"cloudaudit.googleapis.com\""
}

# Grant the sink's writer identity permission to write to the bucket.
resource "google_storage_bucket_iam_member" "sink_writer" {
  bucket = google_storage_bucket.logs.name
  role   = "roles/storage.objectCreator"
  member = google_logging_organization_sink.audit.writer_identity
}

# Baseline organization IAM: security admins group.
resource "google_organization_iam_member" "security_admins" {
  for_each = toset(var.org_admins)

  org_id = var.org_id
  role   = "roles/iam.securityReviewer"
  member = each.value
}
