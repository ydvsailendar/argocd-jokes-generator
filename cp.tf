# cloud platform

resource "google_service_account" "sa" {
  account_id   = "${var.name}-sa"
  display_name = var.name
  disabled     = false
  project      = data.google_client_config.current.project
}
