terraform {
  backend "gcs" {
    bucket = "oddmark-global-tf-state"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    google-beta = {
      source = "hashicorp/google"
    }
  }
}
