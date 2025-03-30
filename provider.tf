terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.23.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.36.0"
    }
  }
}

provider "google" {
  project = "devsecops-452321"
  region  = "europe-west2"
  zone    = "europe-west2-a"
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.k8s.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.k8s.master_auth.0.cluster_ca_certificate)
  token                  = data.google_client_config.current.access_token
}
