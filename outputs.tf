output "folder_ids" {
  description = "Map of folder name to folder ID."
  value       = module.folders.folder_ids
}

output "host_project_id" {
  description = "Shared VPC host project ID."
  value       = module.networking.host_project_id
}

output "shared_vpc_network" {
  description = "Self link of the Shared VPC network."
  value       = module.networking.network_self_link
}

output "subnet_self_links" {
  description = "Map of subnet name to self link."
  value       = module.networking.subnet_self_links
}

output "log_bucket_name" {
  description = "Name of the centralized log storage bucket."
  value       = module.security.log_bucket_name
}
