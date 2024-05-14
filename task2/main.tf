# Create a publically accessible web page with Terraform.  You must complete the following
# 1) Terraform Script with a VPC
# 2) Terraform script must have a VM within your VPC.
# 3) The VM must have the homepage on it.
# 4) The VM must have an publically accessible link to it.
# 5) You must Git Push your script to your Github.
# 6) Outpub file must show 1) Public IP, 2) VPC, 3) Subnet of the VM, 4) Internal IP of the VM.
# https://youtu.be/WELr1J_r8gI
# add compute instance to the VPC

resource "google_compute_instance" "task2" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
    }
    # true by default
    auto_delete = true
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnet_name

    access_config {
      // Ephemeral public IP
    }
  }

  tags = ["http-server"]

  # metadata = {
  #   startup-script-url = "${file("startup.sh")}"
  # }

  metadata_startup_script = file("startup.sh")

  depends_on = [google_compute_network.task2_vpc,
  google_compute_subnetwork.task2_subnet, google_compute_firewall.rules]
}

