terraform {
    backend "gcs" {
        bucket = "gears-deploy"
        credentials = "../accounts/gears-deploy.json"
    }
}