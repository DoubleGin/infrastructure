provider "kubernetes" {
  config_context = "gke_oddmark-stage_us-central1-a_oddmark-stage"
}

provider "google" {
  project = "oddmark-stage"
  region  = "us-central1"
}
