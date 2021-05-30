provider "google" {
  project = "first-parser-314619"
  credentials = "account.json"
  region  = "us-central1"
  zone    = "us-central1-c"
}

description = "vm"
resource "google_compute_instance" "chien" {
  name         = "chien"
  machine_type = "f1-micro"
  tags         = ["public"]

    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-10"
      }
    }

    network_interface {
      subnetwork = google_compute_subnetwork.prod-dmz.name
      access_config {
      }
    }

  metadata_startup_script = "apt-get -y update && apt-get -y upgrade && apt-get -y install apache2 && systemctl start apache2"
}

resource "google_compute_instance" "chat" {
  name         = "chat"
  machine_type = "f1-micro"


  boot_disk {
    initialize_params {
      image = "CoreOS 2514.1.0"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.prod-interne.name
    access_config {
    }
  }
}

resource "google_compute_instance" "hamster" {
    name         = "hamster"
    machine_type = "f1-micro"

    boot_disk {
      initialize_params {
        image = "CoreOS 2514.1.0"
      }
    }

    network_interface {
      subnetwork = google_compute_subnetwork.prod-traitement.name
      access_config {
      }
    }
}

resource "google_compute_instance" "perroquet" {
    name         = "perroquet"
    machine_type = "f1-micro"

    boot_disk {
      initialize_params {
        image = "ubuntu 16.04"
    }
  }
}
