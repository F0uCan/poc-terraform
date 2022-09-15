# Variables to environment 

variable "environment" { 
  type = map
  default = {
    project = "XXXXXXXXXXX"
    region = "XXXXXXXX"
    zone = "XXXXXXX"
    }
}

variable "network" {
  type = map
  default = {
    name_vpc = "name-network"
    subnet_name = "name-subnet"
    ip_range = "172.16.20.0/23"
    router_name = "name-router"
    nat_name = "name-nat"
  }
}

variable "instance" {
  type = map
  default = {
    instance_name = "name-instance"
    machine_type = "f1-micro"
    bucket_name = "XXXXXXXX-XXXXXX-XXXXX"
  }
}

variable "gke" {
  type = map
  default = {
    cluster_name = "cluster name"
    services_ip_range = "192.168.48.0/20"   // IP to services with seccondary subnet.  
    pod_ip_range = "192.168.32.0/20"        // IP to pods with seccondary subnet.
    master_ip_block = "172.16.0.48/28"       // IP to control painel.
    pool_name = "pool-1"
    machine_type = "e2-micro"
    service_account_name = "gke-service-account"
  }
  
}
