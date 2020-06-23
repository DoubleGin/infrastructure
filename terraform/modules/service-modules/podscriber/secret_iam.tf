resource "google_project_iam_custom_role" "secret_reader" {
  role_id     = "secretReader"
  title       = "secretReader"
  permissions = ["secretmanager.versions.access"]
}

resource "google_secret_manager_secret_iam_member" "member" {
  #TODO: look this up with a data resource whenever they add one
  # https://www.terraform.io/docs/providers/google/d/datasource_google_secret_manager_secret_version.html
  secret_id = "projects/oddmark-stage/secrets/podscriber-worker"
  role   = google_project_iam_custom_role.secret_reader.id
  member = "serviceAccount:${var.gcp_sa_email}"
}
