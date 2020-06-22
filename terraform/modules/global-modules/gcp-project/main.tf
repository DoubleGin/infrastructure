data "google_billing_account" "billing" {
  display_name = "oddmark-global"
}

resource "google_project" "project" {
  name            = "${var.name}-${var.environment}"
  project_id      = "${var.name}-${var.environment}"
  billing_account = data.google_billing_account.billing.id
}

resource "google_storage_bucket" "terraform_state" {
  project  = google_project.project.project_id
  name     = "${var.name}-${var.environment}-tf-state"
  location = "us-central1"
  versioning {
    enabled = true
  }
}

resource "google_project_service" "project" {
  for_each           = var.apis
  project            = google_project.project.project_id
  service            = each.value
  disable_on_destroy = true
}
