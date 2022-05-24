terraform {
  required_version = "=0.15.3"
  backend "gcs" {
    bucket = "oddmark-stage-tf-state"
    prefix = "services/deepworker"
  }
}
