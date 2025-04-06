resource "google_dns_managed_zone" "devsecops" {
  name        = "devsecops"
  dns_name    = "devsecops.ydvsailendar.com."
  description = "Managed zone for devsecops subdomains"
  project     = data.google_client_config.current.project
}

# resource "google_dns_record_set" "argocd" {
#   name         = "argocd.devsecops.ydvsailendar.com."
#   managed_zone = google_dns_managed_zone.devsecops.name
#   type         = "A"
#   ttl          = 300
#   rrdatas      = [google_container_cluster.k8s.endpoint]
# }

# resource "google_dns_record_set" "jokes" {
#   name         = "jokes.devsecops.ydvsailendar.com."
#   managed_zone = google_dns_managed_zone.devsecops.name
#   type         = "A"
#   ttl          = 300
#   rrdatas      = [google_container_cluster.k8s.endpoint]
# }

# resource "google_dns_record_set" "dashboard" {
#   name         = "dashboard.devsecops.ydvsailendar.com."
#   managed_zone = google_dns_managed_zone.devsecops.name
#   type         = "A"
#   ttl          = 300
#   rrdatas      = [google_container_cluster.k8s.endpoint]
# }
