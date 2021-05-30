resource "google_compute_network" "devoir1" {
    name                    = "devoir1"
    auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "prod-dmz" {
  name          = "prod-dmz"
  ip_cidr_range = "192.168.65.0/24"
  network       = google_compute_network.devoir1.self_link
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

resource "google_compute_subnetwork" "prod-prod-traitement" {
      name          = "prod-traitement"
      ip_cidr_range = "10.0.128.0/24"
      network       = google_compute_network.devoir1.self_link
}
