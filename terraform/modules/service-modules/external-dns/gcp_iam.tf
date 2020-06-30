data "google_project" "project" {}

resource "google_project_iam_member" "external_dns" {
  project = data.google_project.project.name
  role    = "roles/dns.admin"
  member  = "serviceAccount:${var.gcp_sa_email}"
}
