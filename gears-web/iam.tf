resource "google_project_iam_member" "caddy-monitoring" {
    role = "roles/monitoring.metricWriter"
    member = "serviceAccount:${google_service_account.caddy.email}"
}

resource "google_project_iam_member" "caddy-logging" {
    role = "roles/logging.logWriter"
    member = "serviceAccount:${google_service_account.caddy.email}"
}