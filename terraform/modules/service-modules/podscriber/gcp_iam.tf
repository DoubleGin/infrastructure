# grant full access to our own GCS buckets
resource "google_storage_bucket_iam_member" "buckets_object_admin" {
  for_each = toset(var.bucket_names)
  bucket   = google_storage_bucket.buckets[each.value].name
  role     = "roles/storage.objectAdmin"
  member   = "serviceAccount:${var.gcp_sa_email}"
}

resource "google_storage_bucket_iam_member" "buckets_legacy_reader" {
  for_each = toset(var.bucket_names)
  bucket   = google_storage_bucket.buckets[each.value].name
  role     = "roles/storage.legacyBucketReader"
  member   = "serviceAccount:${var.gcp_sa_email}"
}

# grant access to fetch secrets from secret manager
resource "google_project_iam_custom_role" "secret_reader" {
  role_id     = "secretReader"
  title       = "secretReader"
  permissions = ["secretmanager.versions.access"]
}

resource "google_secret_manager_secret_iam_member" "secret_reader" {
  #TODO: look this id up with a data resource whenever they add one
  # https://www.terraform.io/docs/providers/google/d/datasource_google_secret_manager_secret_version.html
  secret_id = "projects/oddmark-stage/secrets/podscriber-worker"
  role      = google_project_iam_custom_role.secret_reader.id
  member    = "serviceAccount:${var.gcp_sa_email}"
}

# grant access to sign blobs (used for creating GCS signed URLs)
resource "google_project_iam_custom_role" "blob_signer" {
  role_id     = "blobSigner"
  title       = "blobSigner"
  permissions = ["iam.serviceAccounts.signBlob"]
}

resource "google_project_iam_member" "blob_signer" {
  role   = google_project_iam_custom_role.blob_signer.id
  member = "serviceAccount:${var.gcp_sa_email}"
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
