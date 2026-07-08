output "host_project_id" {
  description = "Shared VPC host project ID."
  value       = google_compute_shared_vpc_host_project.host.project
}

output "network_self_link" {
  description = "Self link of the Shared VPC network."
  value       = google_compute_network.shared.self_link
}

output "subnet_self_links" {
  description = "Map of subnet name to self link."
  value       = { for k, v in google_compute_subnetwork.this : k => v.self_link }
}
