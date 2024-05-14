# eu vpn gateway
resource "google_compute_vpn_gateway" "eu-vpn-gw" {
  name    = "eu-vpn-gw"
  network = google_compute_network.eu-vpc.id
  region  = var.eu-vpc.eu-subnet.region
}

# asia vpn gateway
resource "google_compute_vpn_gateway" "asia-vpn-gw" {
  name    = "asia-vpn-gw"
  network = google_compute_network.asia-vpc.id
  region  = var.asia-vpc.asia-subnet.region
}

# external IP for eu vpn gateway
resource "google_compute_address" "eu-vpn-ip" {
  name   = "eu-vpn-ipv4"
  region = var.eu-vpc.eu-subnet.region
}

# external IP for asia vpn gateway
resource "google_compute_address" "asia-vpn-ip" {
  name   = "asia-vpn-ipv4"
  region = var.asia-vpc.asia-subnet.region
}

# google secret manager secret
data "google_secret_manager_secret_version" "vpn-secret" {
  secret  = "vpn-shared-secret"
  version = "latest"
}

# vpn tunnel from asia to eu
resource "google_compute_vpn_tunnel" "asia-to-eu" {
  name          = "asia-to-eu"
  region        = var.asia-vpc.asia-subnet.region
  peer_ip       = google_compute_address.eu-vpn-ip.address
  shared_secret = data.google_secret_manager_secret_version.vpn-secret.secret_data
  ike_version   = 2

  # target vpn is current vpn gateway
  target_vpn_gateway = google_compute_vpn_gateway.asia-vpn-gw.id

  local_traffic_selector  = [var.asia-vpc.asia-subnet.cidr]
  remote_traffic_selector = [var.eu-vpc.eu-subnet.cidr]

  # depends on forwarding rules
  depends_on = [google_compute_forwarding_rule.asia-esp,
    google_compute_forwarding_rule.asia-udp-500,
  google_compute_forwarding_rule.asia-udp-4500]
}

# route for asia to eu
resource "google_compute_route" "asia-to-eu" {
  depends_on          = [google_compute_vpn_tunnel.asia-to-eu]
  name                = "asia-to-eu"
  network             = google_compute_network.asia-vpc.id
  dest_range          = var.eu-vpc.eu-subnet.cidr
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.asia-to-eu.id
  priority            = 1000
}

# asia to eu forwarding rule asia-esp
resource "google_compute_forwarding_rule" "asia-esp" {
  name        = "asia-esp"
  ip_protocol = "ESP"
  region      = var.asia-vpc.asia-subnet.region
  ip_address  = google_compute_address.asia-vpn-ip.address
  # asia gateway target
  target = google_compute_vpn_gateway.asia-vpn-gw.id
}

# asia to eu forwarding rule asia-udp-500
resource "google_compute_forwarding_rule" "asia-udp-500" {
  name        = "asia-udp-500"
  ip_protocol = "UDP"
  port_range  = "500"
  region      = var.asia-vpc.asia-subnet.region
  ip_address  = google_compute_address.asia-vpn-ip.address
  target      = google_compute_vpn_gateway.asia-vpn-gw.id
}

# asia to eu forwarding rule asia-udp-4500
resource "google_compute_forwarding_rule" "asia-udp-4500" {
  name        = "asia-udp-4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  region      = var.asia-vpc.asia-subnet.region
  ip_address  = google_compute_address.asia-vpn-ip.address
  target      = google_compute_vpn_gateway.asia-vpn-gw.id
}

# vpn tunnel from eu to asia
resource "google_compute_vpn_tunnel" "eu-to-asia" {
  name          = "eu-to-asia"
  region        = var.eu-vpc.eu-subnet.region
  peer_ip       = google_compute_address.asia-vpn-ip.address
  shared_secret = data.google_secret_manager_secret_version.vpn-secret.secret_data
  ike_version   = 2

  target_vpn_gateway = google_compute_vpn_gateway.eu-vpn-gw.id

  local_traffic_selector  = [var.eu-vpc.eu-subnet.cidr]
  remote_traffic_selector = [var.asia-vpc.asia-subnet.cidr]

  # depends on forwarding rules
  depends_on = [google_compute_forwarding_rule.eu-esp,
    google_compute_forwarding_rule.eu-udp-500,
  google_compute_forwarding_rule.eu-udp-4500]
}

# route for eu to asia
resource "google_compute_route" "eu-to-asia" {
  depends_on          = [google_compute_vpn_tunnel.asia-to-eu]
  name                = "eu-to-asia"
  network             = google_compute_network.eu-vpc.id
  dest_range          = var.asia-vpc.asia-subnet.cidr
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.eu-to-asia.id
  priority            = 1000
}

# forwarding rule eu-esp
resource "google_compute_forwarding_rule" "eu-esp" {
  name        = "eu-esp"
  ip_protocol = "ESP"
  region      = var.eu-vpc.eu-subnet.region
  ip_address  = google_compute_address.eu-vpn-ip.address
  target      = google_compute_vpn_gateway.eu-vpn-gw.id
}

# forwarding rule eu-udp-500
resource "google_compute_forwarding_rule" "eu-udp-500" {
  name        = "eu-udp-500"
  ip_protocol = "UDP"
  port_range  = "500"
  region      = var.eu-vpc.eu-subnet.region
  ip_address  = google_compute_address.eu-vpn-ip.address
  target      = google_compute_vpn_gateway.eu-vpn-gw.id
}

# forwarding rule eu-udp-4500
resource "google_compute_forwarding_rule" "eu-udp-4500" {
  name        = "eu-udp-4500"
  ip_protocol = "UDP"
  port_range  = "4500"
  region      = var.eu-vpc.eu-subnet.region
  ip_address  = google_compute_address.eu-vpn-ip.address
  target      = google_compute_vpn_gateway.eu-vpn-gw.id
}
