output "public_ip" {
  value = google_compute_instance.task2.network_interface[0].access_config[0].nat_ip
}

output "vpc" {
  value = google_compute_network.task2_vpc.name
}

output "subnet" {
  value = google_compute_subnetwork.task2_subnet.name
}

output "internal_ip" {
  value = google_compute_instance.task2.network_interface[0].network_ip
}



