terraform {
  backend "gcs" {
    bucket = "devsecops-tfs"
    prefix = "terraform/state"
  }
}
