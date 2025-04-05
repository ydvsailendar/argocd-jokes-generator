# kubernetes (container) engine

resource "google_container_cluster" "k8s" {
  name                     = "${var.name}-cluster"
  location                 = data.google_client_config.current.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false
  node_config {
    disk_size_gb = 50
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  workload_identity_config {
    workload_pool = "${data.google_client_config.current.project}.svc.id.goog"
  }
  lifecycle {
    ignore_changes = [node_config]
  }
}

resource "google_container_node_pool" "k8s" {
  name     = "${var.name}-node-pool"
  location = data.google_client_config.current.zone
  cluster  = google_container_cluster.k8s.name
  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }
  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    disk_size_gb = 50
    disk_type    = "pd-standard"

    service_account = google_service_account.sa.email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "kubernetes_namespace" "jokes" {
  metadata {
    name = var.namespace
  }
  depends_on = [google_container_cluster.k8s, google_container_node_pool.k8s]
}
