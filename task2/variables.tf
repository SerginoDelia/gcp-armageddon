# project     = var.project_id
#   region      = var.region
#   zone        = var.zone
#   credentials = var.credentials

variable "project_id" {
  type        = string
  description = "The project ID to deploy resources"
  default     = "iamagwe"
}

variable "region" {
  type        = string
  description = "The region to deploy resources"
  default     = "us-east1"
}

variable "zone" {
  type        = string
  description = "The zone to deploy resources"
  default     = "us-east1-b"
}

variable "credentials" {
  type        = string
  description = "The path to the service account key file"
  default     = "iamagwe-40a98105e9fd.json"
}

variable "location" {
  type        = string
  description = "The location to deploy resources"
  default     = "US"
}

variable "google_bucket_url" {
  type        = string
  description = "Google storage bucket URL"
  default     = "https://storage.googleapis.com/"
}

variable "network_name" {
  type        = string
  description = "The name of the network"
  default     = "task2-network"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
  default     = "task2-subnet"
}

variable "ip_cidr_range" {
  type        = string
  description = "IP CIDR range for the subnet"
  default     = "10.178.0.0/24"
}

variable "firewall_name" {
  type        = string
  description = "The name of the firewall rule"
  default     = "firewall-rule"
}

variable "ports" {
  type        = list(string)
  description = "Ports to open on the firewall"
  default     = ["22", "80", "443"]
}

variable "source_ranges" {
  type        = list(string)
  description = "Source ranges to allow traffic from"
  default     = ["0.0.0.0/0"]
}

variable "machine_type" {
  type        = string
  description = "The machine type for the compute instance"
  default     = "e2-medium"
}

variable "instance_name" {
  type        = string
  description = "The name of the compute instance"
  default     = "task2-instance"
}
