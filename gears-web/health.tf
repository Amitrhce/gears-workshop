resource "google_compute_health_check" "caddy" {
    name = "caddy"
    timeout_sec = 5
    check_interval_sec = 5
    healthy_threshold = 2
    unhealthy_threshold = 10

    http_health_check {
        request_path = "/healthz"
        host = "health.gearsworkshop.cloud"
        port_name = "http"
    }
}