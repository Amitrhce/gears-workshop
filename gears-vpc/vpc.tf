#################################
#          NETWORK              #
#################################

resource "google_compute_network" "gears_vpc" {
    name = "${var.vpc_name}-${var.environment}"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gears_vpc_subnet" {
    count = length(var.vpc_regions)

    region = var.vpc_regions[count.index]
    name = "${google_compute_network.gears_vpc.name}-${var.vpc_regions[count.index]}"
    network = google_compute_network.gears_vpc.self_link
    ip_cidr_range = "172.${var.subnet_number}.${count.index}.0/24"
    private_ip_google_access = true
}

resource "google_compute_subnetwork" "gears_vpc_gke_subnet" {
    region = var.vpc_regions[0]
    name = "${google_compute_network.gears_vpc.name}-gke"
    network = google_compute_network.gears_vpc.self_link
    ip_cidr_range = "172.${var.subnet_number}.100.0/24"
    private_ip_google_access = true

    secondary_ip_range {
        range_name = "pods"
        ip_cidr_range = "10.10.0.0/16"
    }

    secondary_ip_range {
        range_name = "services"
        ip_cidr_range = "10.20.0.0/16"
    }
}

#################################
#         SHARED VPC             #
#################################

resource "google_compute_shared_vpc_host_project" "gears_vpc" {
    project = "${var.gcp_project}-${var.environment}"
}

resource "google_compute_shared_vpc_service_project" "gears_vpc" {
    for_each = var.service_projects

    host_project = google_compute_shared_vpc_host_project.gears_vpc.project
    service_project = "${each.value}-${var.environment}"
}