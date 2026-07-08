resource "google_compute_shared_vpc_host_project" "host" {
  project = var.host_project_id
}

resource "google_compute_network" "shared" {
  name                            = "${var.org_prefix}-${var.environment}-shared-vpc"
  project                         = var.host_project_id
  auto_create_subnetworks         = false
  routing_mode                    = "GLOBAL"
  delete_default_routes_on_create = false
}

resource "google_compute_subnetwork" "this" {
  for_each = var.subnets

  name                     = each.key
  project                  = var.host_project_id
  region                   = each.value.region
  network                  = google_compute_network.shared.id
  ip_cidr_range            = each.value.cidr
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

# Cloud NAT for private egress
resource "google_compute_router" "nat" {
  name    = "${var.org_prefix}-${var.environment}-nat-router"
  project = var.host_project_id
  region  = var.subnets[keys(var.subnets)[0]].region
  network = google_compute_network.shared.id
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.org_prefix}-${var.environment}-nat"
  project                            = var.host_project_id
  router                             = google_compute_router.nat.name
  region                             = google_compute_router.nat.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

# Baseline firewall: deny ingress by default, allow internal + IAP SSH.
resource "google_compute_firewall" "allow_internal" {
  name    = "${var.org_prefix}-${var.environment}-allow-internal"
  project = var.host_project_id
  network = google_compute_network.shared.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }

  source_ranges = [for s in var.subnets : s.cidr]
}

resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "${var.org_prefix}-${var.environment}-allow-iap-ssh"
  project = var.host_project_id
  network = google_compute_network.shared.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # IAP TCP forwarding range
  source_ranges = ["35.235.240.0/20"]
}
