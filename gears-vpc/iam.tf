data "google_project" "gears_project" {
    for_each = var.service_projects

    project_id = "${each.value}-${var.environment}"
}

resource "google_compute_subnetwork_iam_member" "gears_vpc" {
    for_each = {
        for pair in setproduct(var.vpc_regions, var.service_projects) : "${pair[0]}.${pair[1]}" => pair
    }

    subnetwork = "https://www.googleapis.com/compute/v1/projects/${var.gcp_project}-${var.environment}/regions/${each.value[0]}/subnetworks/${var.vpc_name}-${var.environment}-${each.value[0]}"
    role = "roles/compute.networkUser"
    member = "serviceAccount:${data.google_project.gears_project[each.value[1]].number}@cloudservices.gserviceaccount.com"
}

data "google_project" "gears_gke_project" {
    project_id = "gears-gke-${var.environment}"
}

resource "google_compute_subnetwork_iam_member" "gears_gke" {
    subnetwork = google_compute_subnetwork.gears_vpc_gke_subnet.self_link
    role = "roles/compute.networkUser"
    member = "serviceAccount:${data.google_project.gears_gke_project.number}@cloudservices.gserviceaccount.com"
}

resource "google_compute_subnetwork_iam_member" "gears_gke_robot" {
    subnetwork = google_compute_subnetwork.gears_vpc_gke_subnet.self_link
    role = "roles/compute.networkUser"
    member = "serviceAccount:service-${data.google_project.gears_gke_project.number}@container-engine-robot.iam.gserviceaccount.com"
}