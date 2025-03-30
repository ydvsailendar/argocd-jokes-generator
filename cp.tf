# cloud platform

resource "google_service_account" "sa" {
  account_id   = "${var.name}-sa"
  display_name = var.name
  disabled     = false
  project      = data.google_client_config.current.project
}

resource "google_project_iam_member" "k8s" {
  project = data.google_client_config.current.project
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "kubernetes_service_account" "k8s" {
  metadata {
    name      = "gke-image-puller"
    namespace = var.namespace
    annotations = {
      "iam.gke.io/gcp-service-account" = "${google_service_account.sa.email}"
    }
  }
}

resource "google_service_account_iam_binding" "k8s" {
  service_account_id = google_service_account.sa.id
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${data.google_client_config.current.project}.svc.id.goog[${var.namespace}/gke-image-puller]"
  ]
}
