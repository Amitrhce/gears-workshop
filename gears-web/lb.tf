resource "google_compute_global_address" "caddy" {
    name = "caddy"
}

resource "google_compute_backend_service" "caddy" {
    name = "caddy"
    health_checks = [google_compute_health_check.caddy.self_link]
    connection_draining_timeout_sec = 30
    
    dynamic "backend" {
        iterator = region
        for_each = var.vpc_regions
        content {
            group = google_compute_region_instance_group_manager.caddy[region.value].instance_group
        }
    }
}

resource "google_compute_url_map" "caddy" {
    name = "caddy"
    default_service = google_compute_backend_service.caddy.self_link
}

resource "google_compute_target_http_proxy" "caddy" {
    name = "caddy"
    url_map = google_compute_url_map.caddy.self_link
}

resource "google_compute_managed_ssl_certificate" "caddy" {
    provider = google-beta
    
    name = "caddy"

    managed {
        domains = var.domains
    }
}

resource "google_compute_target_https_proxy" "caddy" {
    provider = google-beta

    name = "caddy"
    url_map = google_compute_url_map.caddy.self_link
    ssl_certificates = [google_compute_managed_ssl_certificate.caddy.self_link]
}

resource "google_compute_global_forwarding_rule" "caddy-http" {
    name = "caddy-http"
    ip_address = google_compute_global_address.caddy.address
    target = google_compute_target_http_proxy.caddy.self_link
    port_range = 80
}

resource "google_compute_global_forwarding_rule" "caddy-https" {
    name = "caddy-https"
    ip_address = google_compute_global_address.caddy.address
    target =  google_compute_target_https_proxy.caddy.self_link
    port_range = 443
}

output "caddy-ip" {
    value = google_compute_global_address.caddy.address
}