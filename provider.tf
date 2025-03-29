terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.23.0"
    }
  }
}

provider "google" {
  project = "devsecops-452321"
  region  = "europe-west2"
  zone    = "europe-west2-a"
}
