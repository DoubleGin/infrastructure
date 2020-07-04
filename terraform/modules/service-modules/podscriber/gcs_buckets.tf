resource "google_storage_bucket" "buckets" {
  for_each      = toset(var.bucket_names)
  name          = "oddmark-${each.value}-${var.environment}"
  location      = var.region
  force_destroy = true
}
