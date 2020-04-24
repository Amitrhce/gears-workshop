resource "google_compute_firewall" "allow-ssh" {
    name = "${var.vpc_name}-allow-ssh"
    network = google_compute_network.gears_vpc.name
    
    allow {
        protocol = "tcp"
        ports = ["22"]
    }

    source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-http" {
    name = "${var.vpc_name}-allow-http"
    network = google_compute_network.gears_vpc.name

    allow {
        protocol = "tcp"
        ports = ["80", "443"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["web"]
}