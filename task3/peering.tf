# VPC Peering from us to eu
resource "google_compute_network_peering" "us-to-eu" {
  name         = "us-to-eu"
  network      = google_compute_network.us-vpc.id
  peer_network = google_compute_network.eu-vpc.id
}

# VPC Peering from eu to us
resource "google_compute_network_peering" "eu-to-us" {
  name         = "eu-to-us"
  network      = google_compute_network.eu-vpc.id
  peer_network = google_compute_network.us-vpc.id
}

# VPC Peering from us west to eu
resource "google_compute_network_peering" "uswest-to-eu" {
  name         = "uswest-to-eu"
  network      = google_compute_network.us-west-vpc.id
  peer_network = google_compute_network.eu-vpc.id
}

# VPC Peering from eu to us west
resource "google_compute_network_peering" "eu-to-uswest" {
  name         = "eu-to-uswest"
  network      = google_compute_network.eu-vpc.id
  peer_network = google_compute_network.us-west-vpc.id
}
