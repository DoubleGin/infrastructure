# grant access to read static assets bucket
resource "google_project_iam_custom_role" "static_asset_reader" {
  role_id     = "staticAssetReader"
  title       = "staticAssetReader"
  permissions = ["storage.objects.get"]
}


resource "google_storage_bucket_iam_member" "static_asset_reader" {
  bucket = google_storage_bucket.static.name
  role   = google_project_iam_custom_role.static_asset_reader.id
  member = "serviceAccount:${var.gcp_sa_email}"
}

# grant access to fetch secrets from secret manager
resource "google_project_iam_custom_role" "secret_reader" {
  role_id     = "secretReader"
  title       = "secretReader"
  permissions = ["secretmanager.versions.access"]
}

resource "google_secret_manager_secret_iam_member" "member" {
  #TODO: look this id up with a data resource whenever they add one
  # https://www.terraform.io/docs/providers/google/d/datasource_google_secret_manager_secret_version.html
  secret_id = "projects/oddmark-stage/secrets/podscriber-worker"
  role      = google_project_iam_custom_role.secret_reader.id
  member    = "serviceAccount:${var.gcp_sa_email}"
}

# grant access to write stackdriver logs (used by istio sidecar)
resource "google_project_iam_member" "log_writer" {
  role   = "roles/logging.logWriter"
  member = "serviceAccount:${var.gcp_sa_email}"
}

# grant access to write stackdriver metrics (used by istio sidecar)
resource "google_project_iam_member" "metric_writer" {
  role   = "roles/monitoring.metricWriter"
  member = "serviceAccount:${var.gcp_sa_email}"
}
