data "google_project" "project" {}

resource "google_service_account" "sa" {
  account_id   = var.name
  display_name = var.name
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.name
  }
}

resource "google_service_account_iam_binding" "binding" {
  service_account_id = google_service_account.sa.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${data.google_project.project.project_id}.svc.id.goog[${var.name}/${var.name}]"
  ]
}

resource "kubernetes_service_account" "sa" {
  automount_service_account_token = true
  metadata {
    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.sa.email
    }

    name      = var.name
    namespace = var.name
  }
}
