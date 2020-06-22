terraform {
  required_version = "=0.12.26"
  backend "gcs" {
    bucket = "oddmark-global-tf-state"
  }
}
