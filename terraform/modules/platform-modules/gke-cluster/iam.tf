resource "google_service_account" "cluster_service_account" {
  account_id = "cluster-service-account"
}

resource "google_project_iam_member" "log_writer" {
  role   = "roles/logging.logWriter"
  member = "serviceAccount:${google_service_account.cluster_service_account.email}"
}

resource "google_project_iam_member" "metric_writer" {
  role   = "roles/monitoring.metricWriter"
  member = "serviceAccount:${google_service_account.cluster_service_account.email}"
}

resource "google_project_iam_member" "monitoring_viewer" {
  role   = "roles/monitoring.viewer"
  member = "serviceAccount:${google_service_account.cluster_service_account.email}"
}
