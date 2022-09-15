provider "google" {
  project = var.environment.project
  region  = var.environment.region
  zone    = var.environment.zone
}

# # Create a VM
# resource "google_compute_instance" "vm_instance" {
#   name         = var.instance.instance_name
#   machine_type = var.instance.machine_type
#   tags = [ "iap" ]
#   depends_on = [
#     google_compute_network.net
#   ]

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-10"
#     }
#   }

#   network_interface {
#     # A default network is created for all GCP projects
#     #network = google_compute_network.net.self_link
#     subnetwork = google_compute_subnetwork.subnet.self_link

    # External IP
#    access_config {
#    }
#   }
# }

# Create a bucket
# resource "google_compute_backend_bucket" "image_backend" {
#   name        = "image-backend-bucket"
#   description = "Contains beautiful images"
#   bucket_name = google_storage_bucket.image_bucket.name
#   enable_cdn  = true
# }

# resource "google_storage_bucket" "image_bucket" {
#   name     = var.instance.bucket_name
#   location = "US"
# }