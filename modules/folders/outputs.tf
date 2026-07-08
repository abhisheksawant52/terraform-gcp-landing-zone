output "folder_ids" {
  description = "Map of folder display name to folder ID."
  value       = { for k, v in google_folder.this : k => v.folder_id }
}

output "folder_names" {
  description = "Map of folder display name to resource name."
  value       = { for k, v in google_folder.this : k => v.name }
}
