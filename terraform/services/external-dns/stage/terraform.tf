terraform {
  backend "gcs" {
    bucket = "oddmark-stage-tf-state"
    prefix = "services/external-dns"
  }
}
