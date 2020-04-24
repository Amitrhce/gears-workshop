resource "google_project_iam_member" "gears_gke_monitoring" {
    role = "roles/monitoring.metricWriter"
    member = "serviceAccount:${google_service_account.gears_gke.email}"
}

resource "google_project_iam_member" "gears_gke_logging" {
    role = "roles/logging.logWriter"
    member = "serviceAccount:${google_service_account.gears_gke.email}"
}