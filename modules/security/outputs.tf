output "logging_project_id" {
  description = "Project ID hosting the log bucket."
  value       = google_project.logging.project_id
}

output "log_bucket_name" {
  description = "Name of the centralized log storage bucket."
  value       = google_storage_bucket.logs.name
}

output "org_sink_writer_identity" {
  description = "Writer identity of the organization log sink."
  value       = google_logging_organization_sink.audit.writer_identity
}
