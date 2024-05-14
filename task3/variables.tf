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
  default     = "iamagwe-terraform-hw.json"
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

# variable "firewall_name" {
#   type        = string
#   description = "The name of the firewall rule"
#   default     = "firewall-rule"
# }

# variable "source_ranges" {
#   type        = list(string)
#   description = "Source ranges to allow traffic from"
#   # default     = ["172.16.178.0/24", "172.16.179.0/24", "192.168.178.0/24", "10.178.0.0/24"]
#   default = ["0.0.0.0/0"]
# }

variable "ports" {
  type        = list(string)
  description = "Ports to open on the firewall"
  # first array is for ingress, second array is for egress
  default = ["22", "80", "3389"]
}

variable "eu-vpc" {
  type        = map(map(string))
  description = "EU VPC with subnet"
  default = {
    vpc = {
      name     = "eu-vpc"
      firewall = "eu-firewall"
    }
    eu-subnet = {
      instance-name = "eu-vm"
      name          = "eu-subnet"
      cidr          = "10.178.0.0/24"
      region        = "europe-west1"
      zone          = "europe-west1-b"
    }
  }
}


variable "us-vpc" {
  type        = map(map(string))
  description = "US VPC with 2 subnets"
  default = {
    vpc = {
      name     = "us-vpc"
      firewall = "us-firewall"
    }
    us-east-subnet = {
      instance-name = "us-east-vm"
      name          = "us-east-subnet"
      cidr          = "172.16.178.0/24"
      region        = "us-east1"
      zone          = "us-east1-b"
    }
    us-west-subnet = {
      instance-name = "us-west-vm"
      name          = "us-west-subnet"
      cidr          = "172.16.179.0/24"
      region        = "us-west1"
      zone          = "us-west1-b"
    }
  }
}

variable "asia-vpc" {
  type        = map(map(string))
  description = "Asia VPC with 1 subnet"
  default = {
    vpc = {
      name     = "asia-vpc"
      firewall = "asia-firewall"
    }
    asia-subnet = {
      instance-name = "asia-vm"
      name          = "asia-subnet"
      cidr          = "192.168.178.0/24"
      region        = "asia-southeast1"
      zone          = "asia-southeast1-b"
    }
  }
}

variable "us-west-vpc" {
  type        = map(map(string))
  description = "US West VPC with 1 subnets"
  default = {
    vpc = {
      name     = "us-west-vpc"
      firewall = "us-west-firewall"
    }
    us-west-subnet = {
      instance-name = "us-west-vm"
      name          = "us-west-subnet"
      cidr          = "172.16.179.0/24"
      region        = "us-west1"
      zone          = "us-west1-b"
    }
  }
}

variable "windows_image" {
  type        = string
  description = "Windows image to use"
  default     = "projects/windows-cloud/global/images/windows-server-2022-dc-v20240415"
}

variable "linux_image" {
  type        = string
  description = "Linux image to use"
  default     = "debian-cloud/debian-12"
}

variable "machine_types" {
  type        = map(map(string))
  description = "values for the machine types"
  default = {
    windows = {
      image        = "projects/windows-cloud/global/images/windows-server-2022-dc-v20240415"
      size         = "50"
      type         = "pd-balanced"
      machine_type = "n2-standard-4"
    }
    linux = {
      image        = "debian-cloud/debian-12"
      size         = "10"
      type         = "pd-standard"
      machine_type = "e2-medium"
    }
  }
}
