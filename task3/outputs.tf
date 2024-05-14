# outputs
# eu vpn ip address
output "eu-vpn-ip" {
  value = google_compute_address.eu-vpn-ip.address
}

# asia vpn ip address
output "asia-vpn-ip" {
  value = google_compute_address.asia-vpn-ip.address
}

# eu internal ip address
output "eu-internal-ip" {
  value = google_compute_instance.eu-instance.network_interface.0.network_ip
}
