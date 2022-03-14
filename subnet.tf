resource "google_compute_subnetwork" "subnet_tarea" {
  name          = "gke-subnet"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.net_tarea.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_compute_network" "net_tarea" {
  name                    = "gke-network"
  auto_create_subnetworks = false
}