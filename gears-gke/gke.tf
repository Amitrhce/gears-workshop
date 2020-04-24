resource "google_container_cluster" "gears_gke" {
    provider = google-beta

    name = "gears-gke"
    location = var.vpc_regions[0]
    remove_default_node_pool = true
    initial_node_count = var.gke_min_size
    network = "https://www.googleapis.com/compute/v1/projects/${var.vpc_project}-${var.environment}/global/networks/${var.vpc_name}-${var.environment}"
    subnetwork = "https://www.googleapis.com/compute/v1/projects/${var.vpc_project}-${var.environment}/regions/${var.vpc_regions[0]}/subnetworks/${var.vpc_name}-${var.environment}-gke"
    enable_shielded_nodes = true

    ip_allocation_policy {
        cluster_secondary_range_name = var.pod_range
        services_secondary_range_name = var.service_range
    }

    addons_config {
        istio_config {
            disabled = false
        }

        cloudrun_config {
            disabled = false
        }

        horizontal_pod_autoscaling {
            disabled = false
        }
    }

    release_channel {
        channel = var.gke_release_channel
    }
}

resource "google_container_node_pool" "gears_gke_pool" {
    name = "gears-gke-pool"
    location = var.vpc_regions[0]
    cluster = google_container_cluster.gears_gke.name
    node_count = var.gke_min_size

    node_config {
        machine_type = "n1-standard-2"
        service_account = google_service_account.gears_gke.email
        oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

        shielded_instance_config {
            enable_secure_boot = true
            enable_integrity_monitoring = true
        }
    }

    management {
        auto_repair = true
        auto_upgrade = true
    }

    autoscaling {
        min_node_count = var.gke_min_size
        max_node_count = var.gke_max_size
    }
}