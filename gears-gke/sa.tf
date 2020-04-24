resource "google_service_account" "gears_gke" {
    account_id = "gears-gke"
    description = "GKE service account"
}