resource "google_storage_bucket" "transcripts" {
  name          = "oddmark-transcripts-${var.environment}"
  location      = var.region
  force_destroy = true
}

resource "google_storage_bucket" "podcasts" {
  name          = "oddmark-podcasts-${var.environment}"
  location      = var.region
  force_destroy = true
}

resource "google_storage_bucket" "excerpts" {
  name          = "oddmark-excerpts-${var.environment}"
  location      = var.region
  force_destroy = true
}

resource "google_storage_bucket" "static" {
  name          = "oddmark-static-assets-${var.environment}"
  location      = var.region
  force_destroy = true
}
