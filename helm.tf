# resource "helm_release" "dashboard" {
#   name             = "kubernetes-dashboard"
#   namespace        = "kubernetes-dashboard"
#   repository       = "https://kubernetes.github.io/dashboard"
#   chart            = "kubernetes-dashboard"
#   version          = "7.11.1"
#   create_namespace = true

#   values = [
#     <<-EOT
#     ingress:
#       enabled: true
#       hosts:
#         - "${google_dns_record_set.dashboard.name}"
#       annotations:
#         nginx.ingress.kubernetes.io/rewrite-target: /
#         nginx.ingress.kubernetes.io/secure-backends: "true"
#         nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
#         networking.gke.io/managed-certificates: "${google_compute_managed_ssl_certificate.dashboard.name}"
#     EOT
#   ]
# }

# resource "helm_release" "argocd" {
#   name             = "argocd"
#   namespace        = "argocd"
#   repository       = "https://argoproj.github.io/argo-helm"
#   chart            = "argo-cd"
#   version          = "7.8.15"
#   create_namespace = true
#   values = [
#     <<-EOT
#     ingress:
#       enabled: true
#       hosts:
#         - "${google_dns_record_set.argocd.name}"
#       annotations:
#         nginx.ingress.kubernetes.io/rewrite-target: /
#         nginx.ingress.kubernetes.io/secure-backends: "true"
#         nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
#         networking.gke.io/managed-certificates: "${google_compute_managed_ssl_certificate.argocd.name}"
#     EOT
#   ]
# }

# resource "helm_release" "nginx" {
#   name             = "nginx-ingress"
#   namespace        = "kube-system"
#   chart            = "ingress-nginx/ingress-nginx"
#   version          = "4.12.1"
#   create_namespace = true
# }
