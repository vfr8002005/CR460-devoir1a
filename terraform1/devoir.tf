provider "google" {
  project = "first-parser-314619"
  credentials = "account.json"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "chien" {
  name         = "chien"
  machine_type = "f1-micro"
  tags         = ["public"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  metadata_startup_script = "apt-get -y update && apt-get -y upgrade && apt-get -y install apache2 && systemctl start apache2"
}

resource "google_compute_network" "devoir1" {
    name                    = "devoir1"
    auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "prod-dmz" {
  name          = "prod-dmz"
  ip_cidr_range = "192.168.65.0/24"
  network       = google_compute_network.devoir1.self_link
}

resource "google_compute_instance" "chat" {
  name         = "chat"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "CoreOS 2514.1.0"
  }
}

resource "google_compute_subnetwork" "prod-interne" {
    name          = "prod-interne"
    ip_cidr_range = "172.16.20.0/24"
    network       = google_compute_network.devoir1.self_link
}

resource "google_compute_firewall" "ssh-public" {
    name    = "ssh-public"
    network = google_compute_network.devoir1.name
    allow {
      protocol = "tcp"
      ports    = ["4444", "5126"]
    }
    source_ranges = "10.0.128.0/24"
    target_tags=["public"]
}

resource "google_compute_instance" "hamster" {
    name         = "hamster"
    machine_type = "f1-micro"

    boot_disk {
      initialize_params {
        image = "CoreOS 2514.1.0"
  }
}

resource "google_compute_subnetwork" "prod-prod-traitement" {
      name          = "prod-traitement"
      ip_cidr_range = "10.0.128.0/24"
      network       = google_compute_network.devoir1.self_link
}

resource "google_compute_instance" "perroquet" {
    name         = "perroquet"
    machine_type = "f1-micro"

    boot_disk {
      initialize_params {
        image = "ubuntu 16.04"
  }
}


  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
  }
}
