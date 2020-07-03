# full access to storage and deepspeech transcript buckets
resource "google_storage_bucket_iam_member" "deepspeech_transcripts" {
  bucket = google_storage_bucket.deepspeech_transcripts.name
  role   = "roles/storage.objectAdmin"
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
