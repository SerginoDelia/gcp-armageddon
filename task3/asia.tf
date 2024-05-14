# create asia vpc network
resource "google_compute_network" "asia-vpc" {
  name                    = var.asia-vpc.vpc.name
  auto_create_subnetworks = false
}

# create an asia subnet
resource "google_compute_subnetwork" "asia-subnet" {
  name                     = var.asia-vpc.asia-subnet.name
  ip_cidr_range            = var.asia-vpc.asia-subnet.cidr
  region                   = var.asia-vpc.asia-subnet.region
  network                  = google_compute_network.asia-vpc.id
  private_ip_google_access = true
}

# create a firewall for asia RDP
resource "google_compute_firewall" "asia-allow-rdp" {
  project = var.project_id
  name    = var.asia-vpc.vpc.firewall
  network = google_compute_network.asia-vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "3389"]
  }

  # direction = "EGRESS"

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["asia-rdp-server"]
}

# resource "google_compute_firewall" "asia" {
#   project = var.project_id
#   name    = "allow-remote"
#   network = google_compute_network.asia-vpc.id

#   # allow {
#   #   protocol = "tcp"
#   #   ports    = var.ports[1]
#   # }
#   # direction     = "EGRESS"
#   # source_ranges = var.source_ranges

#   allow {
#     protocol = "icmp"
#   }

#   allow {
#     protocol = "tcp"
#     ports    = ["80", "22", "3389"]
#   }

#   source_ranges = ["0.0.0.0/0"]
# }

# create an asia instance windows machine
resource "google_compute_instance" "asia-instance" {
  name         = var.asia-vpc.asia-subnet.instance-name
  machine_type = var.machine_types.windows.machine_type
  zone         = var.asia-vpc.asia-subnet.zone

  boot_disk {
    initialize_params {
      image = var.machine_types.windows.image
      size  = tonumber(var.machine_types.windows.size)
    }
    auto_delete = true
  }

  network_interface {
    network    = google_compute_network.asia-vpc.id
    subnetwork = google_compute_subnetwork.asia-subnet.id

    # External IP
    access_config {
      // Ephemeral public IP
    }
  }

  tags = ["asia-rdp-server"]
}
