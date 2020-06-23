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
