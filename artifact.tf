resource "google_artifact_registry_repository" "joke" {
  location      = data.google_client_config.current.region
  repository_id = "${var.name}-joke"
  description   = "joke app repository"
  format        = "DOCKER"
}
