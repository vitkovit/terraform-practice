terraform {
  cloud {
    organization = "itisajoke"
    workspaces {
      name = "learn-terraform-gpc"
    }
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  #project = "terrafrom-practice-435506"
  project     = var.project
  # credentials = file(var.credentials_file)
  credentials = var.credentials


}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = var.micro
  #   region       = var.region
  zone = var.zone
  allow_stopping_for_update = true
  #   zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      # image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}