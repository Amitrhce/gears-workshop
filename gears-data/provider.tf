provider "google" {
    project = "${var.gcp_project}-${var.environment}"
    credentials = file(var.credentials_file)
}

provider "google-beta" {
    project = "${var.gcp_project}-${var.environment}"
    credentials = file(var.credentials_file)
}