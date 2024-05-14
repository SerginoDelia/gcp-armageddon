# Create a Google VPC 
resource "google_compute_network" "task2_vpc" {
  project                 = var.project_id
  name                    = var.network_name
  auto_create_subnetworks = false
  mtu                     = 1460
}

# add subnet to the VPC
resource "google_compute_subnetwork" "task2_subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.task2_vpc.id
}

# firewall rule to allow traffic on port 80
resource "google_compute_firewall" "rules" {
  name    = var.firewall_name
  network = google_compute_network.task2_vpc.id

  allow {
    protocol = "tcp"
    ports    = var.ports
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = var.source_ranges
  priority      = 1000
}
