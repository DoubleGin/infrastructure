output "k8s_namespace" {
  value = kubernetes_namespace.namespace.metadata.0.name
}

output "gcp_sa_email" {
  value = google_service_account.sa.email
}
