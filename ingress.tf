# resource "kubernetes_ingress" "dashboard" {
#   metadata {
#     name      = "${var.name}-dashboard-ingress"
#     namespace = "kubernetes-dashboard"
#     annotations = {
#       "kubernetes.io/ingress.class"            = "nginx"
#       "networking.gke.io/managed-certificates" = google_compute_managed_ssl_certificate.dashboard.name
#     }
#   }
#   spec {
#     rule {
#       host = google_dns_record_set.dashboard.name

#       http {
#         path {
#           path = "/"
#           backend {
#             service_name = "kubernetes-dashboard"
#             service_port = 80
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_ingress" "jokes" {
#   metadata {
#     name      = "${var.name}-jokes-ingress"
#     namespace = "jokes"
#     annotations = {
#       "kubernetes.io/ingress.class"            = "nginx"
#       "networking.gke.io/managed-certificates" = google_compute_managed_ssl_certificate.jokes.name
#     }
#   }
#   spec {
#     rule {
#       host = google_dns_record_set.jokes.name

#       http {
#         path {
#           path = "/"
#           backend {
#             service_name = "joke-generator-joke-generator"
#             service_port = 5000
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_ingress" "argocd" {
#   metadata {
#     name      = "${var.name}-argocd-ingress"
#     namespace = "argocd"
#     annotations = {
#       "kubernetes.io/ingress.class"            = "nginx"
#       "networking.gke.io/managed-certificates" = google_compute_managed_ssl_certificate.argocd.name
#     }
#   }
#   spec {
#     rule {
#       host = google_dns_record_set.argocd.name

#       http {
#         path {
#           path = "/"
#           backend {
#             service_name = "argocd-server"
#             service_port = 80
#           }
#         }
#       }
#     }
#   }
# }

