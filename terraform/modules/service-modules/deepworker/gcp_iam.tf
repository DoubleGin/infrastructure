# full access to deepspeech buckets
resource "google_storage_bucket_iam_member" "deepspeech_transcripts" {
  bucket = google_storage_bucket.deepspeech_transcripts.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.gcp_sa_email}"
}

resource "google_storage_bucket_iam_member" "deepspeech_models" {
  bucket = google_storage_bucket.deepspeech_models.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.gcp_sa_email}"
}

# accesss to podcast media bucket
resource "google_storage_bucket_iam_member" "podcast_media" {
  bucket = var.podcast_media_gcs_bucket
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.gcp_sa_email}"
}

# grant access to sign blobs (used for creating GCS signed URLs)
resource "google_project_iam_custom_role" "blob_signer" {
  role_id     = "deepworkerBlobSigner"
  title       = "deepworkerBlobSigner"
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
