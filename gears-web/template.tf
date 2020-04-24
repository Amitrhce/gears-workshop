resource "google_compute_instance_template" "caddy_v1" {
    for_each = var.vpc_regions

    name = "caddy-${each.value}-v1"
    region = each.value
    machine_type = "f1-micro"

    disk {
        source_image = var.caddy_base_image
    }

    network_interface {
        subnetwork = "https://www.googleapis.com/compute/v1/projects/${var.vpc_project}-${var.environment}/regions/${each.value}/subnetworks/${var.vpc_name}-${var.environment}-${each.value}"
    }

    metadata = {
        startup-script-url = "gs://gears-deploy/caddy/${var.environment}/startup.sh"
    }

    service_account {
        email = google_service_account.caddy.email
        scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    }

    tags = ["web"]
}