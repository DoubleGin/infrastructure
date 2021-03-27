terraform {
  backend "gcs" {
    bucket = "oddmark-stage-tf-state"
  }
}
