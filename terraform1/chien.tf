provider "google" {
  project = "first-parser-314619"
  credentials = "account.json"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "default" {
  name         = "chien"
  machine_type = "f1-micro"

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

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  resource "google_compute_subnetwork" "prod-dmz" {
    name          = "prod-dmz"
    ip_cidr_range = "192.168.65.0/24"
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
