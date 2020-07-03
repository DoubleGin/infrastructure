terraform {
  required_version = "=0.12.26"
  backend "gcs" {
    bucket = "oddmark-stage-tf-state"
    prefix = "services/deepworker"
  }
}
