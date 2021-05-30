provider "google" {
  project = "first-parser-314619"
  credentials = "account.json"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "default" {
  name         = "perroquet"
  machine_type = "f1-micro"
  zone         = "us-east1-b"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
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
