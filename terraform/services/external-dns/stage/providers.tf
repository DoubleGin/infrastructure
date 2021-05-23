provider "google" {
  project = "oddmark-stage"
  region  = "us-central1"
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "gke_oddmark-stage_us-central1-a_oddmark-stage"
}
