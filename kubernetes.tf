# Create service account to gke
resource "google_service_account" "gke_service_account" {
  depends_on = [
    google_compute_subnetwork.subnet
  ]
  account_id   = var.gke.service_account_name
  display_name = "GKE service account"
}
# Create cluster
resource "google_container_cluster" "primary" {
  name     = var.gke.cluster_name
  location = var.environment.zone
  depends_on = [
    google_compute_subnetwork.subnet
  ]
  addons_config {
    network_policy_config {
      disabled = true
    }
  }

########################################################################
# I need to study how I can use a specific IP to pods and services...
  ip_allocation_policy {
#    cluster_ipv4_cidr_block       = "192.168.32.0/20"
#    cluster_secondary_range_name  = "pod-ranges"
#    services_ipv4_cidr_block      = "192.168.48.0/20"
#    services_secondary_range_name = "services-range"
  }
########################################################################

  remove_default_node_pool = true
  initial_node_count       = 1
  network = google_compute_network.net.self_link
  subnetwork = google_compute_subnetwork.subnet.self_link

  network_policy {
    enabled  = false
    provider = "PROVIDER_UNSPECIFIED"
  }

  networking_mode = "VPC_NATIVE"

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true

    master_global_access_config {
      enabled = false
    }
    master_ipv4_cidr_block = var.gke.master_ip_block
  }
}

# Creating node pool
resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = var.gke.pool_name
  location   = var.environment.zone
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = var.gke.machine_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.gke_service_account.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}