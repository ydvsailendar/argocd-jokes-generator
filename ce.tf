# resource "google_compute_managed_ssl_certificate" "argocd" {
#   name = "argocd-ssl-cert"
#   managed {
#     domains = [
#       google_dns_record_set.argocd.name
#     ]
#   }
# }

# resource "google_compute_managed_ssl_certificate" "dashboard" {
#   name = "dashboard-ssl-cert"
#   managed {
#     domains = [
#       google_dns_record_set.dashboard.name
#     ]
#   }
# }

# resource "google_compute_managed_ssl_certificate" "jokes" {
#   name = "jokes-ssl-cert"
#   managed {
#     domains = [
#       google_dns_record_set.jokes.name
#     ]
#   }
# }
