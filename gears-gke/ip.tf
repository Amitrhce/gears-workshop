resource "google_compute_global_address" "caddy" {
    name = "caddy"
}

output "caddy-ip" {
    value = google_compute_global_address.caddy.address
}