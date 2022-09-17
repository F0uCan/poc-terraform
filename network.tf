# Create network - VPC
resource "google_compute_network" "net" {
  name = var.network.name_vpc
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.network.subnet_name
  network       = google_compute_network.net.id
  ip_cidr_range = var.network.ip_range
  region        = var.environment.region
  depends_on = [
    google_compute_network.net
  ]
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = var.gke.services_ip_range
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = var.gke.pod_ip_range
  }
}

# Create router
resource "google_compute_router" "router" {
  name    = var.network.router_name
  region  = google_compute_subnetwork.subnet.region
  network = google_compute_network.net.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = var.network.nat_name
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = false
    filter = "ERRORS_ONLY"
  }
}

# Create a firewall rule to IAP
resource "google_compute_firewall" "rules" {
  name = "allow-iap"
  network = google_compute_network.net.name
  depends_on = [
    google_compute_network.net
  ]

  allow {
    protocol = "tcp"
    ports = [ "22" ]
  }
  source_tags = [ "iap" ]
  source_ranges = [ "35.235.240.0/20" ]

}

