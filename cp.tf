# cloud platform

resource "google_service_account" "sa" {
  account_id   = "${var.name}-sa"
  display_name = var.name
  disabled     = false
  project      = data.google_client_config.current.project
}

resource "google_service_account" "artifactory" {
  account_id   = "${var.name}-artifactory-sa"
  display_name = "${var.name}-artifactory"
  disabled     = false
  project      = data.google_client_config.current.project
}

resource "google_project_iam_binding" "artifactory" {
  project = data.google_client_config.current.project
  role    = "roles/artifactregistry.reader"
  members = [
    "serviceAccount:${google_service_account.artifactory.email}"
  ]
}

resource "kubernetes_service_account" "k8s" {
  metadata {
    name      = "gke-image-puller"
    namespace = var.namespace
    annotations = {
      "iam.gke.io/gcp-service-account" = "artifact-registry-sa@${data.google_client_config.current.project}.iam.gserviceaccount.com"
    }
  }
}

resource "google_service_account_iam_binding" "k8s" {
  service_account_id = google_service_account.artifactory.id
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${data.google_client_config.current.project}.svc.id.goog[${var.namespace}/gke-image-puller]"
  ]
}
