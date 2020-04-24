resource "google_compute_router" "nat" {
    count = length(var.vpc_regions)

    name = "nat-${var.vpc_regions[count.index]}"
    region = var.vpc_regions[count.index]
    network = google_compute_network.gears_vpc.self_link
}

resource "google_compute_router_nat" "nat" {
    count = length(var.vpc_regions)

    name = "nat-${var.vpc_regions[count.index]}"
    router = google_compute_router.nat[count.index].name
    region = google_compute_router.nat[count.index].region
    nat_ip_allocate_option = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}