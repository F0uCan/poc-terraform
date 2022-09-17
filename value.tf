# Variables to environment 


variable "environment" { 
  type = map
  default = {
    project = "natural-broker-359400"
    region = "us-central1"
    zone = "us-central1-c"
    }
}

variable "network" {
  type = map
  default = {
    name_vpc = "foucan-network"
    subnet_name = "foucan-subnet"
    ip_range = "172.16.20.0/23"
    router_name = "foucan-router"
    nat_name = "foucan-nat"
  }
}

variable "instance" {
  type = map
  default = {
    instance_name = "foucan-instance"
    machine_type = "f1-micro"
    bucket_name = "9ab4faa2-a681-42a8-a4bc-5c2591b666ce"
  }
}

variable "gke" {
  type = map
  default = {
    cluster_name = "foucan-cluster"
    services_ip_range = "192.168.48.0/20"   // IP to services with seccondary subnet.  
    pod_ip_range = "192.168.32.0/20"        // IP to pods with seccondary subnet.
    master_ip_block = "172.16.0.48/28"       // IP to control painel.
    pool_name = "pool-1"
    machine_type = "e2-micro"
    service_account_name = "gke-service-account"
  }
  
}
