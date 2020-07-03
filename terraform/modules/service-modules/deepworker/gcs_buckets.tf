resource "google_storage_bucket" "deepspeech_transcripts" {
  name          = "oddmark-deepspeech-transcripts-${var.environment}"
  location      = var.region
  force_destroy = true
}
