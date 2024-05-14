# create a us west vpc network
resource "google_compute_network" "us-west-vpc" {
  name                    = var.us-west-vpc.vpc.name
  auto_create_subnetworks = false
}

# create an us-west subnet
resource "google_compute_subnetwork" "us-west-subnet" {
  name                     = var.us-west-vpc.us-west-subnet.name
  ip_cidr_range            = var.us-west-vpc.us-west-subnet.cidr
  region                   = var.us-west-vpc.us-west-subnet.region
  network                  = google_compute_network.us-west-vpc.id
  private_ip_google_access = true
}

# create a firewall to allow http from us-west to europe
resource "google_compute_firewall" "us-west-firewall" {
  name    = var.us-west-vpc.vpc.firewall
  network = google_compute_network.us-west-vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  # direction = "EGRESS"

  target_tags   = ["us-west-http-server", "iap-ssh-allowed"]
  source_ranges = ["0.0.0.0/0", "35.235.240.0/20"]
}

# create a us-west instance
resource "google_compute_instance" "us-west-instance" {
  name         = var.us-west-vpc.us-west-subnet.instance-name
  machine_type = var.machine_types.linux.machine_type
  zone         = var.us-west-vpc.us-west-subnet.zone

  boot_disk {
    initialize_params {
      image = var.machine_types.linux.image
      size  = tonumber(var.machine_types.linux.size)
    }
    auto_delete = true
  }

  network_interface {
    network    = var.us-west-vpc.vpc.name
    subnetwork = var.us-west-vpc.us-west-subnet.name

    # access_config {
    #   // Ephemeral public IP
    # }
  }

  tags = ["us-http-server", "iap-ssh-allowed"]
  # no script needed for this instance
  # metadata_startup_script = file("startup.sh")

}
