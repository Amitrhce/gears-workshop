resource "google_service_account" "caddy" {
    account_id = "caddy-server"
    description = "Caddy service account"
}