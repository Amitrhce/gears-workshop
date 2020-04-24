resource "google_compute_region_instance_group_manager" "caddy" {
    for_each = var.vpc_regions
    
    name = "caddy-${each.value}"
    base_instance_name = "caddy-${each.value}"
    region = each.value
    
    version {
        name = "caddy-v1"
        instance_template = google_compute_instance_template.caddy_v1[each.value].self_link
    }

    named_port {
        name = "http"
        port = 80
    }

    auto_healing_policies {
        health_check = google_compute_health_check.caddy.self_link
        initial_delay_sec = 300
    }

    update_policy {
        type = "PROACTIVE"
        instance_redistribution_type = "PROACTIVE"
        minimal_action = "REPLACE"
        max_surge_fixed = 3
        max_unavailable_fixed = 3
        min_ready_sec = 300
    }
}
resource "google_compute_region_autoscaler" "caddy" {
    provider = google-beta
    for_each = var.vpc_regions

    name = "caddy-${each.value}"
    region = each.value
    target = google_compute_region_instance_group_manager.caddy[each.value].self_link

    autoscaling_policy {
        min_replicas = var.caddy_min_size
        max_replicas = var.caddy_max_size
        cooldown_period = 300

        cpu_utilization {
            target = 0.8
        }
    }
}